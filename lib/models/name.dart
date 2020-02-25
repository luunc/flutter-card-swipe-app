import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'name.g.dart';

@JsonSerializable()
class Name extends Equatable {
  final String title;
  final String first;
  final String last;

  Name({
    @required this.title,
    @required this.first,
    @required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);

  @override
  List<Object> get props => [title, first, last];
}
