import 'package:benji/frontend/join_us/crm.dart';
import 'package:benji/frontend/join_us/rider.dart';
import 'package:benji/frontend/join_us/vendor.dart';
import 'package:benji/src/frontend/utils/constant.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:flutter/material.dart';

import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class JoinUsPage extends StatefulWidget {
  const JoinUsPage({super.key});

  @override
  State<JoinUsPage> createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage>
    with SingleTickerProviderStateMixin {
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;
  late TabController _tabBarController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });
    super.initState();
    _tabBarController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabBarController.dispose();
    super.dispose();
  }

  int _selectedtabbar = 0;
  void _clickOnTabBarOption(value) async {
    setState(() {
      _selectedtabbar = value;
    });
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
                    text: 'Join Us',
                    current: 'Join Us',
                    hasBeadcrumb: true,
                    back: 'home',
                  ),
                  kSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceType(media.width) > 2 ? 100 : 20),
                        color: Colors.white,
                        padding: const EdgeInsets.all(5.0),
                        child: TabBar(
                          controller: _tabBarController,
                          onTap: (value) => _clickOnTabBarOption(value),
                          splashBorderRadius: BorderRadius.circular(50),
                          enableFeedback: true,
                          mouseCursor: SystemMouseCursors.click,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: kTransparentColor,
                          automaticIndicatorColorAdjustment: true,
                          labelColor: kPrimaryColor,
                          unselectedLabelColor: kTextGreyColor,
                          indicator: BoxDecoration(
                            color: kAccentColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          tabs: const [
                            Tab(text: "Business owner"),
                            Tab(text: "Rider"),
                            Tab(
                              text: 'CRM',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceType(media.width) > 2 ? 100 : 20),
                        child: _selectedtabbar == 0
                            ? const VendorTab()
                            : _selectedtabbar == 1
                                ? const RiderTab()
                                : const CRMTab(),
                      )
                    ],
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
                // color: Colors.white,
              ),
            ),
    );
  }
}
