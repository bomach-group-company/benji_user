// ignore_for_file: use_build_context_synchronously

import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  bool _showBackToTopButton = false;
  bool isLoading = false;

  // scroll controller
  late ScrollController _scrollController;

  // controller
  final TextEditingController _firstNameEC = TextEditingController();
  final TextEditingController _lastNameEC = TextEditingController();
  final TextEditingController _emailEC = TextEditingController();
  final TextEditingController _messageEC = TextEditingController();

  _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final url = Uri.parse('$baseFrontendUrl/contact/createContactus');

      final body = {
        'first_name': _firstNameEC.text,
        'last_name': _lastNameEC.text,
        'email': _emailEC.text,
        'message': _messageEC.text,
      };
      final response = await http.post(url, body: body);

      if (kDebugMode) {
        print("This is the body: $body,,,,,,, ${response.body}");
      }
      if (response.statusCode == 200) {
        mySnackBar(
          context,
          kSuccessColor,
          "Success!",
          "Request summited",
          const Duration(seconds: 2),
        );
        _formKey.currentState!.reset();
      } else {
        mySnackBar(
          context,
          kAccentColor,
          "Failed!",
          "Request Failed",
          const Duration(seconds: 2),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      drawerScrimColor: kTransparentColor,
      backgroundColor: kPrimaryColor,
      appBar: const MyAppbar(),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                children: [
                  const MyBreadcrumb(
                    text: 'Help & Contact Us',
                    current: 'Help & Contact Us',
                    hasBeadcrumb: true,
                    back: 'home',
                  ),
                  kSizedBox,
                  Container(
                    width: media.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: breakPoint(media.width, 25, 50, 50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: media.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: breakPoint(media.width, 25, 50, 50),
                            vertical: 50,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer,
                                color: Colors.grey,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Reach Out',
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              kSizedBox,
                              const Text(
                                'Please feel free to contact us if you have any questions or concerns',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kSizedBox,
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    kSizedBox,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _firstNameEC,
                                            cursorColor: Colors.black,
                                            cursorHeight: 20,
                                            cursorWidth: 1,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                              ),
                                              hintText: "First Name",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please enter your First name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        kWidthSizedBox,
                                        Expanded(
                                          child: TextFormField(
                                            controller: _lastNameEC,
                                            cursorColor: Colors.black,
                                            cursorHeight: 20,
                                            cursorWidth: 1,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                              ),
                                              hintText: "Last Name",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please enter your Last name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    kSizedBox,
                                    TextFormField(
                                      controller: _emailEC,
                                      cursorColor: Colors.black,
                                      cursorHeight: 20,
                                      cursorWidth: 1,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Email',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please enter your Email';
                                        }
                                        return null;
                                      },
                                    ),
                                    kSizedBox,
                                    TextFormField(
                                      controller: _messageEC,
                                      cursorColor: Colors.black,
                                      cursorHeight: 20,
                                      cursorWidth: 1,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 4,
                                      maxLines: 20,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Message',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please enter your Email';
                                        }
                                        return null;
                                      },
                                    ),
                                    kSizedBox,
                                    MyElevatedButton(
                                      isLoading: isLoading,
                                      title: "Submit",
                                      onPressed: _submit,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  kSizedBox,
                  kSizedBox,
                  kSizedBox,
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: const MyDrawer(),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(45, 45),
                  foregroundColor: kAccentColor,
                  side: BorderSide(color: kAccentColor)),
              onPressed: _scrollToTop,
              child: const Icon(
                Icons.arrow_upward,
                size: 20,
                // color: Colors.white,
              ),
            ),
    );
  }
}
