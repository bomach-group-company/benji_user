import 'package:benji/app/auth/login.dart';
import 'package:benji/frontend/join_us/join_us.dart';
import 'package:benji/frontend/main/about.dart';
import 'package:benji/frontend/main/contact_us.dart';
import 'package:benji/frontend/main/home.dart';
import 'package:benji/src/frontend/model/category.dart';
import 'package:benji/src/repo/models/category/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';
import '../drop.dart';
import '../text/hover_text.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    _category = fetchCategories();
    super.initState();
  }

  late Future<List<Category>> _category;

  bool visible = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      shadowColor: Colors.red,
      backgroundColor: kPrimaryColor,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20, left: 16),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close_sharp,
                          color: kAccentColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const HoverColorText(
                          navigate: HomePage(),
                          text: 'Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const HoverColorText(
                          navigate: AboutPage(),
                          text: 'About',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: _category,
                          builder: (context, snapshot) {
                            return Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (_) {
                                      setState(() {
                                        isHovered = true;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isHovered = false;
                                      });
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          visible = !visible;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Menu',
                                            style: TextStyle(
                                              color: isHovered
                                                  ? kAccentColor
                                                  : Colors.black,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: isHovered
                                                ? kAccentColor
                                                : Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  snapshot.hasData
                                      ? MyDropDown(
                                          visible: visible,
                                          items:
                                              (snapshot.data as List<Category>)
                                                  .map((item) => item)
                                                  .toList(),
                                        )
                                      : Visibility(
                                          visible: visible,
                                          child: const Text(
                                            'loading...',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                ],
                              ),
                            );
                          }),
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const HoverColorText(
                          navigate: ContactUs(),
                          text: 'Help & Support',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const HoverColorText(
                          navigate: JoinUsPage(),
                          text: 'Join Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // login button
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kAccentColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Get.off(
                  () => const Login(),
                  routeName: 'Login',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  popGesture: true,
                  transition: Transition.fadeIn,
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(color: kTextWhiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
