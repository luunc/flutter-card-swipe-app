import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_tinder/models/name.dart';

import 'location.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person extends Equatable {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final String dob;
  final String picture;

  Person({
    @required this.gender,
    @required this.name,
    @required this.location,
    @required this.email,
    @required this.dob,
    @required this.picture,
  });

  String get fullName => name != null
      ? '${name.title ?? ''} ${name.first ?? ''} ${name.last ?? ''}'
      : 'Unknow';

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  List<Object> get props => [gender, name, location, email, dob, picture];
}
