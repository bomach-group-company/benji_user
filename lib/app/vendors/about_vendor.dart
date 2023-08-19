import 'package:flutter/material.dart';


import '../../src/common_widgets/rating_view/customer_review_card.dart';
import '../../src/common_widgets/rating_view/star_row.dart';
import '../../src/providers/constants.dart';


class AboutVendor extends StatefulWidget {
  final String vendorName;
  final String vendorHeadLine;
  final String monToFriOpeningHours;
  final String monToFriClosingHours;
  final String satOpeningHours;
  final String satClosingHours;
  final String sunOpeningHours;
  final String sunClosingHours;
  const AboutVendor({
    super.key,
    required this.vendorName,
    required this.vendorHeadLine,
    required this.monToFriOpeningHours,
    required this.monToFriClosingHours,
    required this.satOpeningHours,
    required this.satClosingHours,
    required this.sunOpeningHours,
    required this.sunClosingHours,
  });

  @override
  State<AboutVendor> createState() => _AboutVendorState();
}

class _AboutVendorState extends State<AboutVendor> {
//============================================= INITIAL STATE AND DISPOSE  ===================================================\\
  @override
  void initState() {
    super.initState();

  }

//============================================= FUNCTIONS  ===================================================\\

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return Container(
      height: mediaHeight,
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
              widget.vendorHeadLine,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          kSizedBox,
          const Text(
            "Opening Hours",
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mon. - Fri.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kSizedBox,
                    Text(
                      "Sat.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kSizedBox,
                    Text(
                      "Sun.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: kDefaultPadding * 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.monToFriOpeningHours.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: " - ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: widget.monToFriClosingHours.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.satOpeningHours.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: " - ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: widget.satClosingHours.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.sunOpeningHours.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: " - ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: widget.sunClosingHours.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
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
                  child: StarRow(),
                ),
              ],
            ),
          ),
          kSizedBox,
          ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) => kSizedBox,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return CostumerReviewCard(
                mediaWidth: mediaWidth,
              );
            },
          ),
        ],
      ),
    );
  }
}
