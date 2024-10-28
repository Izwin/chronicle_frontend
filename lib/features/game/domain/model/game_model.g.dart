// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: json['id'] as String,
      gameCode: json['gameCode'] as String,
      name: json['name'] as String,
      voteTime: (json['voteTime'] as num).toInt(),
      roundTime: (json['roundTime'] as num).toInt(),
      isFinished: json['isFinished'] as bool,
      phase: $enumDecode(_$GamePhaseEnumMap, json['phase']),
      currentRound: (json['currentRound'] as num).toInt(),
      maxRounds: (json['maxRounds'] as num).toInt(),
      maxPlayers: (json['maxPlayers'] as num).toInt(),
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => StoryFragmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'id': instance.id,
      'gameCode': instance.gameCode,
      'name': instance.name,
      'isFinished': instance.isFinished,
      'phase': _$GamePhaseEnumMap[instance.phase]!,
      'currentRound': instance.currentRound,
      'maxRounds': instance.maxRounds,
      'voteTime': instance.voteTime,
      'roundTime': instance.roundTime,
      'maxPlayers': instance.maxPlayers,
      'history': instance.history,
      'participants': instance.participants,
    };

const _$GamePhaseEnumMap = {
  GamePhase.waiting: 'waiting',
  GamePhase.writing: 'writing',
  GamePhase.voting: 'voting',
  GamePhase.finished: 'finished',
  GamePhase.canceled: 'canceled',
};
