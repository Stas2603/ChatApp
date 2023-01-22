import 'package:chat_app_test/presentation/widgets/triangle_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget myListTileWidget(
  String text,
  double height,
  double width,
  DateTime date,
) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: width * 0.4,
            maxWidth: width * 0.7,
            minHeight: height * 0.05,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff007AFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
                topLeft: Radius.circular(6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateFormat('hh:mm a').format(date),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        RotatedBox(
          quarterTurns: 6,
          child: ClipPath(
            clipper: Triangle(),
            child: Container(
              height: 20,
              width: 20,
              color: const Color(0xff007AFF),
            ),
          ),
        ),
      ],
    ),
  );
}
