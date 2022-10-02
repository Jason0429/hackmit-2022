// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recycle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecycleResponse _$RecycleResponseFromJson(Map<String, dynamic> json) =>
    RecycleResponse(
      item: json['item'] as String,
      category: json['category'] as String,
      instruction: json['instruction'] as String,
    );

Map<String, dynamic> _$RecycleResponseToJson(RecycleResponse instance) =>
    <String, dynamic>{
      'item': instance.item,
      'category': instance.category,
      'instruction': instance.instruction,
    };
