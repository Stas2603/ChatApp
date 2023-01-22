import 'package:chat_app_test/presentation/widgets/triangle_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget otherUserListTileWidget(
  String text,
  String name,
  String profession,
  double height,
  double width,
  DateTime date,
  Widget buildCircleAvatar,
) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCircleAvatar,
        RotatedBox(
          quarterTurns: 3,
          child: ClipPath(
            clipper: Triangle(),
            child: Container(
              height: 20,
              width: 20,
              color: const Color(0xffF2F2F7),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: width * 0.4,
            maxWidth: width * 0.7,
            minHeight: height * 0.05,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xffF2F2F7),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        profession,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Color(0xff666668),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
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
        )
      ],
    ),
  );
}
