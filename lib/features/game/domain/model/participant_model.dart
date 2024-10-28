import 'package:json_annotation/json_annotation.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
  final String id;
  final String name;
  final String photoUrl;
  final String? text;
  final bool isCreator;
  final bool hasSubmitted;

  ParticipantModel(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.text,
      required this.isCreator,
      required this.hasSubmitted});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}
