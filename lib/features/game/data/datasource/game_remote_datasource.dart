import 'dart:async';
import 'dart:developer';

import 'package:chronicle/core/api/api_config.dart';
import 'package:chronicle/features/game/domain/model/game_phase.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';
import 'package:chronicle/features/game/domain/model/story_fragment_model.dart';
import 'package:chronicle/features/game/domain/repository/game_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameRemoteDatasource {
  IO.Socket? _socket;
  Timer? _reconnectTimer;
  bool _isReconnecting = false;

  Future<void> joinGame(
      {required String gameCode,
      required GameUpdateCallback onUpdate,
      required ErrorCallback onError,
      required KickedCallback onKicked,
      required LeftCallback onLeft}) async {
    await _disconnectSocket();
    await _initializeSocket(onUpdate: onUpdate, onError: onError,onKicked: onKicked,onLeft: onLeft);
    _socket?.connect();
    _socket?.emit('joinGameByCode', gameCode);
  }

  Future<void> startGame(String gameId) async {
    _socket?.emit('startGame', gameId);
  }

  Future<void> cancelGame(String gameId) async {
    _socket?.emit('cancelGame', gameId);
  }

  Future<void> leaveGame(String gameId) async {
    _socket?.emit('leaveGame', gameId);
  }

  Future<void> kickParticipant(String gameId, String userId) async {
    _socket
        ?.emit('kickParticipant', {'gameId': gameId, 'participantId': userId});
  }

  Future<void> submitText(String gameId,String text) async {
    _socket?.emit('submitText',{
      'gameId' : gameId,
      'text' : text,
    });
  }
  Future<void> submitVote(String gameId,String userId) async {
    _socket?.emit('submitVote',{
      'gameId' : gameId,
      'votedFor' : userId,
    });
  }

  Future<void> _initializeSocket(
      {required GameUpdateCallback onUpdate,
        required ErrorCallback onError,
        required KickedCallback onKicked,
        required LeftCallback onLeft}) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final socketOptions = IO.OptionBuilder()
        .setExtraHeaders({'Authorization': token})
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build();

    _socket = IO.io(ApiConfig.BASE_URL, socketOptions);

    _socket?.onConnect((v) {
      _isReconnecting = false;
      _reconnectTimer?.cancel();
    });

    _socket?.onDisconnect((v) {
      _attemptReconnect(onUpdate: onUpdate, onError: onError);
    });

    _socket?.onConnectError((error) {
      _attemptReconnect(onUpdate: onUpdate, onError: onError);
    });

    _socket?.on(
        'gameStateUpdate',
        (data) => _handleGameStateUpdate(
            data: data, onUpdate: onUpdate, onError: onError));

    _socket?.on('error', (data) {
      onError.call(data['error']);
    });

    _socket?.on('kicked', (data) {
      onKicked.call();
    });

    _socket?.on('leftGame', (data) {
      onLeft.call();
    });
  }

  void _handleGameStateUpdate(
      {required Map<String, dynamic> data,
      required GameUpdateCallback onUpdate,
      required ErrorCallback onError}) {
    log('Data received : $data');
    final phase = GamePhase.values.firstWhere((e) => e.name == data['phase']);

    final participants = (data['participants'] as List)
        .map((e) => ParticipantModel.fromJson(e))
        .toList();

    final history = (data['history'] as List)
        .map((e) => StoryFragmentModel.fromJson(e))
        .toList();

    onUpdate.call(
        name: data['name'],
        gameCode: data['gameCode'],
        phase: phase,
        currentRound: data['currentRound'],
        rounds: data['maxRounds'],
        roundTime: data['roundTime'],
        votingTime: data['voteTime'],
        remainingTime: data['remainingTime'],
        gameId: data['id'],
        participants: participants,
        history: history,
        maxParticipants: data['maxPlayers']);
  }

  void _attemptReconnect(
      {required GameUpdateCallback onUpdate, required ErrorCallback onError}) {
    if (_isReconnecting) return;
    _isReconnecting = true;

    _reconnectTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        _socket?.connect();
        if (_socket?.connected == true) {
          timer.cancel();
          _isReconnecting = false;
        }
      } catch (e) {
        onError.call('Reconnection failed');
      }
    });
  }

  Future<void> _disconnectSocket() async {
    try {
      _reconnectTimer?.cancel();
      _socket?.clearListeners();
      _socket?.disconnect();
    } catch (e) {
      log('Error disconnecting socket :$e');
    }
  }
}
