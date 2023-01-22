import 'dart:convert';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final DateTime date;
  final String id;
  final String message;

  const Message({
    this.id = '',
    required this.message,
    required this.date,
  });

  @override
  List<Object?> get props => [date, id, message];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'id': id,
      'message': message,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      id: map['id'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
