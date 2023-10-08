import 'package:benji_user/src/providers/constants.dart';
import 'package:benji_user/src/repo/models/category/sub_category.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final SubCategory? subSategory;
  final Function() nav;
  const CategoryItem({super.key, this.subSategory, required this.nav});

  @override
  Widget build(BuildContext context) {
    bool showAll = subSategory == null;
    return InkWell(
      onTap: nav,
      child: Column(
        children: [
          showAll
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: ShapeDecoration(
                    color: kAccentColor,
                    shape: const OvalBorder(),
                  ),
                  child: Icon(
                    Icons.more_horiz,
                    color: kPrimaryColor,
                  ),
                )
              : Container(
                  height: 50,
                  width: 50,
                  decoration: ShapeDecoration(
                    color: kPageSkeletonColor,
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/profile/avatar-image.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: const OvalBorder(),
                  ),
                ),
          kHalfSizedBox,
          Text(
            showAll ? 'All' : subSategory!.name,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textWidthBasis: TextWidthBasis.parent,
          )
        ],
      ),
    );
  }
}
