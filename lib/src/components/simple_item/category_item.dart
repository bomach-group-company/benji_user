import 'package:benji/src/providers/constants.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final dynamic category;
  final Function() nav;
  final bool isShop;
  const CategoryItem(
      {super.key, this.category, required this.nav, this.isShop = true});

  @override
  Widget build(BuildContext context) {
    bool showAll = category == null;
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
                    image: DecorationImage(
                      image: AssetImage(
                        isShop
                            ? "assets/icons/store.png"
                            : "assets/icons/shopping-bag.png",
                      ),
                      fit: BoxFit.contain,
                    ),
                    shape: const OvalBorder(),
                  ),
                ),
          kHalfSizedBox,
          SizedBox(
            width: 60,
            height: 40,
            child: Text(
              showAll ? 'All' : category!.name,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.parent,
            ),
          )
        ],
      ),
    );
  }
}
