import 'package:benji/frontend/store/category.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:benji/src/repo/models/category/category.dart';
import 'package:flutter/material.dart';

import '../../src/frontend/model/category.dart';
import '../../src/frontend/utils/constant.dart';
import '../../src/frontend/widget/cards/circle_card.dart';
import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool _showBackToTopButton = false;
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
    _categories = fetchCategories();
    super.initState();
  }

  late Future<List<Category>> _categories;

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
      // ignore: prefer_const_constructors
      appBar: MyAppbar(hideSearch: false),
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
                    text: 'Categories',
                    current: 'Categories',
                    hasBeadcrumb: true,
                    back: 'home',
                  ),
                  kSizedBox,
                  FutureBuilder(
                    future: _categories,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error occured refresh'),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: kAccentColor,
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: breakPoint(media.width, 25, 50, 50),
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: (snapshot.data as List<Category>)
                                .map(
                                  (item) => MyClickable(
                                    navigate: CategoryPage(
                                      activeCategory: item,
                                    ),
                                    child: SizedBox(
                                      height: 240,
                                      width: 200,
                                      child: MyCicleCard(
                                        image: item.image,
                                        text: item.name.toString(),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }
                    },
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
