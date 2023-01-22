import 'package:chat_app_test/presentation/features/profile_screen/profile_screen_cubit.dart';
import 'package:chat_app_test/presentation/features/profile_screen/profile_screen_state.dart';
import 'package:chat_app_test/presentation/widgets/custom_input_widget.dart';
import 'package:chat_app_test/view_models/userParams.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_resources/locale_keys.g.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({
    Key? key,
    this.searchUserId = '',
  }) : super(key: key);

  final String searchUserId;

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileScreenCubit>().initParams(widget.searchUserId);
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                _buildTextWidget(
                  LocaleKeys.chatApp.tr(),
                  40.0,
                  TextDecoration.none,
                ),
                _buildAvatar(),
                _buildUserId(),
                BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: UserParams(
                          id: widget.searchUserId,
                          date: state.searchUserDate,
                          name: state.searchUserName,
                          profession: state.searchUserProfession,
                        ),
                      ),
                      child: _buildUserNameAndProfession(),
                    );
                  },
                ),
                CustomInputWidget(
                  textEditingController: textEditingController,
                  onTap: () {
                    context
                        .read<ProfileScreenCubit>()
                        .initParams(textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 216.0,
        height: 213.0,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
            color: Colors.grey),
      ),
    );
  }

  Widget _buildTextWidget(
    String text,
    double fontSize,
    TextDecoration decoration,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
            fontSize: fontSize,
            decoration: decoration,
          ),
        ),
      ),
    );
  }

  Widget _buildUserId() {
    return BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
        builder: (context, state) {
      final String userName = state.searchUserId;
      return Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: _buildTextWidget(
          '${LocaleKeys.id.tr()} $userName',
          30.0,
          TextDecoration.none,
        ),
      );
    });
  }

  Widget _buildUserNameAndProfession() {
    return BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
        builder: (context, state) {
      final String userName = state.searchUserName;
      final String userProfession = state.searchUserProfession;
      return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: _buildTextWidget(
          '$userName $userProfession',
          30.0,
          TextDecoration.underline,
        ),
      );
    });
  }
}
