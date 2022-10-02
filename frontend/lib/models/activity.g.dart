// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      createdOn: DateTime.parse(json['createdOn'] as String),
      imageUrl: json['imageUrl'] as String,
      itemName: json['itemName'] as String,
      recycled: json['recycled'] as bool,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'createdOn': instance.createdOn.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'itemName': instance.itemName,
      'recycled': instance.recycled,
    };
