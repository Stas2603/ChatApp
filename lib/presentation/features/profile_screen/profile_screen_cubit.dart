import 'package:chat_app_test/presentation/features/profile_screen/profile_screen_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit() : super(const ProfileScreenState());

  void initParams(String? id) async {
    searchOtherUser(id);
  }

  void searchOtherUser(String? id) async {
    String name = 'No result';
    try {
      final ref = FirebaseDatabase.instance.ref("users/$id/name");
      final snapshot = await ref.get();

      if (snapshot.exists) {
        name = snapshot.value.toString();
        emit(
          state.copyWith(searchUserId: id, searchUserName: name),
        );
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }
}
