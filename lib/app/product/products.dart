import 'package:benji_user/src/providers/my_liquid_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/product/hot_deals_card.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/product/product.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';

class HotDealsPage extends StatefulWidget {
  const HotDealsPage({super.key});

  @override
  State<HotDealsPage> createState() => _HotDealsPageState();
}

class _HotDealsPageState extends State<HotDealsPage> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map? _data;

  _getData() async {
    await checkAuth(context);
    List<Product> product = await getProducts();
    setState(() {
      _data = {
        'product': product,
      };
    });
  }
  //==================================================== ALL VARIABLES ===========================================================\\

  //==================================================== BOOL VALUES ===========================================================\\

  //==================================================== CONTROLLERS ======================================================\\
  final _scrollController = ScrollController();

  //==================================================== FUNCTIONS ===========================================================\\
  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _data = null;
    });
    await _getData();
  }
  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "Products",
          toolbarHeight: 80,
          backgroundColor: kPrimaryColor,
          actions: [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _data == null
              ? SpinKitChasingDots(color: kAccentColor)
              : Scrollbar(
                  controller: _scrollController,
                  radius: Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: _data!['product'].length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(kDefaultPadding),
                    separatorBuilder: (context, index) => kHalfSizedBox,
                    itemBuilder: (BuildContext context, int index) =>
                        HotDealsCard(
                            vendorShopName:
                                _data!['product'][index].vendorId.shopName ??
                                    'Not Available',
                            name: _data!['product'][index].name,
                            price: _data!['product'][index].price),
                  ),
                ),
        ),
      ),
    );
  }
}
