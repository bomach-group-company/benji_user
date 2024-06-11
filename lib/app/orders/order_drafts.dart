import 'package:benji/app/address/add_new_address.dart';
import 'package:benji/app/checkout/checkout_draft_screen.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/order_controller.dart';
import 'package:benji/src/repo/models/address/address_model.dart';
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

class OrdersDrafts extends StatefulWidget {
  const OrdersDrafts({super.key});

  @override
  State<OrdersDrafts> createState() => _OrdersDraftsState();
}

class _OrdersDraftsState extends State<OrdersDrafts> {
  //=================================== INITIAL STATE ====================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    checkIfShoppingLocation(context);
    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(() {
      OrderController.instance.scrollListenerDraft(_scrollController);
    });

    getCurrentAddress().then((value) {
      deliverTo = value;
    });
  }

  Address? deliverTo;

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
            title: "My Draft Orders",
            backgroundColor: kPrimaryColor,
            actions: const [],
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
                    initState: (state) =>
                        OrderController.instance.getOrdersDraft(),
                    builder: (controller) {
                      if (controller.isLoadDraft.value) {
                        return SizedBox(
                          height: media.height - 100,
                          width: media.width,
                          child: Center(
                            child:
                                CircularProgressIndicator(color: kAccentColor),
                          ),
                        );
                      }
                      return controller.orderListDraft.isEmpty
                          ? const EmptyCard()
                          : ListView.separated(
                              itemCount: controller.orderListDraft.length,
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  kHalfSizedBox,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () async {
                                  try {
                                    deliverTo ??= await getCurrentAddress();

                                    Get.to(
                                      () => CheckoutDraftScreen(
                                        order: controller.orderListDraft[index],
                                        deliverTo: deliverTo!,
                                      ),
                                      routeName: 'CheckoutDraftScreen',
                                      duration:
                                          const Duration(milliseconds: 300),
                                      fullscreenDialog: true,
                                      curve: Curves.easeIn,
                                      preventDuplicates: true,
                                      popGesture: true,
                                      transition: Transition.rightToLeft,
                                    );
                                  } catch (e) {
                                    ApiProcessorController.errorSnack(
                                      'Please set a default address first',
                                    );

                                    Get.to(
                                      () => const AddNewAddress(),
                                      routeName: 'AddNewAddress',
                                      duration:
                                          const Duration(milliseconds: 300),
                                      fullscreenDialog: true,
                                      curve: Curves.easeIn,
                                      preventDuplicates: true,
                                      popGesture: true,
                                      transition: Transition.rightToLeft,
                                    );
                                  }
                                },
                                child: TrackOrderDetailsContainer(
                                  order: controller.orderListDraft[index],
                                ),
                              ),
                            );
                    }),
                GetBuilder<OrderController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        controller.loadedAllDraft.value
                            ? Container(
                                margin: const EdgeInsets.only(top: 20),
                                height: 10,
                                width: 10,
                                decoration: ShapeDecoration(
                                    shape: const CircleBorder(),
                                    color: kPageSkeletonColor),
                              )
                            : const SizedBox(),
                        controller.isLoadMoreDraft.value
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
