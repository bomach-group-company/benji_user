import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/others/my_future_builder.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';
import '../auth/login.dart';
import 'edit_profile.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
  }

  //=======================================================================================================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  final _scrollController = ScrollController();

//============================================== ALL VARIABLES =================================================\\
  int activeCategory = 0;
  String cartCount = '';
//============================================== BOOL VALUES =================================================\\

  //===================== COPY TO CLIPBOARD =======================\\
  void _copyToClipboard(BuildContext context, String userID) {
    Clipboard.setData(
      ClipboardData(text: userID),
    );

    //===================== SNACK BAR =======================\\

    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "ID copied to clipboard",
      Duration(
        seconds: 2,
      ),
    );
  }

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {}
  //========================================================================\\

  //==================================================== Navigation ===========================================================\\
  void _toEditProfile() => Get.to(
        () => const EditProfile(),
        routeName: 'EditProfile',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toChangePassword() {}

  void _logOut() => Get.offAll(
        () => const Login(logout: true),
        predicate: (route) => false,
        routeName: 'Login',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.downToUp,
      );

  @override
  Widget build(BuildContext context) {
    // double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "Profile Settings",
          elevation: 0.0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            radius: Radius.circular(10),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(kDefaultPadding),
              children: [
                MyFutureBuilder(
                  future: getUser(),
                  child: (snapshot) => Container(
                    width: mediaWidth,
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: ShapeDecoration(
                            color: kPageSkeletonColor,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/profile/avatar-image.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${snapshot.firstName} ${snapshot.lastName}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              snapshot.email,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  snapshot.code,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _copyToClipboard(context, snapshot.code);
                                  },
                                  tooltip: "Copy ID",
                                  mouseCursor: SystemMouseCursors.click,
                                  icon: FaIcon(
                                    FontAwesomeIcons.copy,
                                    size: 14,
                                    color: kAccentColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                kSizedBox,
                InkWell(
                  onTap: _toEditProfile,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: mediaWidth,
                    decoration: ShapeDecoration(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      enableFeedback: true,
                      leading: FaIcon(
                        FontAwesomeIcons.userPen,
                        color: kAccentColor,
                      ),
                      title: Text(
                        'Edit profile',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: kTextBlackColor,
                      ),
                    ),
                  ),
                ),
                kHalfSizedBox,
                InkWell(
                  onTap: _toChangePassword,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: mediaWidth,
                    decoration: ShapeDecoration(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      enableFeedback: true,
                      leading: FaIcon(
                        FontAwesomeIcons.solidPenToSquare,
                        color: kAccentColor,
                      ),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: kTextBlackColor,
                      ),
                    ),
                  ),
                ),
                kHalfSizedBox,
                InkWell(
                  onTap: _logOut,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: mediaWidth,
                    decoration: ShapeDecoration(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      enableFeedback: true,
                      leading: FaIcon(
                        FontAwesomeIcons.rightFromBracket,
                        color: kAccentColor,
                      ),
                      title: Text(
                        'Log out',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: kTextBlackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
