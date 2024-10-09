// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_01.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User01 _$User01FromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['email'],
  );
  return User01(
    json['name'] as String? ?? 'Unknown',
    json['email'] as String,
    json['diachi'] as String,
  );
}

Map<String, dynamic> _$User01ToJson(User01 instance) => <String, dynamic>{
      'diachi': instance.address,
      'email': instance.email,
      'name': instance.name,
    };
