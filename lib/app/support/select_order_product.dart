// ignore_for_file: use_build_context_synchronously

import 'package:benji/app/packages/item_category_dropdown_menu.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/snackbar/my_floating_snackbar.dart';
import 'package:benji/src/components/textformfield/message_textformfield.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/models/complain/complain.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _isLoading = false;
  Order? selectedOrder;
//============================================== FUNCTIONS =================================================\\
  _submit() async {
    setState(() {
      _isLoading = true;
    });
    bool res =
        await makeComplain(_itemProductEC.text, _messageEC.text, 'orderitems');

    if (res) {
      mySnackBar(
        context,
        kSuccessColor,
        "Success!",
        "Complain received",
        const Duration(seconds: 2),
      );
      Get.back();

      setState(() {
        _isLoading = false;
      });
    } else {
      mySnackBar(
        context,
        kErrorColor,
        "Failed!",
        "Error occured please fill all fields",
        const Duration(seconds: 2),
      );
      Get.back();

      setState(() {
        _isLoading = false;
      });
    }
  }

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
                GetBuilder<OrderController>(
                  initState: (state) => OrderController.instance.getOrders(),
                  builder: (controller) => ItemDropDownMenu(
                    onSelected: (value) {
                      _itemOrderEC.text = value!.toString();
                      setState(() {
                        selectedOrder = OrderController.instance.orderList
                            .firstWhere((element) => element.id == value);
                      });
                    },
                    itemEC: _itemOrderEC,
                    mediaWidth: media.width - 20,
                    hintText: "Choose order",
                    dropdownMenuEntries2:
                        controller.isLoad.value && controller.orderList.isEmpty
                            ? [
                                const DropdownMenuEntry(
                                    value: 'Loading...',
                                    label: 'Loading...',
                                    enabled: false),
                              ]
                            : controller.orderList.isEmpty
                                ? [
                                    const DropdownMenuEntry(
                                        value: 'EMPTY',
                                        label: 'EMPTY',
                                        enabled: false),
                                  ]
                                : controller.orderList
                                    .map(
                                      (item) => DropdownMenuEntry(
                                        value: item.id,
                                        label: item.code,
                                      ),
                                    )
                                    .toList(),
                  ),
                ),
                kSizedBox,
                const Text(
                  "Select orderitem",
                  style: TextStyle(
                    fontSize: 17.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kHalfSizedBox,
                ItemDropDownMenu(
                  itemEC: _itemProductEC,
                  mediaWidth: media.width - 20,
                  hintText: "Choose orderitem",
                  dropdownMenuEntries2: selectedOrder == null
                      ? [
                          const DropdownMenuEntry(
                              value: 'Select Order first',
                              label: 'Select Order first',
                              enabled: false)
                        ]
                      : selectedOrder!.orderitems.isEmpty
                          ? [
                              const DropdownMenuEntry(
                                  value: 'Order has no items',
                                  label: 'Order has no items',
                                  enabled: false)
                            ]
                          : selectedOrder!.orderitems
                              .map((item) => DropdownMenuEntry(
                                    value: item.id,
                                    label: item.product.name,
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
                  isLoading: _isLoading,
                  title: 'Send',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _submit();
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
