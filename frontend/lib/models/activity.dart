import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  final DateTime createdOn;
  final String imageUrl;
  final String itemName;
  final bool recycled;

  Activity({
    required this.createdOn,
    required this.imageUrl,
    required this.itemName,
    required this.recycled,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
