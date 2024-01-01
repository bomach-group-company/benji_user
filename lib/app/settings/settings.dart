import 'dart:io';

import 'package:benji/app/settings/change_password.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/providers/responsive_constant.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../src/components/others/my_future_builder.dart';
import '../../src/components/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/user/user_model.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';
import '../auth/login.dart';
import 'about_app.dart';
import 'edit_profile.dart';
import 'notification_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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

  //=========================== IMAGE PICKER ====================================\\

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

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
      const Duration(
        seconds: 2,
      ),
    );
  }

  //=========================== WIDGETS ====================================\\
  Widget _profilePicBottomSheet() {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Profile photo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          kSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      uploadProfilePic(ImageSource.camera);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(
                            width: 0.5,
                            color: kGreyColor1,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  const Text(
                    "Camera",
                  ),
                ],
              ),
              kWidthSizedBox,
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      uploadProfilePic(ImageSource.gallery);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(
                            width: 0.5,
                            color: kGreyColor1,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.image,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  const Text(
                    "Gallery",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //==================================================== FUNCTIONS ===========================================================\\

  //===================== Profile Picture ==========================\\

  uploadProfilePic(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
      User? user = await getUser();
      final url =
          Uri.parse('$baseURL/clients/changeClientProfileImage/${user!.id}');

      // Create a multipart request
      final request = http.MultipartRequest('POST', url);

      // Set headers
      request.headers.addAll(await authHeader());

      // Add the image file to the request
      request.files.add(http.MultipartFile(
        'image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: 'image.jpg',
        contentType:
            MediaType('image', 'jpeg'), // Adjust content type as needed
      ));

      // Send the request and await the response
      final http.StreamedResponse response = await request.send();

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        await UserController.instance.getUser();
        // Image successfully uploaded
        if (kDebugMode) {
          consoleLog(await response.stream.bytesToString());
          consoleLog('Image uploaded successfully');
        }
      } else {
        // Handle the error (e.g., server error)
          consoleLog('Error uploading image: ${response.reasonPhrase}');
      }
    }
  }

  //========================================================================\\

  //==================================================== Navigation ===========================================================\\

  toNotificationsPage() => Get.to(
        () => const NotificationPage(),
        routeName: 'NotificationsPage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toEditProfile() async {
    await Get.to(
      () => const EditProfile(),
      routeName: 'EditProfile',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    setState(() {});
  }

  void _toChangePassword() async {
    await Get.to(
      () => const ChangePassword(),
      routeName: 'ChangePassword',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    setState(() {});
  }

  void _toAboutApp() => Get.to(
        () => const AboutApp(),
        routeName: 'AboutApp',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _logOut() async {
    await UserController.instance.deleteUser();
    Get.offAll(
      () => const Login(),
      predicate: (route) => false,
      routeName: 'Login',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: true,
      transition: Transition.upToDown,
    );
  }

  @override
  Widget build(BuildContext context) {
    // double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(
        title: "Settings",
        elevation: 0.0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(kDefaultPadding),
            children: [
              MyFutureBuilder(
                  future: getUser(),
                  child: (snapshot) {
                    consoleLog(snapshot);
                    consoleLog(baseImage + snapshot.image);
                    consoleLog(selectedImage.toString());
                    return Container(
                      width: mediaWidth,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 24,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  selectedImage == null
                                      ? Container(
                                          height: deviceType(mediaWidth) == 1
                                              ? 100
                                              : 150,
                                          width: deviceType(mediaWidth) == 1
                                              ? 100
                                              : 150,
                                          decoration: ShapeDecoration(
                                            color: kPageSkeletonColor,
                                            // image: const DecorationImage(
                                            //   image: AssetImage(
                                            //     "assets/images/profile/avatar-image.jpg",
                                            //   ),
                                            //   fit: BoxFit.contain,
                                            // ),
                                            shape: const OvalBorder(),
                                          ),
                                          child: Center(
                                            child: MyImage(
                                              url: (snapshot.image as String?),
                                              radiusBottom: 50,
                                              radiusTop: 50,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: deviceType(mediaWidth) == 1
                                              ? 100
                                              : 150,
                                          width: deviceType(mediaWidth) == 1
                                              ? 100
                                              : 150,
                                          decoration: ShapeDecoration(
                                            color: kPageSkeletonColor,
                                            image: DecorationImage(
                                              image: FileImage(selectedImage!),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: const OvalBorder(),
                                          ),
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          elevation: 20,
                                          barrierColor:
                                              kBlackColor.withOpacity(0.8),
                                          showDragHandle: true,
                                          useSafeArea: true,
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(
                                                kDefaultPadding,
                                              ),
                                            ),
                                          ),
                                          enableDrag: true,
                                          builder: (builder) =>
                                              _profilePicBottomSheet(),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: deviceType(mediaWidth) == 1
                                            ? 35
                                            : 50,
                                        width: deviceType(mediaWidth) == 1
                                            ? 35
                                            : 50,
                                        decoration: ShapeDecoration(
                                          color: kAccentColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.pencil,
                                            size: 16,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          kWidthSizedBox,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.firstName} ${snapshot.lastName}',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  snapshot.email,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: kTextBlackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 11),
                                      child: Text(
                                        snapshot.code,
                                        softWrap: true,
                                        style: const TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _copyToClipboard(
                                            context, snapshot.code);
                                      },
                                      tooltip: "Copy ID",
                                      mouseCursor: SystemMouseCursors.click,
                                      icon: FaIcon(
                                        FontAwesomeIcons.solidCopy,
                                        size: 14,
                                        color: kAccentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
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
                    shadows: const [
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
                    title: const Text(
                      'Edit profile',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
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
                    shadows: const [
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
                    title: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16,
                      color: kTextBlackColor,
                    ),
                  ),
                ),
              ),
              kHalfSizedBox,
              InkWell(
                onTap: _toAboutApp,
                child: Container(
                  width: mediaWidth,
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
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
                      FontAwesomeIcons.circleInfo,
                      color: kAccentColor,
                    ),
                    title: const Text(
                      "About the app",
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const Icon(
                      FontAwesomeIcons.chevronRight,
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
                    shadows: const [
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
                    title: const Text(
                      'Log out',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const Icon(
                      FontAwesomeIcons.chevronRight,
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
    );
  }
}
