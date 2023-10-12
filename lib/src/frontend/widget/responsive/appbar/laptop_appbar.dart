import 'package:benji/app/auth/login.dart';
import 'package:benji/frontend/join_us/join_us.dart';
import 'package:benji/frontend/main/contact_us.dart';
import 'package:benji/frontend/main/home.dart';
import 'package:benji/frontend/store/category.dart';
import 'package:benji/frontend/store/search.dart';
import 'package:benji/src/frontend/model/category.dart';
import 'package:benji/src/frontend/widget/cart.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:benji/src/frontend/widget/text/hover_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../../theme/colors.dart';
import '../../../../providers/constants.dart';

class MyLaptopAppBar extends StatefulWidget {
  const MyLaptopAppBar({super.key});

  @override
  State<MyLaptopAppBar> createState() => _MyLaptopAppBarState();
}

class _MyLaptopAppBarState extends State<MyLaptopAppBar> {
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
    final media = MediaQuery.of(context).size;

    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 0, horizontal: media.width * 0.07),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
        color: Color(0xfffafafc),
        // border: Border(
        //   bottom: BorderSide(color: kAccentColor, width: 1),
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyClickable(
            navigate: const HomePage(),
            child: Image.asset(
              'assets/frontend/assets/brand/benji-logo-resized-nobg.png',
              // fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HoverColorText(
                text: 'Home',
                navigate: HomePage(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                ),
              ),
              kWidthSizedBox,
              kWidthSizedBox,
              FutureBuilder(
                  future: _category,
                  builder: (context, snapshot) {
                    return PopupMenuButton(
                      offset: const Offset(0, -25),
                      shadowColor: Colors.grey,
                      constraints:
                          const BoxConstraints(maxHeight: 170, maxWidth: 200),
                      tooltip: '',
                      position: PopupMenuPosition.under,
                      elevation: 5,
                      splashRadius: 0,
                      child: Center(
                        child: Row(
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
                              child: Text(
                                'Menu',
                                style: TextStyle(
                                  color:
                                      isHovered ? kAccentColor : Colors.black,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: isHovered ? kAccentColor : Colors.black,
                            )
                          ],
                        ),
                      ),
                      itemBuilder: (context) {
                        if (!snapshot.hasData) {
                          return [
                            const PopupMenuItem<int>(
                              value: 0,
                              child: Text(
                                'loading...',
                                style: TextStyle(fontSize: 10),
                              ),
                            )
                          ];
                        }
                        return List.generate((snapshot.data as List).length,
                                (index) => index)
                            .map(
                              (item) => PopupMenuItem<int>(
                                value: item,
                                child: Text(
                                    (snapshot.data as List<Category>)[item]
                                        .name),
                              ),
                            )
                            .toList();
                      },
                      onSelected: (value) {
                        Get.off(
                          () => CategoryPage(
                            activeCategoriesId:
                                (snapshot.data as List<Category>)[value].id,
                            activeCategories:
                                (snapshot.data as List<Category>)[value].name,
                          ),
                          routeName: 'CategoryPage',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          popGesture: true,
                          transition: Transition.fadeIn,
                        );
                      },
                    );
                  }),
              kWidthSizedBox,
              kWidthSizedBox,
              const HoverColorText(
                navigate: ContactUs(),
                text: 'Help & Support',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                ),
              ),
              kWidthSizedBox,
              kWidthSizedBox,
              const HoverColorText(
                navigate: JoinUsPage(),
                text: 'Join Us',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MyClickable(
                navigate: SearchPage(),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              kWidthSizedBox,
              const Text(
                '|',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                ),
              ),
              kWidthSizedBox,
              // ignore: prefer_const_constructors
              CartWidget(),
              kWidthSizedBox,
              kWidthSizedBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                    fixedSize: const Size(80, 35)),
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
                child: const Text('Login'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
