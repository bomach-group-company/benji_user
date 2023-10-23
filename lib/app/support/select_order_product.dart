import 'package:benji/app/packages/item_category_dropdown_menu.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/textformfield/message_textformfield.dart';
import 'package:benji/src/repo/models/complain/complain.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/models/order/order_item.dart';
import 'package:benji/src/repo/utils/helpers.dart';
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
    _getData();
  }

  List<Order> _orders = [];
  Order? _activeOrders;
  List<OrderItem> _orderitems = [];

  _getData() async {
    int? userId = getUserSync()!.id;

    _orders = await getOrders(userId);
    _activeOrders ??= _orders.first;
    if (_activeOrders != null) {
      _orderitems = await getOrderItems(_activeOrders?.id);
    }
    setState(() {});
  }

  _getItems(orderId) async {
    _activeOrders = _orders.firstWhere((element) => element.id == orderId);
    _orderitems = await getOrderItems(_activeOrders?.id);
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

//============================================== ALL VARIABLES =================================================\\

//============================================== FUNCTIONS =================================================\\
  _submit() async {
    await makeComplain(_itemProductEC.text, _messageEC.text, 'orderitems');
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
                ItemDropDownMenu(
                  onSelected: (value) {
                    _itemOrderEC.text = value!.toString();
                    _getItems(_itemOrderEC.text);
                  },
                  itemEC: _itemOrderEC,
                  mediaWidth: media.width - 20,
                  hintText: "Choose order",
                  dropdownMenuEntries2: _orders
                      .map((item) => DropdownMenuEntry(
                            value: item.id,
                            label: item.id,
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
                  hintText: "Choose orderitem",
                  dropdownMenuEntries2: _orderitems
                      .map((item) => DropdownMenuEntry(
                            value: item.id,
                            label: item.id,
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
