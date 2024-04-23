import 'dart:io';

import 'package:benji/app/shopping_location/set_shopping_location.dart';
import 'package:benji/app/splash_screens/login_splash_screen.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/frontend/utils/constant.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/user_controller.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/services/api_url.dart';
import 'package:benji/src/repo/utils/constants.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  final ImagePicker _picker = ImagePicker();
  bool updatingImage = false;
  bool uploadedImage = false;

  File? selectedImage;
  XFile? selectedImageWeb;

  //===================== Profile Picture ==========================\\
  uploadProfilePicWeb(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );
    sendIt(image);
  }

  uploadProfilePic(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );
    sendIt(image);
  }

  sendIt(XFile? image) async {
    if (image != null) {
      if (!kIsWeb) {
        Get.back();
      }

      if (await checkXFileSize(image)) {
        ApiProcessorController.errorSnack('File to large');
        return;
      }
      setState(() {
        updatingImage = true;
      });
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
        image.readAsBytes().asStream(),
        await image.length(),
        filename: 'image.jpg',
        contentType:
            MediaType('image', 'jpeg'), // Adjust content type as needed
      ));

      // Send the request and await the response
      final http.StreamedResponse response = await request.send();

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        await UserController.instance.getUser();
        setState(() {
          updatingImage = false;
          uploadedImage = true;
        });

        // Image successfully uploaded
      } else {
        // Handle the error (e.g., server error)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    kSizedBox,
                    SizedBox(
                      width: media.width - 80,
                      child: const Text(
                        'Add a Profile photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    kSizedBox,
                    SizedBox(
                      width: media.width - 80,
                      child: const Text(
                        'Don’t be a stranger. Join us in creating a safe shopping experience for both users and vendors.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder<User?>(
                    future: getUser(),
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.topCenter,
                        height: 370,
                        child: Stack(
                          children: [
                            Container(
                              height: deviceType(media.width) == 1 ? 250 : 400,
                              width: deviceType(media.width) == 1 ? 250 : 400,
                              decoration: const ShapeDecoration(
                                color: kGreyColor1,
                                shape: OvalBorder(),
                              ),
                              child: Center(
                                child: updatingImage
                                    ? const CircularProgressIndicator(
                                        color: kTextWhiteColor,
                                        strokeWidth: 2,
                                      )
                                    : !snapshot.hasData ||
                                            snapshot.data == null ||
                                            snapshot.data!.image == profileImage
                                        ? const Image(
                                            height: 250,
                                            width: 250,
                                            image: AssetImage(
                                                'assets/images/profile/image.png'),
                                          )
                                        : ClipOval(
                                            child: MyImage(
                                              url: (snapshot.data!.image
                                                  as String?),
                                              radiusBottom: 125,
                                              radiusTop: 125,
                                            ),
                                          ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 25,
                              child: InkWell(
                                onTap: () {
                                  showModal(context);
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height:
                                      deviceType(media.width) == 1 ? 35 : 50,
                                  width: deviceType(media.width) == 1 ? 35 : 50,
                                  decoration: ShapeDecoration(
                                    color: kAccentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
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
                      );
                    }),
                MyElevatedButton(
                  upper: false,
                  title: uploadedImage ? "Continue" : "Add a profile photo",
                  onPressed: () {
                    uploadedImage
                        ? Get.offAll(
                            () => SetShoppingLocation(
                              hideButton: true,
                              navTo: () {
                                Get.offAll(
                                  () => const LoginSplashScreen(),
                                  fullscreenDialog: true,
                                  curve: Curves.easeIn,
                                  routeName: "LoginSplashScreen",
                                  predicate: (route) => false,
                                  popGesture: true,
                                  transition: Transition.cupertinoDialog,
                                );
                              },
                            ),
                            fullscreenDialog: true,
                            curve: Curves.easeIn,
                            routeName: "SetShoppingLocation",
                            predicate: (route) => false,
                            popGesture: true,
                            transition: Transition.cupertinoDialog,
                          )
                        : showModal(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showModal(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return showModalBottomSheet(
      context: context,
      elevation: 20,
      barrierColor: kBlackColor.withOpacity(0.8),
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
      builder: (builder) => Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              child: Image(
                width: 100,
                height: 75.25,
                image: AssetImage('assets/icons/camera.png'),
              ),
            ),
            kSizedBox,
            const Text(
              'Allow Camera access',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            kHalfSizedBox,
            const Text(
              'This is required to continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            kSizedBox,
            SizedBox(
              width: media.width - 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: kAccentColor),
                      backgroundColor: kTextWhiteColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadowColor: kBlackColor.withOpacity(0.4),
                      minimumSize: const Size(120, 50),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                          color: kAccentColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _profilePicBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadowColor: kBlackColor.withOpacity(0.4),
                      minimumSize: const Size(120, 50),
                    ),
                    child: const Text(
                      'Allow',
                      style: TextStyle(
                          color: kTextWhiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _profilePicBottomSheet(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return showModalBottomSheet(
      context: context,
      elevation: 20,
      barrierColor: kBlackColor.withOpacity(0.8),
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
      builder: (builder) => Container(
        height: media.height * 0.3,
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
                kIsWeb
                    ? const SizedBox()
                    : Column(
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
                        if (kIsWeb) {
                          uploadProfilePicWeb(ImageSource.gallery);
                          return;
                        }
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
      ),
    );
  }
}
