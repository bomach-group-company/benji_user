import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:flutter/material.dart';

import '../../src/components/chat/chat_body.dart';
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
      body: ChatBody(),
    );
  }
}
