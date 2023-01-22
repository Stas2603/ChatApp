import 'package:chat_app_test/data/shared_preferances/app_preferances.dart';
import 'package:chat_app_test/presentation/features/chat_screen/chat_screen_state.dart';
import 'package:chat_app_test/view_models/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  ChatScreenCubit({required this.appPreferences})
      : super(const ChatScreenState());

  final AppPreferences appPreferences;

  void initParams(String userId) async {
    final myId = appPreferences.getString('userId');
    emit(state.copyWith(myId: myId, userId: userId));
    findOrCreateChatRoom();
    final name = appPreferences.getString('name');
    emit(state.copyWith(name: name));
    await takeLastUserSeen(state.userId);
  }

  void sendMessage(String text, DateTime date) async {
    final message = Message(
      id: state.myId,
      message: text,
      date: date,
    ).toMap();

    findOrCreateChatRoom();

    try {
      if (state.path == "chatRoom/${state.myId}-${state.userId}") {
        final ref = FirebaseDatabase.instance
            .ref("chatRoom/${state.myId}-${state.userId}");
        DatabaseReference newRef = ref.push();
        String? newKey = newRef.key;
        final reference = FirebaseDatabase.instance
            .ref("chatRoom/${state.myId}-${state.userId}/$newKey");
        reference.set(message);
      } else {
        final ref = FirebaseDatabase.instance
            .ref("chatRoom/${state.userId}-${state.myId}");
        DatabaseReference newRef = ref.push();
        String? newKey = newRef.key;
        final reference = FirebaseDatabase.instance
            .ref("chatRoom/${state.userId}-${state.myId}/$newKey");
        reference.set(message);
      }
    } catch (e) {
      print(e);
    }
  }

  void findOrCreateChatRoom() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("chatRoom/");
    final snapshot = await ref.get();
    String name = '';

    if (snapshot.exists) {
      name = snapshot.value.toString();
    } else {
      print('No data available.');
    }

    if (name.contains("${state.userId}-${state.myId}")) {
      String ref = "chatRoom/${state.userId}-${state.myId}";
      emit(state.copyWith(path: ref));
    } else {
      String ref = "chatRoom/${state.myId}-${state.userId}";
      emit(state.copyWith(path: ref));
    }
  }

  Future<void> takeLastUserSeen(String id) async {
    final ref = FirebaseDatabase.instance.ref("users/$id/date");
    final snapshot = await ref.get();

    if (snapshot.exists) {
      String date = snapshot.value.toString();
      print(date);
      emit(
        state.copyWith(lastSeen: date),
      );
    } else {
      return;
    }
  }
}
