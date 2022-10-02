import 'package:json_annotation/json_annotation.dart';

part 'recycle_response.g.dart';

@JsonSerializable()
class RecycleResponse {
  final String item;
  final String category;
  final String instruction;

  RecycleResponse({
    required this.item,
    required this.category,
    required this.instruction,
  });

  factory RecycleResponse.fromJson(Map<String, dynamic> json) =>
      _$RecycleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecycleResponseToJson(this);
}
