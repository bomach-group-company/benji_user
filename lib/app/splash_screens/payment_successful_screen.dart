// ignore_for_file: camel_case_types

import 'package:benji/app/orders/track_order.dart';
import 'package:benji/app/rider/assign_rider.dart';
import 'package:benji/src/repo/controller/cart_controller.dart';
import 'package:benji/src/repo/controller/order_status_change.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class PaymentSuccessful extends StatelessWidget {
  final Order order;

  const PaymentSuccessful({
    super.key,
    required this.order,
  });

  void _toAssignRider() async {
    Get.close(5);
    await OrderStatusChangeController.instance.setOrder(order);
    Get.to(
      () => const TrackOrder(),
      routeName: 'TrackOrder',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
    Get.to(
      () => AssignRiderMap(itemId: order.id, itemType: 'order'),
      routeName: 'AssignRiderMap',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: GetBuilder<CartController>(builder: (controller) {
          return MyElevatedButton(
            title: "Done",
            onPressed: _toAssignRider,
          );
        }),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          margin: const EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/payment/frame_1.json",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    width: media.width - 100,
                  ),
                  kSizedBox,
                  Text(
                    "Payment Successful",
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kSizedBox,
                  Text(
                    "The vendor has received your order\nand a rider will be dispatched to deliver it soon.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
