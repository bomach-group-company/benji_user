import 'package:benji_user/app/vendor/vendor_details.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/vendor/popular_vendors_card.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/vendor/vendor.dart';
import '../../src/repo/utils/helpers.dart';
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

      await Future.delayed(Duration(microseconds: 100));
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 25),
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
      duration: Duration(milliseconds: 500),
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

  Map? _data;
  int start = 0;
  int end = 10;
  bool loadMore = false;
  bool thatsAllData = false;
  bool _isScrollToTopBtnVisible = false;

  _getData() async {
    await checkAuth(context);
    List<VendorModel> vendor = await getVendors(start: start, end: end);

    if (_data == null) {
      _data = {'vendor': []};
    }

    setState(() {
      thatsAllData = vendor.isEmpty;
      _data = {
        'vendor': _data!['vendor'] + vendor,
      };
    });
  }

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
      start = 0;
      end = 10;
    });
    await _getData();
  }

  //========================================================================\\
  @override
  Widget build(BuildContext context) {
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Popular Vendors ",
          toolbarHeight: 80,
          backgroundColor: kPrimaryColor,
          actions: [],
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
            : SizedBox(),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _data == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitChasingDots(color: kAccentColor),
                  ],
                )
              : Scrollbar(
                  controller: _scrollController,
                  scrollbarOrientation: ScrollbarOrientation.right,
                  radius: Radius.circular(10),
                  child: ListView(
                    dragStartBehavior: DragStartBehavior.down,
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(kDefaultPadding),
                          itemCount: loadMore
                              ? _data!['vendor'].length + 1
                              : _data!['vendor'].length,
                          separatorBuilder: (context, index) => kHalfSizedBox,
                          itemBuilder: (context, index) {
                            if (_data!['vendor'].length == index) {
                              return Column(
                                children: [
                                  SpinKitChasingDots(color: kAccentColor),
                                ],
                              );
                            }
                            return PopularVendorsCard(
                              onTap: () {
                                Get.to(
                                  () => VendorDetails(
                                      vendor: _data!['vendor'][index]),
                                  routeName: 'VendorDetails',
                                  duration: const Duration(milliseconds: 300),
                                  fullscreenDialog: true,
                                  curve: Curves.easeIn,
                                  preventDuplicates: true,
                                  popGesture: true,
                                  transition: Transition.rightToLeft,
                                );
                              },
                              cardImage: 'best-choice-restaurant.png',
                              vendorName: _data!['vendor'][index].shopName,
                              businessType:
                                  _data!['vendor'][index].shopType.name ??
                                      'Not Available',
                              rating: ((_data!['vendor'][index].averageRating
                                          as double?) ??
                                      0.0)
                                  .toStringAsPrecision(2)
                                  .toString(),
                              noOfUsersRated: (_data!['vendor'][index]
                                          .numberOfClientsReactions ??
                                      0)
                                  .toString(),
                            );
                          }),
                      thatsAllData
                          ? Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              height: 10,
                              width: 10,
                              decoration: ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: kPageSkeletonColor),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
