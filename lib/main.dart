import 'package:chat_app_test/presentation/features/localization/localization_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'presentation/chat_app.dart';
import '../service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(_buildWidgetTree());
}

Widget _buildWidgetTree() {
  return const LocalizationWidget(child: ChatApp());
}
