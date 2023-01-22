import 'package:chat_app_test/view_models/message.dart';
import 'package:equatable/equatable.dart';

class ChatScreenState extends Equatable {
  const ChatScreenState({
    this.myId = '',
    this.userId = '',
    this.path = '',
    this.list = const [],
    this.name = '',
    this.profession = '',
    this.avatar = '',
    this.lastSeen = '',
  });

  final String myId;
  final String userId;
  final String path;
  final List<Message> list;
  final String name;
  final String profession;
  final String avatar;
  final String lastSeen;

  @override
  List<Object> get props => [
        myId,
        userId,
        path,
        list,
        name,
        profession,
        avatar,
        lastSeen,
      ];

  ChatScreenState copyWith({
    String? myId,
    String? userId,
    String? path,
    List<Message>? list,
    String? name,
    String? profession,
    String? avatar,
    String? lastSeen,
  }) {
    return ChatScreenState(
      myId: myId ?? this.myId,
      userId: userId ?? this.userId,
      path: path ?? this.path,
      list: list ?? this.list,
      name: name ?? this.name,
      profession: profession ?? this.profession,
      avatar: avatar ?? this.avatar,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}
