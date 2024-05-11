import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/cards/blog_card.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
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
                    text: 'Blogs',
                    current: 'Blogs',
                    hasBeadcrumb: true,
                    back: 'home',
                  ),
                  kSizedBox,
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: breakPoint(media.width, 25, 50, 50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutGrid(
                          columnSizes: breakPointDynamic(media.width, [1.fr],
                              [1.fr, 1.fr], [1.fr, 1.fr, 1.fr]),
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
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-2.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
                            MyBlogCard(
                              date: '1 July 2022',
                              from: 'Admin',
                              title:
                                  'The Ultimate Hangover Burger: Egg in a Hole Burger Grilled Cheese',
                              image: 'assets/frontend/assets/blog/blog-1.jpeg',
                              description:
                                  'Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy ipsum text. Lorem is dummy',
                            ),
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
