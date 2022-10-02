import 'package:json_annotation/json_annotation.dart';

part 'google_vision_object.g.dart';

@JsonSerializable()
class GoogleVisionObject {
  final String name;
  final double score;

  GoogleVisionObject({
    required this.name,
    required this.score,
  });

  factory GoogleVisionObject.fromJson(Map<String, dynamic> json) =>
      _$GoogleVisionObjectFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleVisionObjectToJson(this);
}
