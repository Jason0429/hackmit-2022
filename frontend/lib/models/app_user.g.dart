// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
      totalItemsRecycled: json['totalItemsRecycled'] as int,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'email': instance.email,
      'friends': instance.friends,
      'totalItemsRecycled': instance.totalItemsRecycled,
    };
