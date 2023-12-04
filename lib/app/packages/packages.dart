import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/controller/package_controller.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/others/empty.dart';
import '../../src/providers/constants.dart';
import 'view_package.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages>
    with SingleTickerProviderStateMixin {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    _tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

//================================================= CONTROLLERS ===================================================\\
  late TabController _tabBarController;
  final _scrollController = ScrollController();
//================================================= FUNCTIONS ===================================================\\

  Future<void> _handleRefresh() async {}

  int _selectedtabbar = 0;
  void _clickOnTabBarOption(value) async {
    setState(() {
      _selectedtabbar = value;
    });
  }

//================================================= Navigation ===================================================\\

  void _viewPendingPackage(deliveryItem) => Get.to(
        () => ViewPackage(deliveryItem: deliveryItem),
        routeName: 'ViewPackage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.size,
      );

  void _viewDeliveredPackage(deliveryItem) => Get.to(
        () => ViewPackage(deliveryItem: deliveryItem),
        routeName: 'ViewPackage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.size,
      );

  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "My Packages",
          elevation: 0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(kDefaultPadding),
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Container(
                    width: media.width,
                    decoration: BoxDecoration(
                      color: kDefaultCategoryBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: kLightGreyColor,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TabBar(
                            controller: _tabBarController,
                            onTap: (value) => _clickOnTabBarOption(value),
                            enableFeedback: true,
                            dragStartBehavior: DragStartBehavior.start,
                            mouseCursor: SystemMouseCursors.click,
                            automaticIndicatorColorAdjustment: true,
                            overlayColor:
                                MaterialStatePropertyAll(kAccentColor),
                            labelColor: kPrimaryColor,
                            unselectedLabelColor: kTextGreyColor,
                            indicatorColor: kAccentColor,
                            indicatorWeight: 2,
                            splashBorderRadius: BorderRadius.circular(50),
                            indicator: BoxDecoration(
                              color: kAccentColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            tabs: const [
                              Tab(text: "Pending"),
                              Tab(text: "Completed"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kSizedBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _selectedtabbar == 0
                      ? GetBuilder<MyPackageController>(
                          initState: (state) => MyPackageController.instance
                              .getDeliveryItemsByPending(),
                          builder: (controller) {
                            if (controller.isLoadPending.value &&
                                controller.pendingPackages.isEmpty) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              );
                            }
                            return SizedBox(
                              width: media.width,
                              child: Column(
                                children: [
                                  controller.pendingPackages.isEmpty
                                      ? const EmptyCard(
                                          removeButton: true,
                                        )
                                      : ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(color: kGreyColor),
                                          itemCount:
                                              controller.pendingPackages.length,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              ListTile(
                                            onTap: () => _viewPendingPackage(
                                                controller
                                                    .pendingPackages[index]),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            enableFeedback: true,
                                            dense: true,
                                            leading: FaIcon(
                                              FontAwesomeIcons.boxesStacked,
                                              color: kAccentColor,
                                            ),
                                            title: Text(
                                              controller.pendingPackages[index]
                                                  .itemName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: kTextBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            subtitle: Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                      text: "Price:"),
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                    text:
                                                        "₦${formattedText(controller.pendingPackages[index].prices)}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'sen',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: FaIcon(
                                              FontAwesomeIcons.hourglassHalf,
                                              color: kSecondaryColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            );
                          },
                        )
                      : GetBuilder<MyPackageController>(
                          initState: (state) => MyPackageController.instance
                              .getDeliveryItemsByDelivered(),
                          builder: (controller) {
                            if (controller.isLoadDelivered.value &&
                                controller.deliveredPackages.isEmpty) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              );
                            }
                            return SizedBox(
                              width: media.width,
                              child: Column(
                                children: [
                                  controller.deliveredPackages.isEmpty
                                      ? const EmptyCard(
                                          removeButton: true,
                                        )
                                      : ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(color: kGreyColor),
                                          itemCount: controller
                                              .deliveredPackages.length,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              ListTile(
                                            onTap: () => _viewDeliveredPackage(
                                                (controller
                                                    .deliveredPackages[index])),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            enableFeedback: true,
                                            dense: true,
                                            leading: FaIcon(
                                              FontAwesomeIcons.boxesStacked,
                                              color: kAccentColor,
                                            ),
                                            title: Text(
                                              controller
                                                  .deliveredPackages[index]
                                                  .itemName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: kTextBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            subtitle: Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                      text: "Price:"),
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                    text:
                                                        "₦${formattedText(controller.deliveredPackages[index].prices)}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'sen',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: const FaIcon(
                                              FontAwesomeIcons.solidCircleCheck,
                                              color: kSuccessColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
