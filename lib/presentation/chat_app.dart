import 'package:chat_app_test/presentation/features/chat_screen/chat_screen_cubit.dart';
import 'package:chat_app_test/presentation/features/profile_screen/profile_screen_cubit.dart';
import 'package:chat_app_test/presentation/features/welcome_screen/welcome_screen_cubit.dart';
import 'package:chat_app_test/presentation/features/welcome_screen/welcome_screen_view.dart';
import 'package:chat_app_test/presentation/navigation/route_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service_locator.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WelcomeScreenCubit>(
            create: (context) => sl<WelcomeScreenCubit>()),
        BlocProvider<ProfileScreenCubit>(
            create: (context) => sl<ProfileScreenCubit>()),
        BlocProvider<ChatScreenCubit>(
            create: (context) => sl<ChatScreenCubit>()),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const WelcomeScreenView(),
      ),
    );
  }
}
