import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:flutter/material.dart';

import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/frontend/widget/text/content_text.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 400 && _showBackToTopButton == false) {
          setState(() {
            _showBackToTopButton = true;
          });
        } else if (!(_scrollController.offset >= 400) &&
            _showBackToTopButton == true) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      drawerScrimColor: kTransparentColor,
      backgroundColor: kPrimaryColor,
      appBar: const MyAppbar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                children: [
                  const MyBreadcrumb(
                    text: 'About Us',
                    current: 'About Us',
                    hasBeadcrumb: true,
                    back: 'home',
                  ),
                  kSizedBox,
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: breakPoint(media.width, 25, 50, 50),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyContentText(
                          title: 'About Us',
                          content: '''
Benji: The Future of Online Shopping and Seamless Logistics
Welcome to Benji, the innovative multi-vendor e-commerce and logistics platform, born from the powerful collaboration between Bomach Group of Company and Alpha Logistics. We are a dynamic team of industry leaders dedicated to revolutionizing the way you shop and experience seamless deliveries. Benji is the revolutionary platform that seamlessly combines e-commerce and logistics, empowering you with a complete shopping and delivery solution. We are at the forefront of transforming your shopping experience.''',
                        ),
                        MyContentText(
                          title: 'Our vision',
                          content: '''
Our vision is to create a platform that seamlessly integrates e-commerce and logistics, setting new standards in customer convenience and satisfaction. We strive to be the go-to destination for online shopping, providing a vast array of products from multiple vendors, all in one place. We envision a future where shopping and logistics converge harmoniously, providing you with unmatched convenience, reliability, and satisfaction. Benji is designed to cater to all your needs, from browsing a diverse range of products to ensuring timely and secure deliveries to your doorstep.''',
                        ),
                        MyContentText(
                          title: 'The Power of Integration',
                          content: '''
The collaboration between Bomach Group of Company and Alpha Logistics has given birth to Benji - your all-in-one solution for e-commerce and seamless logistics. By integrating Alpha Logistics' expertise in courier services with Bomach Group's experience in diverse sectors, we have created a unique ecosystem where efficiency meets excellence.''',
                        ),
                        MyContentText(
                          title: 'Convenient Online Shopping:',
                          content: '''
Discover an extensive range of products on Benji, carefully curated from reputable vendors. Our user-friendly interface ensures a delightful shopping experience as you browse and find what you need effortlessly.''',
                        ),
                        MyContentText(
                          title: 'Efficient and Reliable Logistics:',
                          content: '''
Our trusted logistics arm, guarantees efficient and reliable delivery services. With real-time tracking, you stay updated on your package's journey from the vendor to your doorstep, ensuring a secure and timely delivery.''',
                        ),
                        MyContentText(
                          title: 'Supporting Local Businesses:',
                          content: '''
Benji fosters a community of local vendors, promoting their products and giving them a wider audience. By choosing Benji, you contribute to the growth of your community while enjoying unique and high-quality offerings.''',
                        ),
                        MyContentText(
                          title: 'OUR MISSION',
                          content: '''
Our mission is clear - to provide you with the most convenient, reliable, and enjoyable shopping and logistics experience. We are committed to supporting local businesses, ensuring timely deliveries, and exceeding your expectations with every interaction.''',
                        ),
                        MyContentText(
                          title: 'Supporting Local Businesses:',
                          content: '''
Benji fosters a community of local vendors, promoting their products and giving them a wider audience. By choosing Benji, you contribute to the growth of your community while enjoying unique and high-quality offerings.''',
                        ),
                      ],
                    ),
                  ),
                  kSizedBox,
                  kSizedBox,
                  kSizedBox,
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: const MyDrawer(),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(45, 45),
                  foregroundColor: kAccentColor,
                  side: BorderSide(color: kAccentColor)),
              onPressed: _scrollToTop,
              child: const Icon(
                Icons.arrow_upward,
                size: 20,
              ),
            ),
    );
  }
}
