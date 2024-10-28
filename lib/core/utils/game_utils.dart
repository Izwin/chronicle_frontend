import 'package:chronicle/features/auth/domain/model/user_model.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';

class GameUtils{
  static bool isCreator(UserModel user, List<ParticipantModel> participants){
    return user.id == participants.firstWhere((p) => p.isCreator).id;
  }

  static bool hasSubmitted(UserModel user, List<ParticipantModel> participants){
    return participants.firstWhere((t) => t.id == user.id).hasSubmitted;
  }
}