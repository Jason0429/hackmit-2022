// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_vision_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleVisionObject _$GoogleVisionObjectFromJson(Map<String, dynamic> json) =>
    GoogleVisionObject(
      name: json['name'] as String,
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$GoogleVisionObjectToJson(GoogleVisionObject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'score': instance.score,
    };
