import 'dart:convert';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;

  const User({
    required this.name,
  });

  @override
  List<Object?> get props => [name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
