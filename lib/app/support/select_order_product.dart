import 'package:benji/app/packages/item_category_dropdown_menu.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/textformfield/message_textformfield.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../src/providers/constants.dart';

class SelectOrderProduct extends StatefulWidget {
  const SelectOrderProduct({super.key});

  @override
  State<SelectOrderProduct> createState() => _SelectOrderProductState();
}

class _SelectOrderProductState extends State<SelectOrderProduct> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

//============================================== ALL VARIABLES =================================================\\
  final _orders = ['#564895', '#86214', '#552255'];
  final _products = ['item1', 'item2', 'itemn'];

//============================================== BOOL VALUES =================================================\\

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();
  final _itemOrderEC = TextEditingController();
  final _itemProductEC = TextEditingController();
  final _messageEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //============================================ FOCUS NODES ===========================================\\
  final FocusNode _messageFN = FocusNode();

//============================================== NAVIGATION =================================================\\

  // void _toFAQsPage() => Get.to(
  //       () => const FAQs(),
  //       routeName: 'FAQs',
  //       duration: const Duration(milliseconds: 300),
  //       fullscreenDialog: true,
  //       curve: Curves.easeIn,
  //       preventDuplicates: true,
  //       popGesture: true,
  //       transition: Transition.rightToLeft,
  //     );

  // void _toFileAComplaint() => Get.to(
  //       () => const FileAComplaint(),
  //       routeName: 'FileAComplaint',
  //       duration: const Duration(milliseconds: 300),
  //       fullscreenDialog: true,
  //       curve: Curves.easeIn,
  //       preventDuplicates: true,
  //       popGesture: true,
  //       transition: Transition.rightToLeft,
  //     );
  // void _toLiveChatPage() => Get.to(
  //       () => const LiveChat(),
  //       routeName: 'LiveChat',
  //       duration: const Duration(milliseconds: 300),
  //       fullscreenDialog: true,
  //       curve: Curves.easeIn,
  //       preventDuplicates: true,
  //       popGesture: true,
  //       transition: Transition.rightToLeft,
  //     );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "Complain",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          controller: _scrollController,
          child: Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/animations/help_and_support/frame_1.json",
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                const Text(
                  "Fill the form",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                kSizedBox,
                const Text(
                  "Select Order",
                  style: TextStyle(
                    fontSize: 17.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kHalfSizedBox,
                ItemDropDownMenu(
                  itemEC: _itemOrderEC,
                  mediaWidth: media.width - 20,
                  hintText: "Choose order",
                  dropdownMenuEntries2: _orders
                      .map((item) => DropdownMenuEntry(
                            value: item,
                            label: item,
                          ))
                      .toList(),
                ),
                kSizedBox,
                const Text(
                  "Select Product",
                  style: TextStyle(
                    fontSize: 17.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kHalfSizedBox,
                ItemDropDownMenu(
                  itemEC: _itemProductEC,
                  mediaWidth: media.width - 20,
                  hintText: "Choose product",
                  dropdownMenuEntries2: _products
                      .map((item) => DropdownMenuEntry(
                            value: item,
                            label: item,
                          ))
                      .toList(),
                ),
                kSizedBox,
                const Text(
                  "Complain",
                  style: TextStyle(
                    fontSize: 17.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kHalfSizedBox,
                MyMessageTextFormField(
                  controller: _messageEC,
                  textInputAction: TextInputAction.done,
                  focusNode: _messageFN,
                  hintText: "Enter your message here",
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  maxLength: 1000,
                  validator: (value) {
                    if (value == null || value!.isEmpty) {
                      _messageFN.requestFocus();
                      return "Field cannot be left empty";
                    }

                    return null;
                  },
                ),
                kSizedBox,
                MyElevatedButton(
                  title: 'Send',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // do someting
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
