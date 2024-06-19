import 'package:benji/app/orders/order_drafts.dart';
import 'package:benji/app/orders/track_order.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/controller/order_status_change.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/others/empty.dart';
import '../../src/components/section/track_order_details_container.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';
import '../home/home.dart';

class OrdersHistory extends StatefulWidget {
  final bool? showHomeButton;
  const OrdersHistory({super.key, this.showHomeButton = false});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  //=================================== INITIAL STATE ====================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    checkIfShoppingLocation(context);
    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(() {
      OrderController.instance.scrollListener(_scrollController);
    });
  }

  //=================================== ALL VARIABLES ====================================\\
  bool _isScrollToTopBtnVisible = false;

  //=================================== CONTROLLERS ====================================\\
  TextEditingController searchController = TextEditingController();
  final _scrollController = ScrollController();

  //=================================== FUNCTIONS ====================================\\

  //===================== Scroll to Top ==========================\\
  Future<void> _scrollToTop() async {
    await _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _isScrollToTopBtnVisible = false;
    });
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels >= 200 &&
        _isScrollToTopBtnVisible != true) {
      setState(() {
        _isScrollToTopBtnVisible = true;
      });
    }
    if (_scrollController.position.pixels < 200 &&
        _isScrollToTopBtnVisible == true) {
      setState(() {
        _isScrollToTopBtnVisible = false;
      });
    }
  }

  //===================== Function ==========================\\

  Future<void> _handleRefresh() async {
    OrderController.instance.refreshOrder();
  }

  Future _toOrderDetailsScreen(Order order) async {
    await OrderStatusChangeController.instance.setOrder(order);

    Get.to(
      () => const TrackOrder(),
      routeName: 'TrackOrder',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  void _toOrdersDrafts() => Get.to(
        () => const OrdersDrafts(),
        routeName: 'OrdersDrafts',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        transition: Transition.rightToLeft,
      );

  void _toHomeScreen() => Get.offAll(
        () => const Home(),
        routeName: 'Home',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        predicate: (routes) => false,
        transition: Transition.rightToLeft,
      );
  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: MyAppBar(
            elevation: 0.0,
            title: "My Orders ",
            backgroundColor: kPrimaryColor,
            actions: [
              widget.showHomeButton == true
                  ? IconButton(
                      onPressed: _toHomeScreen,
                      icon: FaIcon(
                        FontAwesomeIcons.house,
                        size: 18,
                        semanticLabel: "Home",
                        color: kAccentColor,
                      ),
                    )
                  : TextButton(
                      onPressed: _toOrdersDrafts,
                      child: Text(
                        'Draft orders',
                        style: TextStyle(
                            color: kAccentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
          floatingActionButton: _isScrollToTopBtnVisible
              ? FloatingActionButton(
                  onPressed: _scrollToTop,
                  mini: deviceType(media.width) > 2 ? false : true,
                  backgroundColor: kAccentColor,
                  enableFeedback: true,
                  mouseCursor: SystemMouseCursors.click,
                  tooltip: "Scroll to top",
                  hoverColor: kAccentColor,
                  hoverElevation: 50.0,
                  child: FaIcon(FontAwesomeIcons.chevronUp,
                      size: 18, color: kPrimaryColor),
                )
              : const SizedBox(),
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              shrinkWrap: true,
              children: [
                GetBuilder<OrderController>(
                    initState: (state) => OrderController.instance.getOrders(),
                    builder: (controller) {
                      if (controller.isLoad.value &&
                          controller.orderList.isEmpty) {
                        return SizedBox(
                          height: media.height - 100,
                          width: media.width,
                          child: Center(
                            child:
                                CircularProgressIndicator(color: kAccentColor),
                          ),
                        );
                      }
                      return controller.orderList.isEmpty
                          ? const EmptyCard()
                          : ListView.separated(
                              itemCount: controller.orderList.length,
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  kHalfSizedBox,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () async => await _toOrderDetailsScreen(
                                    controller.orderList[index]),
                                child: TrackOrderDetailsContainer(
                                  order: controller.orderList[index],
                                ),
                              ),
                            );
                    }),
                GetBuilder<OrderController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        controller.loadedAll.value
                            ? Container(
                                margin: const EdgeInsets.only(top: 20),
                                height: 10,
                                width: 10,
                                decoration: ShapeDecoration(
                                    shape: const CircleBorder(),
                                    color: kPageSkeletonColor),
                              )
                            : const SizedBox(),
                        controller.isLoadMore.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              )
                            : const SizedBox()
                      ],
                    );
                  },
                ),
                kSizedBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
