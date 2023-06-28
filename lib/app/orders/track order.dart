import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:alpha_logistics/theme/colors.dart';
import 'package:alpha_logistics/theme/constants.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  //=============================== ALL VARIABLES ======================================\\
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Track Order ",
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: 415,
              height: 103,
              padding: EdgeInsets.all(
                kDefaultPadding / 2,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
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
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Dispatched',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Delivered',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.black,
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
                                    color: Color(
                                      0xFFEC2623,
                                    ),
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
                                        color: Color(
                                          0xFFEC2623,
                                        ),
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
                color: Colors.white,
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
                      child: Text(
                        'Order received by vendor',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kSizedBox,
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              decoration: ShapeDecoration(
                color: Colors.white,
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
                        color: Colors.black,
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
                              height: 85,
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
                              width: 231,
                              height: 62,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      width: 184,
                                      height: 29,
                                      child: Text(
                                        'Chizzy’s Food',
                                        style: TextStyle(
                                          color: Color(
                                            0xFF222222,
                                          ),
                                          fontSize: 18,
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
                                    left: 167,
                                    top: 33,
                                    child: SizedBox(
                                      width: 64,
                                      height: 29,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: -6,
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/food/chizzy's-food.png",
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
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHalfSizedBox,
                    Container(
                      width: 380,
                      height: 85,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 60,
                            top: 18,
                            child: Container(
                              width: 290,
                              height: 62,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      width: 184,
                                      height: 20,
                                      child: Text(
                                        'Martins Okafor',
                                        style: TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 24,
                                    child: SizedBox(
                                      width: 100,
                                      height: 29,
                                      child: Row(
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
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 215,
                                    top: 8,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        color: Color(
                                          0xFFEC2623,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.phone_rounded,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              left: 0,
                              top: 20,
                              child: Container(
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
                              )),
                        ],
                      ),
                    ),
                    kSizedBox,
                    GestureDetector(
                      onTap: () {},
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
      ),
    );
  }
}
