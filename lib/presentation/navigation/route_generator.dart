import 'package:chat_app_test/presentation/features/profile_screen/profile_screen_view.dart';
import 'package:chat_app_test/presentation/features/welcome_screen/welcome_screen_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreenView(),
        );
      case '/profile':
        String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ProfileScreenView(searchUserId: id),
        );
    }
    return routeExeption();
  }
}

Route routeExeption() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(child: Text('Error')),
    );
  });
}
