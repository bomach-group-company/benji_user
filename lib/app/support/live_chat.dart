import 'package:benji/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../../src/repo/models/user/user_model.dart';
import '../../src/repo/utils/helpers.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

//============================================== ALL VARIABLES =================================================\\
  final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  User? currentUser;
  // types.User? _user;
//============================================== BOOL VALUES =================================================\\

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

//============================================== FUNCTIONS =================================================\\
  _getUserData() async {
    checkAuth(context);
    currentUser = await getUser();
    // _user = types.User(
    //   id: currentUser!.id.toString(),
    // );

    if (kDebugMode) {
      print("_user: $_user");
    }

    setState(() {});
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: currentUser!.id.toString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

//============================================== NAVIGATION =================================================\\

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Live Chat",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          controller: _scrollController,
          child: Chat(
            user: _user,
            onSendPressed: _handleSendPressed,
            messages: _messages,
            onBackgroundTap: (() =>
                FocusManager.instance.primaryFocus?.unfocus()),
          ),
        ),
      ),
    );
  }
}
