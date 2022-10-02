import 'package:json_annotation/json_annotation.dart';
import 'package:project/models/google_vision_object.dart';

part "google_vision_response.g.dart";

@JsonSerializable()
class GoogleVisionResponse {
  final List<GoogleVisionObject> objects;

  GoogleVisionResponse({required this.objects});

  factory GoogleVisionResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleVisionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleVisionResponseToJson(this);
}
