// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    gender: json['gender'] as String,
    name: json['name'] == null
        ? null
        : Name.fromJson(json['name'] as Map<String, dynamic>),
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    email: json['email'] as String,
    dob: json['dob'] as String,
    picture: json['picture'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'gender': instance.gender,
      'name': instance.name?.toJson(),
      'location': instance.location?.toJson(),
      'email': instance.email,
      'dob': instance.dob,
      'picture': instance.picture,
    };
