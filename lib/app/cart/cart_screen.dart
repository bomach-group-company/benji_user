import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
//==================================================== INITIAL STATE AND DISPOSE ==========================================================\\
  @override
  void initState() {
    super.initState();

    _loadingScreen = true;

    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }
  //============================================================ ALL VARIABLES ===================================================================\\

//====================================================== BOOL VALUES ========================================================\\
  late bool _loadingScreen;

//==================================================== FUNCTIONS ==========================================================\\

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _loadingScreen = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _loadingScreen = false;
    });
  }

  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "Cart",
          elevation: 0.0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        bottomNavigationBar: Container(),
      ),
    );
  }
}
