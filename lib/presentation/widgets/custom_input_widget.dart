import 'package:chat_app_test/presentation/features/app_resources/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget(
      {Key? key, required this.textEditingController, required this.onTap})
      : super(key: key);

  final TextEditingController textEditingController;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SizedBox(
        height: 66.0,
        width: 323.0,
        child: TextFormField(
          maxLines: null,
          minLines: null,
          expands: true,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: LocaleKeys.enterChatId.tr(),
            hintStyle: GoogleFonts.inter(
              textStyle: const TextStyle(fontSize: 20.0),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/arrow.png',
                  width: 23.93,
                  height: 20.37,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 32.0),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
