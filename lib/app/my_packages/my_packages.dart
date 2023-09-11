import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/src/repo/models/package/delivery_item.dart';
import 'package:benji_user/src/repo/utils/helpers.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import 'view_package.dart';

class MyPackages extends StatefulWidget {
  const MyPackages({super.key});

  @override
  State<MyPackages> createState() => _MyPackagesState();
}

class _MyPackagesState extends State<MyPackages>
    with SingleTickerProviderStateMixin {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: 2, vsync: this);
    checkAuth(context);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }
//==========================================================================================\\

//================================================= ALL VARIABLES ===================================================\\

//================================================= CONTROLLERS ===================================================\\
  late TabController _tabBarController;
  final _scrollController = ScrollController();

//================================================= BOOL VALUES ===================================================\\
  bool _loadingTabBarContent = false;

//================================================= FUNCTIONS ===================================================\\

  Future<Map> _getData() async {
    // List<DeliveryItem> pending = await getDeliveryItemsByClient();
    // List<DeliveryItem> completed = await getDeliveryItemsByClient();
    List<DeliveryItem> generic = await getDeliveryItemsByClient();
    print(generic);

    Map data = {
      'pending': generic,
      'completed': generic,
    };
    return data;
  }

  Future<void> _handleRefresh() async {
    // setState(() {});
  }

  void _clickOnTabBarOption() async {
    setState(() {
      _loadingTabBarContent = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _loadingTabBarContent = false;
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
    double mediaWidth = MediaQuery.of(context).size.width;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "My Packages",
          elevation: 0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            child: FutureBuilder(
                future: _getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(kDefaultPadding),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          child: Container(
                            width: mediaWidth,
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
                                    onTap: (value) => _clickOnTabBarOption(),
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
                                    splashBorderRadius:
                                        BorderRadius.circular(50),
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
                          child: AutoScaleTabBarView(
                            controller: _tabBarController,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                width: mediaWidth,
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(color: kGreyColor),
                                      itemCount:
                                          snapshot.data!['pending'].length,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          Container(
                                        child: ListTile(
                                          onTap: () => _viewPendingPackage(
                                              snapshot.data!['pending'][index]),
                                          contentPadding: EdgeInsets.all(0),
                                          enableFeedback: true,
                                          dense: true,
                                          leading: FaIcon(
                                            FontAwesomeIcons.boxesStacked,
                                            color: kAccentColor,
                                          ),
                                          title: Text(
                                            snapshot.data!['pending'][index]
                                                .itemName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: kTextBlackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          subtitle: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(text: "Price:"),
                                                TextSpan(text: " "),
                                                TextSpan(
                                                  text:
                                                      "₦${formattedText(4000)}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
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
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: mediaWidth,
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(color: kGreyColor),
                                      itemCount:
                                          snapshot.data!['pending'].length,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          Container(
                                        child: ListTile(
                                          onTap: () => _viewDeliveredPackage(
                                              (snapshot.data!['completed']
                                                  [index])),
                                          contentPadding: EdgeInsets.all(0),
                                          enableFeedback: true,
                                          dense: true,
                                          leading: FaIcon(
                                            FontAwesomeIcons.boxesStacked,
                                            color: kAccentColor,
                                          ),
                                          title: Text(
                                            snapshot.data!['completed'][index]
                                                .itemName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: kTextBlackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          subtitle: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(text: "Price:"),
                                                TextSpan(text: " "),
                                                TextSpan(
                                                  text:
                                                      "₦${formattedText(4000)}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'sen',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          trailing: FaIcon(
                                            FontAwesomeIcons.solidCircleCheck,
                                            color: kSuccessColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: SpinKitChasingDots(
                      color: kAccentColor,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
