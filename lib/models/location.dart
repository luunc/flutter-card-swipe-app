import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  final String street;
  final String city;
  final String state;
  final String zip;

  Location({
    @required this.street,
    @required this.city,
    @required this.state,
    @required this.zip,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object> get props => [street, city, street, zip];
}
