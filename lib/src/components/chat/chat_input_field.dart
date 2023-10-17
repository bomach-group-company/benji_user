import 'package:benji/src/providers/constants.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/responsive_constant.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: kAccentColor.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            enableFeedback: true,
            splashRadius: deviceType(media.width) > 2 ? 80 : 50,
            icon: FaIcon(
              FontAwesomeIcons.faceSmile,
              color: kAccentColor,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: deviceType(media.width) > 2 ? 80 : 50,
            enableFeedback: true,
            icon: FaIcon(
              FontAwesomeIcons.camera,
              size: 20,
              color: kAccentColor,
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 0.75,
              ),
              decoration: BoxDecoration(
                color: kAccentColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(
                    color: kGreyColor1,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: deviceType(media.width) > 2 ? 80 : 50,
            enableFeedback: true,
            icon: FaIcon(
              Icons.send,
              color: kAccentColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
