// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
      imageUrl: json['imageUrl'] as String,
      itemName: json['itemName'] as String,
      recycled: json['recycled'] as bool,
      category: json['category'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'createdOn': instance.createdOn.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'itemName': instance.itemName,
      'category': instance.category,
      'recycled': instance.recycled,
    };
