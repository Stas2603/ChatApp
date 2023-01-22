import 'package:chat_app_test/presentation/features/welcome_screen/welcome_screen_state.dart';
import 'package:chat_app_test/view_models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/shared_preferances/app_preferances.dart';

class WelcomeScreenCubit extends Cubit<WelcomeScreenState> {
  WelcomeScreenCubit({required this.appPreferences})
      : super(const WelcomeScreenState());

  final AppPreferences appPreferences;

  void initParams() async {
    await addUser();

    final userId = appPreferences.getString('userId');
    final name = appPreferences.getString('name');
    final profession = appPreferences.getString('profession');

    emit(
      state.copyWith(
        id: userId,
        name: name,
        profession: profession,
      ),
    );
    _lastTimeEnter();
  }

  Future<void>? addUser() async {
    final userId = appPreferences.getString('userId');
    if (userId == null) {
      try {
        final user = User(name: 'User', date: DateTime.now(), profession: '');

        DatabaseReference ref = FirebaseDatabase.instance.ref("users/");
        DatabaseReference newRef = ref.push();
        String? newKey = newRef.key;
        emit(state.copyWith(id: newKey));

        _addNewUser(user, newKey);

        _takeUserInfo(newKey);
      } catch (e) {
        print(e);
      }
      return;
    } else {
      return;
    }
  }

  void _addNewUser(User user, String? newKey) {
    try {
      DatabaseReference reference =
          FirebaseDatabase.instance.ref("users/$newKey");
      reference.set(user.toMap());
      appPreferences.putString('userId', newKey!);
    } catch (e) {
      print(e);
    }
  }

  void _takeUserInfo(String? id) async {
    final ref = FirebaseDatabase.instance.ref("users/$id/name/");
    final snapshot = await ref.get();

    if (snapshot.exists) {
      String name = snapshot.value.toString();
      await appPreferences.putString('name', name);
      emit(state.copyWith(name: name));
    } else {
      print('No data available.');
    }
  }

  void onChangeName(String name) async {
    final userId = appPreferences.getString('userId');
    try {
      DatabaseReference reference =
          FirebaseDatabase.instance.ref("users/$userId");
      reference.update({"name": name});
      await appPreferences.putString('name', name);
      emit(state.copyWith(name: name));
    } catch (e) {
      print(e);
    }
  }

  void onChangeProfession(String name) async {
    final userId = appPreferences.getString('userId');
    try {
      DatabaseReference reference =
          FirebaseDatabase.instance.ref("users/$userId");
      reference.update({"profession": name});
      await appPreferences.putString('profession', name);
      emit(state.copyWith(profession: name));
    } catch (e) {
      print(e);
    }
  }

  void _lastTimeEnter() {
    final userId = appPreferences.getString('userId');
    final date = DateTime.now();
    try {
      DatabaseReference reference =
          FirebaseDatabase.instance.ref("users/$userId");
      reference.update({"date": date.millisecondsSinceEpoch});
    } catch (e) {
      print(e);
    }
  }
}
