import 'package:benji/frontend/store/categories.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:carousel_slider/carousel_controller.dart' as hero_carousel;
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';

class MyHero extends StatelessWidget {
  final hero_carousel.CarouselController buttonCarouselController;
  final String image;
  final String text1;
  final String text2;
  final bool hasExplore;
  const MyHero(
      {super.key,
      required this.image,
      required this.text1,
      required this.text2,
      required this.buttonCarouselController,
      this.hasExplore = false});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Container(
      width: media.width,
      height: media.height,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => buttonCarouselController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              ),
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white70,
                size: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: media.width < 400
                      ? media.width * 0.7
                      : media.width * 0.80,
                  child: Text(
                    text1,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: media.width * 0.035 + 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  width: media.width < 500
                      ? media.width * 0.7
                      : media.width * 0.80,
                  child: Text(
                    text2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: media.width * 0.05 + 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                kHalfSizedBox,
                Visibility(
                  visible: hasExplore,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 15,
                      ),
                      backgroundColor: kAccentColor,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        MyClickable(
                          navigate: CategoriesPage(),
                          child: Text(
                            'Explore',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 15),
                          ),
                        ),
                        Icon(
                          Icons.arrow_circle_right,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () => buttonCarouselController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              ),
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white70,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
