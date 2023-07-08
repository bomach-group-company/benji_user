import 'package:alpha_logistics/app/coupon/apply%20coupon.dart';
import 'package:alpha_logistics/modules/my%20floating%20snackbar.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20elevatedbutton.dart';
import 'package:alpha_logistics/theme/colors.dart';
import 'package:alpha_logistics/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../reusable widgets/my appbar.dart';
import '../../reusable widgets/my outlined elevatedbutton.dart';
import '../../screens/payment successful screen.dart';
import '../address/deliver to.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  //====================== ALL VARIABLES =====================================\\

  //===================== GlobalKeys =======================\\
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //===================== CONTROLLERS =======================\\
  ScrollController scrollController = ScrollController();

  //===================== INCREMENT VARIABLES =======================\\
  int quantity = 1;
  int newQuantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
      ;
    });
  }

  void newIncrementQuantity() {
    setState(() {
      newQuantity++;
    });
  }

  void newDecrementQuantity() {
    setState(() {
      if (newQuantity > 1) {
        newQuantity--;
      }
      ;
    });
  }

  //===================== COPY TO CLIPBOARD =======================\\
  final String text = 'Generated Link code here';
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );

    //===================== SNACK BAR =======================\\

    mySnackBar(
      context,
      "Copied to clipboard",
      kAccentColor,
      SnackBarBehavior.floating,
      MediaQuery.of(context).size.height - 100,
    );
  }

  //===================== SHOWMODALBOTTOMSHEET =======================\\
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: "Cart",
        actions: [],
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: ListView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              child: Text(
                'Deliver to',
                style: TextStyle(
                  color: Color(
                    0xFF202020,
                  ),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            kSizedBox,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DeliverTo(),
                  ),
                );
              },
              child: Container(
                width: 382,
                height: 74,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'School',
                          style: TextStyle(
                            color: Color(
                              0xFF151515,
                            ),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'No 2 Chime Avenue New Haven Enugu.',
                          style: TextStyle(
                            color: Color(
                              0xFF4C4C4C,
                            ),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: kAccentColor,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            Container(
              width: 167,
              height: 21,
              child: Text(
                'Product Summary',
                style: TextStyle(
                  color: Color(
                    0xFF151515,
                  ),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            kSizedBox,
            Container(
              width: MediaQuery.of(context).size.width,
              height: 101,
              padding: EdgeInsets.all(
                8.0,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
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
                  )
                ],
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/icons/edit-icon.png",
                          ),
                        ),
                      ),
                    ),
                    kWidthSizedBox,
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smokey Jollof Rice',
                            style: TextStyle(
                              color: Color(
                                0xFF333333,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding * 1.5,
                          ),
                          Text(
                            '₦1,700.00',
                            style: TextStyle(
                              color: Color(
                                0xCC4C4C4C,
                              ),
                              fontSize: 16,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding * 1.2,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/icons/delete-icon.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    decrementQuantity();
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_rounded,
                                    color: kAccentColor,
                                  ),
                                ),
                                Text(
                                  '$quantity',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    incrementQuantity();
                                  },
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    color: kAccentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kHalfSizedBox,
            Container(
              width: 382,
              height: 154,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
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
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/icons/edit-icon.png",
                          ),
                        ),
                      ),
                    ),
                    kWidthSizedBox,
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smokey Jollof Rice',
                            style: TextStyle(
                              color: Color(
                                0xFF333333,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          kHalfSizedBox,
                          Text(
                            '2x  Stewed Fried Chicken',
                            style: TextStyle(
                              color: Color(
                                0xFF676565,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          kHalfSizedBox,
                          Text(
                            '2x Grilled 1/4 Chicken',
                            style: TextStyle(
                              color: Color(
                                0xFF676565,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding * 2,
                          ),
                          Text(
                            '₦1,700.00',
                            style: TextStyle(
                              color: Color(
                                0xCC4C4C4C,
                              ),
                              fontSize: 16,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/icons/delete-icon.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    newDecrementQuantity();
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_rounded,
                                    color: kAccentColor,
                                  ),
                                ),
                                Text(
                                  '$newQuantity',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    newIncrementQuantity();
                                  },
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    color: kAccentColor,
                                  ),
                                ),
                              ],
                            ),
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
              width: 382,
              height: 106,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                  kDefaultPadding / 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coupon',
                      style: TextStyle(
                        color: Color(
                          0xFF151515,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(
                              0xFFEAEAEA,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ApplyCoupon(),
                          ),
                        );
                      },
                      child: Container(
                        // color: kSecondaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Coupon',
                              style: TextStyle(
                                color: Color(
                                  0xFF151515,
                                ),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: 84,
                                    height: 24,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: kAccentColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ADB1897',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'x',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(
                                              0xFFE4E4F3,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: kAccentColor,
                                    size: 16,
                                  ),
                                ],
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
            kSizedBox,
            Container(
              width: 382,
              height: 322,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
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
                  kDefaultPadding / 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Payment Summary',
                            style: TextStyle(
                              color: Color(
                                0xFF151515,
                              ),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(
                                    0xFFEAEAEA,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF151515,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '₦1,700.00',
                                  style: TextStyle(
                                    color: Color(
                                      0xCC4C4C4C,
                                    ),
                                    fontSize: 16,
                                    fontFamily: 'Sen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Fee',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF151515,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '₦700.00',
                                  style: TextStyle(
                                    color: Color(
                                      0xCC4C4C4C,
                                    ),
                                    fontSize: 16,
                                    fontFamily: 'Sen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Service Fee',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF151515,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '₦0.00',
                                  style: TextStyle(
                                    color: Color(
                                      0xCC4C4C4C,
                                    ),
                                    fontSize: 16,
                                    fontFamily: 'Sen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Insurance Fee',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF151515,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '₦0.00',
                                  style: TextStyle(
                                    color: Color(
                                      0xCC4C4C4C,
                                    ),
                                    fontSize: 16,
                                    fontFamily: 'Sen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Discount',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF151515,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '₦0.00',
                                  style: TextStyle(
                                    color: Color(
                                      0xCC4C4C4C,
                                    ),
                                    fontSize: 16,
                                    fontFamily: 'Sen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(
                              0xFFEAEAEA,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Color(
                                0xFF151515,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '₦2,400.00',
                            style: TextStyle(
                              color: Color(
                                0xCC4C4C4C,
                              ),
                              fontSize: 16,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            Container(
              height: 160,
              padding: const EdgeInsets.only(
                bottom: kDefaultPadding,
              ),
              color: kPrimaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyElevatedButton(
                    title: "Place Order - ₦2,400.00",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentSuccessful(),
                        ),
                      );
                    },
                  ),
                  MyOutlinedElevatedButton(
                    title: "Pay For Me - ₦2,400.00",
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: kPrimaryColor,
                        elevation: 20,
                        barrierColor: kBlackColor.withOpacity(
                          0.2,
                        ),
                        showDragHandle: true,
                        useSafeArea: true,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                          minHeight: MediaQuery.of(context).size.height * 0.5,
                        ),
                        isScrollControlled: true,
                        isDismissible: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              kDefaultPadding,
                            ),
                          ),
                        ),
                        enableDrag: true,
                        builder: (context) => Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          // color: kAccentColor,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: [
                              Container(
                                height: 65,
                                padding: const EdgeInsets.all(
                                  8,
                                ),
                                child: Text(
                                  'Hey! share this link with your friends to have them pay for your order',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF333333,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              Container(
                                width: 379,
                                height: 64,
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  left: 17,
                                  right: 17,
                                  bottom: 18,
                                ),
                                decoration: ShapeDecoration(
                                  color: Color(
                                    0xFFFEF8F8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.50,
                                      color: Color(
                                        0xFFFDEDED,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      text,
                                      style: TextStyle(
                                        color: kBlackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: kDefaultPadding * 4,
                                      ),
                                      width: 2,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFFA39B9B,
                                        ),
                                      ),
                                    ),
                                    kHalfWidthSizedBox,
                                    IconButton(
                                      onPressed: () =>
                                          _copyToClipboard(context),
                                      icon: Icon(
                                        Icons.content_copy_rounded,
                                        color: kAccentColor,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kSizedBox,
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/icons/whatsapp-icon.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'WhatsApp',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(
                                                    0xFF3C3E56,
                                                  ),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/icons/facebook-icon.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Facebook',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(
                                                    0xFF3C3E56,
                                                  ),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/icons/messenger-icon.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Messenger',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(
                                                    0xFF3C3E56,
                                                  ),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/icons/messages-icon.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Message',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(
                                                    0xFF3C3E56,
                                                  ),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    kHalfSizedBox,
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/images/icons/instagram-icon.png",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Instagram',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(
                                                      0xFF3C3E56,
                                                    ),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/images/icons/twitter-icon.png",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Twitter',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(
                                                      0xFF3C3E56,
                                                    ),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/images/icons/telegram-icon.png",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Telegram',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(
                                                      0xFF3C3E56,
                                                    ),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPadding * 4,
                              ),
                              MyElevatedButton(
                                title: "Close",
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
