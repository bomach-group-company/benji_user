import 'package:benji/app/assign/assign_rider.dart';
import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/components/image/my_image.dart';
import 'package:benji/src/repo/controller/order_status_change.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  //================================================= ALL VARIABLES ========================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  final _scrollController = ScrollController();

  //=============================================== FUNCTIONS =================================================\\
  bool dispatched(Order order) {
    return ['dispatched', 'received', 'delivered']
        .contains(order.deliveryStatus);
  }

  bool delivered(Order order) {
    return order.deliveryStatus == 'COMP';
  }
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {}
  //========================================================================\\

  //=============================== NAVIGATION ======================================\\
  void _toAssignRider(Order order) => Get.offAll(
        () => AssignRiderMap(itemId: order.id, itemType: 'order'),
        routeName: 'Home',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        predicate: (routes) => false,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GetBuilder<OrderStatusChangeController>(builder: (controller) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0,
          title: "Track Order",
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
              onPressed: () => _toAssignRider(controller.order.value),
              icon: FaIcon(
                FontAwesomeIcons.hand,
                size: 18,
                semanticLabel: "Home",
                color: kAccentColor,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: delivered(controller.order.value)
              ? MyElevatedButton(
                  disable: true,
                  title: "completed",
                  onPressed: () {},
                )
              : MyElevatedButton(
                  // disable: true,
                  title: "received",
                  onPressed: controller.orderDelivered,
                  isLoading: controller.isLoad.value,
                ),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: kAccentColor,
          semanticsLabel: "Pull to refresh",
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(kDefaultPadding),
              children: [
                Container(
                  width: media.width,
                  height: 105,
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                        spreadRadius: 7,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Received',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Dispatched',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Delivered',
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: kDefaultPadding / 2,
                          right: kDefaultPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: kAccentColor,
                                shape: const OvalBorder(),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 2,
                                    bottom: 2,
                                    left: 2,
                                    child: Icon(
                                      Icons.check_rounded,
                                      color: kPrimaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 4,
                                color: dispatched(controller.order.value) ||
                                        delivered(controller.order.value)
                                    ? kAccentColor
                                    : const Color(0xFFC4C4C4),
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: dispatched(controller.order.value) ||
                                        delivered(controller.order.value)
                                    ? kAccentColor
                                    : const Color(0xFFC4C4C4),
                                shape: const OvalBorder(),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 2,
                                    bottom: 2,
                                    left: 2,
                                    child: Icon(
                                      Icons.check_rounded,
                                      color: kPrimaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 4,
                                color: delivered(controller.order.value)
                                    ? kAccentColor
                                    : const Color(0xFFC4C4C4),
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: delivered(controller.order.value)
                                    ? kAccentColor
                                    : const Color(0xFFC4C4C4),
                                shape: const OvalBorder(),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 2,
                                    bottom: 2,
                                    left: 2,
                                    child: Icon(
                                      Icons.check_rounded,
                                      color: kPrimaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                kSizedBox,
                Container(
                  width: media.width,
                  height: 103,
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
                  child: Container(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: deviceType(media.width) > 2 ? 18 : 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              dispatched(controller.order.value) ||
                                      delivered(controller.order.value)
                                  ? delivered(controller.order.value)
                                      ? 'Your order has been delivered'
                                      : 'Your order is on it\'s way'
                                  : 'Order received by the vendor',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kWidthSizedBox,
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: 14,
                              color: kAccentColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                kSizedBox,
                Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Details',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      kSizedBox,
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller.order.value.orderitems.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return kHalfSizedBox;
                        },
                        itemBuilder: (BuildContext context, int index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 90,
                                height: 90,
                                child: MyImage(
                                  url: controller.order.value.orderitems[index]
                                          .product.productImage ??
                                      '',
                                )),
                            kHalfWidthSizedBox,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kHalfSizedBox,
                                SizedBox(
                                  width: media.width - 200,
                                  child: Text(
                                    controller.order.value.orderitems[index]
                                        .product.name,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: kTextBlackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                kSizedBox,
                                Row(
                                  children: [
                                    SizedBox(
                                      width: media.width - 200,
                                      child: Text(
                                        '${controller.order.value.orderitems[index].quantity} Item (s)',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                kSizedBox,
                const SizedBox(
                  height: kDefaultPadding * 2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
