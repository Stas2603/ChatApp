import 'dart:convert';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final DateTime date;
  final String profession;

  const User({
    required this.name,
    required this.date,
    required this.profession,
  });

  @override
  List<Object?> get props => [name, date, profession];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'profession': profession,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      profession: map['profession'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
