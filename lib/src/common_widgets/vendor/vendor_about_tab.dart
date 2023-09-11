// ignore_for_file: unused_local_variable

import 'package:benji_user/app/vendor/about_vendor.dart';
import 'package:benji_user/app/vendor/all_vendor_reviews.dart';
import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/repo/models/rating/ratings.dart';
import 'package:benji_user/src/repo/models/vendor/vendor.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class VendorsAboutTab extends StatefulWidget {
  final VendorModel vendor;

  const VendorsAboutTab({
    super.key,
    required this.vendor,
  });

  @override
  State<VendorsAboutTab> createState() => _VendorsAboutTabState();
}

class _VendorsAboutTabState extends State<VendorsAboutTab> {
  void _viewAllReviews() => Get.to(
        () => AllVendorReviews(vendor: widget.vendor),
        routeName: 'AllVendorReviews',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            flex: 0,
            child: AboutVendor(
              vendor: widget.vendor,
            ),
          ),
          TextButton(
            onPressed: _viewAllReviews,
            child: Text(
              "See all",
              style: TextStyle(
                color: kAccentColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          kSizedBox,
        ],
      ),
    );
  }
}
