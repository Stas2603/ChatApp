import 'package:chat_app_test/domain/entity/user.dart';
import 'package:chat_app_test/presentation/features/welcome_screen/welcome_screen_state.dart';
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

    emit(state.copyWith(id: userId, name: name));
  }

  Future<void>? addUser() async {
    final userId = appPreferences.getString('userId');
    if (userId == null) {
      try {
        const user = User(name: 'User');

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
    DatabaseReference reference =
        FirebaseDatabase.instance.ref("users/$newKey");
    reference.set(user.toMap());
    appPreferences.putString('userId', newKey!);
  }

  void _takeUserInfo(String? id) async {
    final ref = FirebaseDatabase.instance.ref("users/$id/name");
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

    DatabaseReference reference =
        FirebaseDatabase.instance.ref("users/$userId");
    reference.update({"name": name});
    await appPreferences.putString('name', name);
    emit(state.copyWith(name: name));
  }
}
