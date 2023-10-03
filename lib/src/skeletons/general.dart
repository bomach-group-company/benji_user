import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/colors.dart';
import '../providers/constants.dart';
import 'page_skeleton.dart';

class GeneralSkeleton extends StatelessWidget {
  final int num;
  const GeneralSkeleton({
    super.key,
    this.num = 5,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const SizedBox(height: kDefaultPadding / 2),
      itemCount: num,
      addAutomaticKeepAlives: true,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int gap = 40;
        if (index % 2 == 0) {
          gap = 20;
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              highlightColor: kBlackColor.withOpacity(0.02),
              baseColor: kBlackColor.withOpacity(0.8),
              direction: ShimmerDirection.ltr,
              child: PageSkeleton(height: 20, width: media.width - gap),
            ),
          ],
        );
      },
    );
  }
}
