import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/rating_view/customer_review_card.dart';
import '../../src/components/section/rate_vendor_dialog.dart';
import '../../src/components/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/my_liquid_refresh.dart';
import '../../src/repo/models/rating/ratings.dart';
import '../../src/repo/models/vendor/vendor.dart';
import '../../theme/colors.dart';

class AllBusinessReviews extends StatefulWidget {
  final BusinessModel business;

  const AllBusinessReviews({super.key, required this.business});

  @override
  State<AllBusinessReviews> createState() => _AllBusinessReviewsState();
}

class _AllBusinessReviewsState extends State<AllBusinessReviews> {
//============================================= INITIAL STATE AND DISPOSE  ===================================================\\
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
//==========================================================================================\\

  //=================================== ALL VARIABLES ====================================\\

  //=================================== CONTROLLERS ====================================\\
  final ScrollController _scrollController = ScrollController();

//=================================================== FUNCTIONS =====================================================\\
  void validate() {
    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "Thank you for your feedback!",
      const Duration(seconds: 1),
    );

    Get.back();
  }

  bool _isScrollToTopBtnVisible = false;
  Map? _data;
  int start = 0;
  int end = 10;
  bool loadMore = false;
  bool thatsAllData = false;

  _getData() async {
    List<Ratings> ratings = await getRatingsByVendorId(
        widget.business.vendorOwner.id,
        start: start,
        end: end);

    _data ??= {'ratings': []};
    setState(() {
      thatsAllData = ratings.isEmpty;
      _data = {'ratings': _data!['ratings'] + ratings};
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
      start = 0;
      end = 10;
    });
    await _getData();
  }

  //========================================================================\\

//================================ Rating Dialog ======================================\\
  openRatingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding)),
          elevation: 50,
          child: RateVendorDialog(business: widget.business),
        );
      },
    );
    setState(() {
      start = 0;
      end = 5;
      _data = {'ratings': []};
    });
    await _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "All Reviews",
          elevation: 0.0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: MyElevatedButton(
            title: "Add a review",
            onPressed: () {
              openRatingDialog(context);
            },
          ),
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
          child: Scrollbar(
            controller: _scrollController,
            child: _data == null
                ? Center(child: CircularProgressIndicator(color: kAccentColor))
                : ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    dragStartBehavior: DragStartBehavior.down,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      kHalfSizedBox,
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => kSizedBox,
                          itemCount: loadMore
                              ? _data!['ratings'].length + 1
                              : _data!['ratings'].length,
                          itemBuilder: (BuildContext context, int index) {
                            if (_data!['ratings'].length == index) {
                              return Column(
                                children: [
                                  CircularProgressIndicator(
                                      color: kAccentColor),
                                ],
                              );
                            }
                            return CostumerReviewCard(
                                rating: _data!['ratings'][index]);
                          }),
                      thatsAllData
                          ? Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 10,
                              width: 10,
                              decoration: ShapeDecoration(
                                  shape: const CircleBorder(),
                                  color: kPageSkeletonColor),
                            )
                          : const SizedBox(),
                      const SizedBox(height: kDefaultPadding * 4),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
