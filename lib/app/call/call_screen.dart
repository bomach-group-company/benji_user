import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding / 2,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              mouseCursor: SystemMouseCursors.click,
              child: Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  color: const Color(
                    0xFFFEF8F8,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 0.50,
                      color: Color(
                        0xFFFDEDED,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: kAccentColor,
                ),
              ),
            ),
            kWidthSizedBox,
            const Text(
              'Call',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: kDefaultPadding * 2),
                const CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      AssetImage('assets/images/profile/avatar-image.jpg'),
                ),
                kSizedBox,
                const Text(
                  'Juliet Gomes',
                  style: TextStyle(
                    color: Color(0xFF131514),
                    fontSize: 20,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.40,
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 1),
                const Text(
                  'Ringing...',
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 16,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.32,
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 5),
                SizedBox(
                  width: 160,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFDD5D5),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.40, color: Color(0xFFD4DAF0)),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: IconButton(
                          splashRadius: 30,
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEDF0FD),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.40, color: Color(0xFFD4DAF0)),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: IconButton(
                          splashRadius: 30,
                          onPressed: () {},
                          icon: Icon(
                            Icons.phone,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
