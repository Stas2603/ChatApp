import 'package:chat_app_test/presentation/features/app_resources/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showInputDialog(
  BuildContext context,
  String title,
  TextEditingController controller,
  void Function()? onPressed,
) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onPressed,
              child: Text(LocaleKeys.ok.tr()),
            ),
          ],
        );
      });
}
