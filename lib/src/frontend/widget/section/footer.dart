import 'package:benji_user/frontend/main/about.dart';
import 'package:benji_user/frontend/main/contact_us.dart';
import 'package:benji_user/frontend/main/faqs.dart';
import 'package:benji_user/frontend/main/privacy_policy.dart';
import 'package:benji_user/frontend/main/refund_policy.dart';
import 'package:benji_user/frontend/main/team.dart';
import 'package:benji_user/frontend/main/term_condition.dart';
import 'package:benji_user/frontend/store/categories.dart';
import 'package:benji_user/src/frontend/widget/clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/constants.dart';
import '../../utils/constant.dart';
import '../footer_column_text.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    int currentYear = now.year;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: breakPoint(
              media.width,
              20,
              responsiveSize(
                  size: media.width, points: [50, 100, 100, 100, 100]),
              80)),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/frontend/assets/footer/footer_bg_1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          LayoutGrid(
            columnSizes:
                breakPointDynamic(media.width, [1.fr], [1.fr], [1.fr, 2.fr]),
            rowSizes: const [auto, auto],
            rowGap: 40,
            columnGap: 24,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHalfSizedBox,
                    Image.asset(
                      'assets/frontend/assets/brand/benji-logo-resized.jpg',
                      // fit: BoxFit.cover,
                      // height: 150,
                    ),
                    kSizedBox,
                    Text(
                      'Seamless Shopping and Delivery.',
                      style: GoogleFonts.oleoScript(
                          color: Colors.white,
                          fontSize: media.width * 0.035 + 20,
                          height: 1),
                    ),
                    kSizedBox,
                    const Text(
                      'Shop smarter, happier, and get all your needs in one place. Welcome to Benji, your ultimate convenience hub for a wide range of products.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: breakPoint(media.width, 0, 0, 25),
                    right: breakPoint(media.width, 25, 0, 60)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FooterColumnText(
                          head: 'About Us',
                          items: [
                            ['About', AboutPage()],
                            ['Our Team', TeamPage()],
                            ['FAQs', FAQsPage()]
                          ],
                        ),
                        FooterColumnText(
                          head: 'Legal',
                          items: [
                            ['Privacy Policy', PrivacyPolicyPage()],
                            ['Terms & Conditions', TermConditionPage()],
                            ['Refund Policy', RefundPolicyPage()],
                          ],
                        ),
                        FooterColumnText(
                          head: 'Other pages',
                          items: [
                            ['Products', CategoriesPage()],
                            ['Contact us', ContactUs()],
                            // ['Blogs', BlogsPage()]
                          ],
                        ),
                      ],
                    ),
                    kSizedBox,
                    kSizedBox,
                    Row(
                      children: [
                        Container(
                          constraints: BoxConstraints.loose(
                            const Size(150, 90),
                          ),
                          child: MyClickable(
                              child: Image.asset(
                                  'assets/frontend/assets/store/playstore.png')),
                        ),
                        kWidthSizedBox,
                        Container(
                          constraints: BoxConstraints.loose(
                            const Size(160, 100),
                          ),
                          child: MyClickable(
                              child: Image.asset(
                                  'assets/frontend/assets/store/appstore.png')),
                        ),
                      ],
                    ),
                    kSizedBox,
                    const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                          size: 40,
                        ),
                        kWidthSizedBox,
                        Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                          size: 40,
                        ),
                        kWidthSizedBox,
                        Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.white,
                          size: 40,
                        ),
                        kWidthSizedBox,
                        Icon(
                          FontAwesomeIcons.youtube,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                    kSizedBox,
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: const Color(0xffdc3545).withOpacity(0.2),
          ),
          Text(
            'Copyright @ $currentYear. All rights reserved',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: breakPoint(media.width, 14, 15, 17),
            ),
          ),
        ],
      ),
    );
  }
}