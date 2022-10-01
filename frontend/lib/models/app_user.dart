import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final String uid;
  final String username;
  final String email;
  final List<String> friends;
  final double totalRecycledWeight;

  AppUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.friends,
    required this.totalRecycledWeight,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
