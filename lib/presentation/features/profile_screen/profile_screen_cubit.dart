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
      final refName = FirebaseDatabase.instance.ref("users/$id/name");
      final snapshotName = await refName.get();

      if (snapshotName.exists) {
        name = snapshotName.value.toString();
        emit(
          state.copyWith(searchUserId: id, searchUserName: name),
        );
      } else {
        return;
      }

      final refDate = FirebaseDatabase.instance.ref("users/$id/date");
      final snapshotDate = await refDate.get();

      if (snapshotDate.exists) {
        String date = snapshotDate.value.toString();
        emit(
          state.copyWith(searchUserDate: date),
        );
      } else {
        return;
      }

      final refProfession =
          FirebaseDatabase.instance.ref("users/$id/profession");
      final snapshotProfession = await refProfession.get();

      if (snapshotProfession.exists) {
        String profession = snapshotProfession.value.toString();
        emit(
          state.copyWith(searchUserProfession: profession),
        );
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }
}
