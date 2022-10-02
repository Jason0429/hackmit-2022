import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  final String id;
  final DateTime createdOn;
  final String imageUrl;
  final String itemName;
  final String category;
  final bool recycled;

  Activity({
    required this.id,
    required this.createdOn,
    required this.imageUrl,
    required this.itemName,
    required this.recycled,
    required this.category,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
