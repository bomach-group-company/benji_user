import 'package:benji/app/rider/assign_rider.dart';
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
  @override
  void dispose() {
    OrderStatusChangeController.instance.closeTaskSocket();
    super.dispose();
  }

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
  void _toAssignRider(Order order) => Get.to(
        () => AssignRiderMap(itemId: order.id, itemType: 'order'),
        routeName: 'AssignRiderMap',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GetBuilder<OrderStatusChangeController>(
        initState: OrderStatusChangeController.instance.getTaskItemSocket(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: MyAppBar(
              elevation: 0,
              title: "Track Order",
              backgroundColor: kPrimaryColor,
              actions: [
                TextButton(
                  onPressed: controller.taskItemStatusUpdate.value.assigned
                      ? null
                      : () => _toAssignRider(controller.order.value),
                  child: Text(
                    'Assign rider',
                    style: TextStyle(
                        color: controller.taskItemStatusUpdate.value.assigned
                            ? kAccentColor.withOpacity(0.5)
                            : kAccentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                kWidthSizedBox,
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: MyElevatedButton(
                disable: !controller.hasFetched.value
                    ? true
                    : !controller.taskItemStatusUpdate.value.assigned
                        ? false
                        : !controller.taskItemStatusUpdate.value.action,
                title: controller.hasFetched.value
                    ? controller.taskItemStatusUpdate.value.buttonText
                    : "Loading...",
                onPressed: controller.hasFetched.value
                    ? () {
                        if (!controller.taskItemStatusUpdate.value.assigned) {
                          _toAssignRider(controller.order.value);
                          return;
                        }
                        controller.updateTaskItemStatus();
                      }
                    : () {},
                isLoading: controller.isLoadUpdateStatus.value,
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
                                      : controller.taskItemStatusUpdate.value
                                              .assigned
                                          ? 'Order received by the vendor'
                                          : controller.taskItemStatusUpdate
                                              .value.detail,
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
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return kHalfSizedBox;
                            },
                            itemBuilder: (BuildContext context, int index) =>
                                Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: MyImage(
                                      url: controller
                                              .order
                                              .value
                                              .orderitems[index]
                                              .product
                                              .productImage ??
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
                    // Container(
                    //   decoration: ShapeDecoration(
                    //     color: kPrimaryColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     shadows: const [
                    //       BoxShadow(
                    //         color: Color(0x0F000000),
                    //         blurRadius: 24,
                    //         offset: Offset(0, 4),
                    //         spreadRadius: 0,
                    //       ),
                    //     ],
                    //   ),
                    //   child: ListTile(
                    //     leading: Container(
                    //       width: 47,
                    //       height: 47,
                    //       margin: const EdgeInsets.only(right: 10),
                    //       decoration: ShapeDecoration(
                    //         color: const Color(0xFF979797),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //         ),
                    //         shadows: const [
                    //           BoxShadow(
                    //             color: Color(0x16000000),
                    //             blurRadius: 8,
                    //             offset: Offset(0, 4),
                    //             spreadRadius: 0,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     trailing: Container(
                    //       width: 40,
                    //       height: 40,
                    //       decoration: ShapeDecoration(
                    //         color: const Color(0xFFF00300),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(16),
                    //         ),
                    //       ),
                    //       child: const Icon(
                    //         Icons.phone,
                    //         color: kTextWhiteColor,
                    //       ),
                    //     ),
                    //     title: Container(
                    //       margin: const EdgeInsets.only(bottom: 10),
                    //       child: const Text(
                    //         'Jay wills',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 17,
                    //           fontFamily: 'Poppins',
                    //           fontWeight: FontWeight.w600,
                    //           height: 0,
                    //         ),
                    //       ),
                    //     ),
                    //     subtitle: const Row(
                    //       children: [
                    //         Icon(
                    //           Icons.location_on_outlined,
                    //         ),
                    //         kHalfWidthSizedBox,
                    //         Text(
                    //           '3.2km away',
                    //           style: TextStyle(
                    //             color: Color(0xFF575757),
                    //             fontSize: 14,
                    //             fontFamily: 'Poppins',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // kSizedBox,
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
