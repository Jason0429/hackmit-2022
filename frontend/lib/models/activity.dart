import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  final DateTime createdOn;
  final String imageUrl;
  final String itemName;
  final bool recycled;
  final double weight; // grams

  Activity({
    required this.createdOn,
    required this.imageUrl,
    required this.itemName,
    required this.recycled,
    required this.weight,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
