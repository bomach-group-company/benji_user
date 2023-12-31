import 'package:benji/app/vendor/vendor_details.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/controller/vendor_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/vendor/vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';

class VendorsNearYou extends StatefulWidget {
  const VendorsNearYou({super.key});

  @override
  State<VendorsNearYou> createState() => _VendorsNearYouState();
}

class _VendorsNearYouState extends State<VendorsNearYou> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(() =>
        VendorController.instance.scrollListenerVendor(_scrollController));
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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(() {});
  }

  bool _isScrollToTopBtnVisible = false;

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {}

  //========================================================================\\
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Vendors Near You",
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        floatingActionButton: _isScrollToTopBtnVisible
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                mini: true,
                backgroundColor: kAccentColor,
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                tooltip: "Scroll to top",
                hoverColor: kAccentColor,
                hoverElevation: 50.0,
                child: const Icon(Icons.keyboard_arrow_up),
              )
            : const SizedBox(),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: GetBuilder<VendorController>(
            builder: (controller) {
              if (controller.isLoad.value && controller.vendorList.isEmpty) {
                return Center(
                    child: CircularProgressIndicator(color: kAccentColor));
              }
              return Scrollbar(
                controller: _scrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                radius: const Radius.circular(10),
                child: ListView(
                  dragStartBehavior: DragStartBehavior.down,
                  controller: _scrollController,
                  padding: deviceType(media.width) > 2
                      ? const EdgeInsets.all(kDefaultPadding)
                      : const EdgeInsets.all(kDefaultPadding / 2),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    LayoutGrid(
                      rowGap: kDefaultPadding / 2,
                      columnGap: kDefaultPadding / 2,
                      columnSizes: breakPointDynamic(
                          media.width,
                          [1.fr],
                          [1.fr, 1.fr],
                          [1.fr, 1.fr, 1.fr],
                          [1.fr, 1.fr, 1.fr, 1.fr]),
                      rowSizes: controller.vendorList.isEmpty
                          ? [auto]
                          : List.generate(
                              controller.vendorList.length, (index) => auto),
                      children: (controller.vendorList).map((item) {
                        return VendorsCard(
                          vendor: item,
                          onTap: () {
                            Get.to(
                              () => VendorDetails(vendor: item),
                              routeName: 'VendorDetails',
                              duration: const Duration(milliseconds: 300),
                              fullscreenDialog: true,
                              curve: Curves.easeIn,
                              preventDuplicates: true,
                              popGesture: true,
                              transition: Transition.rightToLeft,
                            );
                          },
                        );
                      }).toList(),
                    ),
                    controller.loadedAllVendor.value
                        ? Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            height: 10,
                            width: 10,
                            decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                color: kPageSkeletonColor),
                          )
                        : const SizedBox(),
                    controller.isLoadMoreVendor.value
                        ? Column(
                            children: [
                              kSizedBox,
                              Center(
                                child: CircularProgressIndicator(
                                    color: kAccentColor),
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
