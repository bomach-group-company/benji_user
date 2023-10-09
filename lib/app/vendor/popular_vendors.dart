import 'dart:math';

import 'package:benji/app/vendor/vendor_details.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/vendor/vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../src/repo/models/vendor/vendor.dart';
import '../../theme/colors.dart';

class PopularVendors extends StatefulWidget {
  const PopularVendors({super.key});

  @override
  State<PopularVendors> createState() => _PopularVendorsState();
}

class _PopularVendorsState extends State<PopularVendors> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(_scrollListener);
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
    if (loadMore || thatsAllData) return;

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        loadMore = true;
        start = end;
        end = end + 10;
      });

      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 25),
        curve: Curves.easeInOut,
      );
      await _getData();

      setState(() {
        loadMore = false;
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

  List<VendorModel>? _vendor;
  int start = 0;
  int end = 10;
  bool loadMore = false;
  bool thatsAllData = false;
  bool _isScrollToTopBtnVisible = false;

  _getData() async {
    List<VendorModel> vendor = await getPopularVendors();

    _vendor ??= [];
    thatsAllData = start >= 10;
    if (!thatsAllData) {
      setState(() {
        _vendor = _vendor! + vendor.sublist(0, min(5, vendor.length));
      });
    }
  }

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _vendor = null;
      start = 0;
      end = 10;
    });
    await _getData();
  }

  //========================================================================\\
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Popular Vendors ",
          toolbarHeight: 80,
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
          child: _vendor == null
              ? Center(child: CircularProgressIndicator(color: kAccentColor))
              : Scrollbar(
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
                        rowSizes: _vendor!.isEmpty
                            ? [auto]
                            : List.generate(_vendor!.length, (index) => auto),
                        children: (_vendor!).map((item) {
                          return VendorsCard(
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
                            removeDistance: true,
                            cardImage: 'assets/images/vendors/ntachi-osa.png',
                            vendorName: item.shopName ?? "Not Available",
                            typeOfBusiness:
                                item.shopType?.name ?? 'Not Available',
                            rating:
                                "${((item.averageRating) ?? 0.0).toStringAsPrecision(2).toString()} (${(item.numberOfClientsReactions ?? 0).toString()})",
                          );
                        }).toList(),
                      ),
                      thatsAllData
                          ? Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              height: 10,
                              width: 10,
                              decoration: ShapeDecoration(
                                  shape: const CircleBorder(),
                                  color: kPageSkeletonColor),
                            )
                          : const SizedBox(),
                      loadMore
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: kAccentColor),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
