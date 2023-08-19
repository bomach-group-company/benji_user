import 'package:benji_user/src/providers/constants.dart';
import 'package:flutter/material.dart';

import '../button/category button.dart';

class CategoryButtonSection extends StatelessWidget {
  const CategoryButtonSection({
    super.key,
    required List category,
    required List<Color> categorybgColor,
    required List<Color> categoryFontColor,
  })  : _category = category,
        _categorybgColor = categorybgColor,
        _categoryFontColor = categoryFontColor;

  final List _category;
  final List<Color> _categorybgColor;
  final List<Color> _categoryFontColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: _category.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: CategoryButton(
            onPressed: () {},
            title: _category[index],
            bgColor: _categorybgColor[index],
            categoryFontColor: _categoryFontColor[index],
          ),
        ),
      ),
    );
  }
}
