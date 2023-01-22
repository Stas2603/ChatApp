import 'package:chat_app_test/presentation/features/app_resources/locale_keys.g.dart';
import 'package:chat_app_test/presentation/features/chat_screen/chat_screen_cubit.dart';
import 'package:chat_app_test/presentation/features/chat_screen/chat_screen_state.dart';
import 'package:chat_app_test/presentation/widgets/my_list_tile_widget.dart';
import 'package:chat_app_test/presentation/widgets/other_user_list_tile_widget.dart';
import 'package:chat_app_test/view_models/message.dart';
import 'package:chat_app_test/view_models/userParams.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({
    Key? key,
    this.userParams = const UserParams(
      id: '',
      date: '',
      name: '',
      profession: '',
    ),
  }) : super(key: key);

  final UserParams userParams;

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatScreenCubit>().initParams(widget.userParams.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: _buildCircleAvatar(),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: _buildTitle(),
      ),
      body: Column(
        children: [
          Expanded(child: _buildChat()),
          _buildInputText(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    final date = widget.userParams.date;
    var number = int.parse(date);
    final DateTime lastSeen = DateTime.fromMillisecondsSinceEpoch(number);
    final minuteAgo = Jiffy(lastSeen).fromNow();

    return Text(
      textAlign: TextAlign.start,
      '${LocaleKeys.lastSeen.tr()} $minuteAgo',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildChat() {
    return BlocBuilder<ChatScreenCubit, ChatScreenState>(
        builder: (context, state) {
      return StreamBuilder(
        stream: FirebaseDatabase.instance.ref(state.path).onValue,
        builder: (context, snapshot) {
          final list = <Message>[];
          if (snapshot.data?.snapshot.value != null) {
            final data = Map<String, dynamic>.from(
              snapshot.data?.snapshot.value as Map,
            );

            data.forEach((key, value) {
              final id = value['id'];
              final date =
                  DateTime.fromMillisecondsSinceEpoch(value['date'] as int);
              final text = value['message'];
              Message message = Message(
                id: id,
                message: text,
                date: date,
              );
              list.add(message);
            });

            list.sort((a, b) {
              return DateTime.parse(a.date.toString())
                  .compareTo(DateTime.parse(b.date.toString()));
            });

            return ListView.separated(
                itemBuilder: (context, index) => _buildListTile(
                      list[index].message,
                      state.name,
                      state.name,
                      list[index].id,
                      state.myId,
                      list[index].date,
                    ),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: list.length);
          } else if (snapshot.data?.snapshot.value == null) {
            return const Center(child: Text('No message.'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }

  Widget _buildListTile(
    String text,
    String name,
    String profession,
    String messageId,
    String myId,
    DateTime date,
  ) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    if (messageId != myId) {
      return otherUserListTileWidget(
        text,
        widget.userParams.name,
        widget.userParams.profession,
        height,
        width,
        date,
        _buildCircleAvatar(),
      );
    } else {
      return myListTileWidget(
        text,
        height,
        width,
        date,
      );
    }
  }

  Widget _buildInputText() {
    return Container(
      height: 48.0,
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: textEditingController,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: LocaleKeys.startTyping.tr(),
                contentPadding: const EdgeInsets.only(left: 32.0),
                hintStyle: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () {
                context.read<ChatScreenCubit>().sendMessage(
                      textEditingController.text,
                      DateTime.now(),
                    );
              },
              child: Image.asset(
                'assets/images/arrow.png',
                width: 15.96,
                height: 13.78,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
