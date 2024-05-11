import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/cards/team_card.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;
  List<List<String>> team = [
    [
      'Tochukwu David',
      'CEO',
      'Leads the entire team',
      'assets/images/team/IMG-20231219-WA0021.jpg'
    ],
    [
      'George Arinze',
      'CTO / Engineering Manager',
      'Manages the team especially the backend development',
      'assets/images/team/IMG-20231010-WA0048.jpg'
    ],
    [
      'Ozioma Ogbozor',
      'Head marketing department',
      'Leads the team on marketing and product testing',
      'assets/images/team/IMG-20231010-WA0053.jpg'
    ],
    [
      'Caleb Chinedu',
      'Civil Engineer',
      'Worked on Engineering',
      'assets/images/team/IMG-20231010-WA0012.jpg'
    ],
    [
      'Gideon Chukwuoma',
      'Senior Software Engineer',
      'Built out most of the UI and key features',
      'assets/images/team/Gideon.jpg'
    ],
    [
      'Emmanuel Nwaegunwa',
      'Senior Software Engineer',
      'Consumed most of the API on the app. Built and optimized the UI',
      'assets/images/team/maxzeno.jpg'
    ],
  ];

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
                    children: team
                        .map((item) => MyTeamCard(
                              name: item[0],
                              position: item[1],
                              description: item[2],
                              image: item[3],
                            ))
                        .toList(),
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
