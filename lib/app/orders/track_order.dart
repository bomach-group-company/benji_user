import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../call/call_screen.dart';
import '../delivery/delivery_map.dart';
import '../home/home.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  //=============================== ALL VARIABLES ======================================\\

  //=============================== FUNCTIONS ======================================\\
  void _toHomeScreen() => Get.offAll(
        () => const Home(),
        routeName: 'Home',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: false,
        predicate: (routes) => false,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0,
        title: "Track Order",
        toolbarHeight: 80,
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: _toHomeScreen,
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 18,
              semanticLabel: "Home",
              color: kAccentColor,
            ),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
          Container(
            width: 415,
            height: 103,
            padding: EdgeInsets.all(
              kDefaultPadding / 2,
            ),
            decoration: ShapeDecoration(
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 24,
                  offset: Offset(0, 4),
                  spreadRadius: 7,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Received',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Dispatched',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Delivered',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Completed',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding / 2,
                    right: kDefaultPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: kAccentColor,
                          shape: OvalBorder(),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 2,
                              bottom: 2,
                              left: 2,
                              child: Container(
                                child: Icon(
                                  Icons.check_rounded,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 4,
                          color: kAccentColor,
                        ),
                      ),
                      Container(
                        width: 26,
                        height: 26,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 4,
                              top: 4,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: ShapeDecoration(
                                  color: kAccentColor,
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                      width: 0.50,
                                      color: kAccentColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 1,
                          color: Color(
                            0xFFC4C4C4,
                          ),
                        ),
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(
                              width: 0.50,
                              color: Color(
                                0xFFC4C4C4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 1,
                          color: Color(
                            0xFFC4C4C4,
                          ),
                        ),
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(
                              width: 0.50,
                              color: Color(
                                0xFFC4C4C4,
                              ),
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
          kSizedBox,
          Container(
            width: 339,
            height: 103,
            decoration: ShapeDecoration(
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(
                    0x0F000000,
                  ),
                  blurRadius: 24,
                  offset: Offset(
                    0,
                    4,
                  ),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(
                kDefaultPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 167,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        color: Color(
                          0xFF4F4F4F,
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 264,
                    child: Row(
                      children: [
                        Text(
                          'Order received by vendor',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kWidthSizedBox,
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: kAccentColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          kSizedBox,
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(
                    0x0F000000,
                  ),
                  blurRadius: 24,
                  offset: Offset(
                    0,
                    4,
                  ),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(
                kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: TextStyle(
                      color: kTextBlackColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kSizedBox,
                  Container(
                    width: 342,
                    height: 85,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 342,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  6,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 111,
                          top: 18,
                          child: Container(
                            width: 200,
                            height: 62,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: SizedBox(
                                    width: 120,
                                    height: 29,
                                    child: Text(
                                      "Chizzy\'s Food",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(
                                          0xFF222222,
                                        ),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 33,
                                  child: SizedBox(
                                    width: 64,
                                    height: 29,
                                    child: Text(
                                      '3 Items',
                                      style: TextStyle(
                                        color: Color(
                                          0xFF444343,
                                        ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  top: 33,
                                  child: Text(
                                    'Waiting',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF808080,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: -6,
                          child: Container(
                            width: 80,
                            height: 96,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/products/chizzy's-food.png",
                                ),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHalfSizedBox,
                  Divider(
                    color: Color(
                      0xFFC4C4C4,
                    ),
                    thickness: 1.0,
                  ),
                  kHalfSizedBox,
                  Text(
                    'Delivery Officer',
                    style: TextStyle(
                      color: kTextBlackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kHalfSizedBox,
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    onTap: null,
                    leading: Container(
                      width: 48,
                      height: 49,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/rider/martins-okafor.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            6,
                          ),
                        ),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Martins Okafor',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kHalfSizedBox,
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: Color(
                                0xFF575757,
                              ),
                            ),
                            Text(
                              '3.2km away',
                              style: TextStyle(
                                color: Color(
                                  0xFF575757,
                                ),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    trailing: Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: kAccentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        shadows: [
                          BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 0.7,
                            color: kBlackColor.withOpacity(0.4),
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CallPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.phone_rounded,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  kSizedBox,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DeliveryMap(),
                        ),
                      );
                    },
                    child: Container(
                      width: 324,
                      height: 49,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            color: Color(
                              0xFFDADADA,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(
                            6,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Color(
                              0xFF575757,
                            ),
                          ),
                          kHalfWidthSizedBox,
                          SizedBox(
                            width: 90,
                            child: Text(
                              'View on map',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: kDefaultPadding * 2,
          ),
        ],
      ),
    );
  }
}
