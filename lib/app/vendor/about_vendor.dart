import 'package:benji_user/src/common_widgets/empty.dart';
import 'package:benji_user/src/repo/models/rating/ratings.dart';
import 'package:benji_user/src/repo/models/vendor/vendor.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/common_widgets/rating_view/customer_review_card.dart';
import '../../src/providers/constants.dart';

class AboutVendor extends StatefulWidget {
  final VendorModel vendor;
  const AboutVendor({
    super.key,
    required this.vendor,
  });

  @override
  State<AboutVendor> createState() => _AboutVendorState();
}

class _AboutVendorState extends State<AboutVendor> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  final List<String> stars = ['5', '4', '3', '2', '1'];
  String active = 'all';

  List<Ratings>? ratings = [];
  _getData() async {
    setState(() {
      ratings = null;
    });

    List<Ratings> _ratings;
    if (active == 'all') {
      _ratings = await getRatingsByVendorId(widget.vendor.id!);
    } else {
      _ratings = await getRatingsByVendorIdAndRating(
          widget.vendor.id!, int.parse(active));
    }

    setState(() {
      ratings = _ratings;
    });
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    // double mediaHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About This Business",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          kSizedBox,
          Container(
            width: mediaWidth,
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: ShapeDecoration(
              color: const Color(0xFFFEF8F8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.50,
                  color: Color(0xFFFDEDED),
                ),
                borderRadius: BorderRadius.circular(25),
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
            child: Text(
              widget.vendor.shopType == null
                  ? 'Not Available'
                  : widget.vendor.shopType!.description ?? 'Not Available',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          kSizedBox,
          const Text(
            "Working Hours",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          kSizedBox,
          Container(
            width: mediaWidth,
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: ShapeDecoration(
              color: const Color(0xFFFEF8F8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.50,
                  color: Color(0xFFFDEDED),
                ),
                borderRadius: BorderRadius.circular(25),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Mon. - Fri.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfWidthSizedBox,
                        Text(
                          " - ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                    Row(
                      children: [
                        Text(
                          "Sat.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfWidthSizedBox,
                        Text(
                          " - ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                    Row(
                      children: [
                        Text(
                          "Sun.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfWidthSizedBox,
                        Text(
                          " - ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          kSizedBox,
          Container(
            width: mediaWidth,
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: ShapeDecoration(
              color: const Color(0xFFFEF8F8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.50,
                  color: Color(0xFFFDEDED),
                ),
                borderRadius: BorderRadius.circular(25),
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
                Text(
                  "Reviews View & Ratings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kDefaultPadding * 0.5,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: active == 'all'
                                  ? kAccentColor
                                  : Color(
                                      0xFFA9AAB1,
                                    ),
                            ),
                            backgroundColor:
                                active == 'all' ? kAccentColor : kPrimaryColor,
                            foregroundColor: active == 'all'
                                ? kPrimaryColor
                                : Color(0xFFA9AAB1),
                          ),
                          onPressed: () async {
                            active = 'all';
                            setState(() {
                              ratings = null;
                            });

                            List<Ratings> _ratings =
                                await getRatingsByVendorId(widget.vendor.id!);

                            setState(() {
                              ratings = _ratings;
                            });
                          },
                          child: Text(
                            'All',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          children: stars
                              .map(
                                (item) => Row(
                                  children: [
                                    kHalfWidthSizedBox,
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: active == item
                                              ? kStarColor
                                              : Color(0xFFA9AAB1),
                                        ),
                                        foregroundColor: active == item
                                            ? kStarColor
                                            : Color(0xFFA9AAB1),
                                      ),
                                      onPressed: () async {
                                        active = item;

                                        setState(() {
                                          ratings = null;
                                        });

                                        List<Ratings> _ratings =
                                            await getRatingsByVendorIdAndRating(
                                                widget.vendor.id!,
                                                int.parse(active));

                                        setState(() {
                                          ratings = _ratings;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: kDefaultPadding * 0.2,
                                          ),
                                          Text(
                                            '$item',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        kHalfWidthSizedBox,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          kSizedBox,
          ratings == null
              ? Center(
                  child: SpinKitChasingDots(
                    color: kAccentColor,
                    duration: const Duration(seconds: 1),
                  ),
                )
              : ratings!.isEmpty
                  ? EmptyCard(
                      removeButton: true,
                    )
                  : ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => kSizedBox,
                      shrinkWrap: true,
                      itemCount: ratings!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CostumerReviewCard(rating: ratings![index]),
                    ),
        ],
      ),
    );
  }
}
