import 'package:benji/src/common_widgets/appbar/my_appbar.dart';
import 'package:flutter/material.dart';

import '../../src/common_widgets/chat/chat_body.dart';
import '../../theme/colors.dart';

class LiveChat extends StatelessWidget {
  const LiveChat({super.key});

//============================================== ALL VARIABLES =================================================\\

//============================================== BOOL VALUES =================================================\\

//============================================== CONTROLLERS =================================================\\

//============================================== FUNCTIONS =================================================\\

//============================================== NAVIGATION =================================================\\

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Live Chat",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ChatBody(),
    );
  }
}
