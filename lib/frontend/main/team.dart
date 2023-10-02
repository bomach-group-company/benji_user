import 'package:benji_user/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji_user/src/frontend/widget/section/breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/cards/team_card.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;

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
      drawerScrimColor: Colors.transparent,
      backgroundColor: const Color(0xfffafafc),
      appBar: const MyAppbar(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          children: [
            const MyBreadcrumb(
              text: 'Our Team',
              current: 'Our Team',
              hasBeadcrumb: true,
              back: 'home',
            ),
            kSizedBox,
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: breakPoint(media.width, 25, 50, 50),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutGrid(
                    columnSizes: breakPointDynamic(
                        media.width, [1.fr], [1.fr, 1.fr], [1.fr, 1.fr, 1.fr]),
                    rowSizes: const [
                      auto,
                      auto,
                      auto,
                      auto,
                      auto,
                      auto,
                      auto,
                      auto,
                      auto,
                      auto,
                      auto,
                      auto
                    ],
                    children: const [
                      MyTeamCard(),
                      MyTeamCard(),
                      MyTeamCard(),
                      MyTeamCard(),
                      MyTeamCard(),
                      MyTeamCard(),
                    ],
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
      endDrawer: const MyDrawer(),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(45, 45),
                  foregroundColor: kGreenColor,
                  side: const BorderSide(color: kGreenColor)),
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
