// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_vision_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleVisionResponse _$GoogleVisionResponseFromJson(
        Map<String, dynamic> json) =>
    GoogleVisionResponse(
      objects: (json['objects'] as List<dynamic>)
          .map((e) => GoogleVisionObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoogleVisionResponseToJson(
        GoogleVisionResponse instance) =>
    <String, dynamic>{
      'objects': instance.objects,
    };
