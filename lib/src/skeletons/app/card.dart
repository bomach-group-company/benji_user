import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/skeletons/page_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/colors.dart';

class CardSkeleton extends StatelessWidget {
  final double height;
  final double width;
  const CardSkeleton({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          highlightColor: kBlackColor.withOpacity(0.9),
          baseColor: kBlackColor.withOpacity(0.6),
          direction: ShimmerDirection.ltr,
          child: PageSkeleton(height: height * 0.55, width: width),
        ),
        kSizedBox,
        Shimmer.fromColors(
          highlightColor: kBlackColor.withOpacity(0.9),
          baseColor: kBlackColor.withOpacity(0.6),
          direction: ShimmerDirection.ltr,
          child: PageSkeleton(height: (height * 0.55 / 6), width: width),
        ),
        kSizedBox,
        Shimmer.fromColors(
          highlightColor: kBlackColor.withOpacity(0.9),
          baseColor: kBlackColor.withOpacity(0.6),
          direction: ShimmerDirection.ltr,
          child: PageSkeleton(height: (height * 0.55 / 6), width: width * 0.8),
        ),
        kSizedBox,
        Shimmer.fromColors(
          highlightColor: kBlackColor.withOpacity(0.9),
          baseColor: kBlackColor.withOpacity(0.6),
          direction: ShimmerDirection.ltr,
          child: PageSkeleton(height: (height * 0.55 / 6), width: width * 0.85),
        ),
      ],
    );
  }
}
