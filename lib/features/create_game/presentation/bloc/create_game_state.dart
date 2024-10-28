import 'package:equatable/equatable.dart';

enum CreateGameStatus {
  initial,
  error,
  loading,
  success,
}

class CreateGameState extends Equatable{
  final CreateGameStatus status;
  final String? errorMessage;
  final String? createdGameCode;

  const CreateGameState._(
      {required this.status, this.errorMessage, this.createdGameCode});

  factory CreateGameState.initial() => const CreateGameState._(
        status: CreateGameStatus.initial,
      );

  CreateGameState copyWith({
    CreateGameStatus? status,
    String? errorMessage,
    String? createdGameCode,
  }) {
    return CreateGameState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        createdGameCode: createdGameCode ?? this.createdGameCode);
  }

  @override
  List<Object?> get props => [status,errorMessage,createdGameCode];
}
