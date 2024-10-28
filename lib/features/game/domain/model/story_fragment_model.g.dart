// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_fragment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryFragmentModel _$StoryFragmentModelFromJson(Map<String, dynamic> json) =>
    StoryFragmentModel(
      text: json['text'] as String,
      author: ParticipantModel.fromJson(json['author'] as Map<String, dynamic>),
      votes: (json['votes'] as num).toInt(),
    );

Map<String, dynamic> _$StoryFragmentModelToJson(StoryFragmentModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'author': instance.author,
      'votes': instance.votes,
    };
