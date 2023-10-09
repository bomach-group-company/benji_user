import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/repo/models/category/sub_category.dart';
import 'package:benji/theme/colors.dart';
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
                  height: 60,
                  width: 60,
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
                  height: 60,
                  width: 60,
                  decoration: ShapeDecoration(
                    color: kPageSkeletonColor,
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/icons/store.png",
                      ),
                      fit: BoxFit.contain,
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
