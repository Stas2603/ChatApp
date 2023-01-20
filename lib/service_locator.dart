import 'package:chat_app_test/data/shared_preferances/app_preferances.dart';
import 'package:chat_app_test/presentation/features/welcome_screen/welcome_screen_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

init() async {
//Bloc
  sl.registerFactory(() => WelcomeScreenCubit(appPreferences: sl()));

//UseCases

//Repository

//External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppPreferences(sharedPreferences));

//Core
}
