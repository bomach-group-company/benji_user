import 'package:benji/src/providers/my_liquid_refresh.dart';
import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/section/track_order_details_container.dart';
import '../../src/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({super.key});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  //=================================== INITIAL STATE ====================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    _scrollController.addListener(_scrollListener);

    _orders = _getOrders();
  }

  //=================================== ALL VARIABLES ====================================\\

  late Future<List<Order>> _orders;

  //============================================== BOOL VALUES =================================================\\
  bool _isScrollToTopBtnVisible = false;

  //=================================== CONTROLLERS ====================================\\
  TextEditingController searchController = TextEditingController();
  final _scrollController = ScrollController();

  //=================================== FUNCTIONS ====================================\\
  Future<List<Order>> _getOrders() async {
    User? user = await getUser();
    List<Order> order = await getOrders(user!.id);

    return order;
  }

  //===================== Scroll to Top ==========================\\
  Future<void> _scrollToTop() async {
    await _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _isScrollToTopBtnVisible = false;
    });
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels >= 200 &&
        _isScrollToTopBtnVisible != true) {
      setState(() {
        _isScrollToTopBtnVisible = true;
      });
    }
    if (_scrollController.position.pixels < 200 &&
        _isScrollToTopBtnVisible == true) {
      setState(() {
        _isScrollToTopBtnVisible = false;
      });
    }
  }

  //===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _orders = _getOrders();
    });
  }
  //========================================================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyLiquidRefresh(
      handleRefresh: _handleRefresh,
      child: GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: MyAppBar(
            elevation: 0.0,
            title: "My Orders ",
            backgroundColor: kPrimaryColor,
            actions: const [],
          ),
          floatingActionButton: _isScrollToTopBtnVisible
              ? FloatingActionButton(
                  onPressed: _scrollToTop,
                  mini: deviceType(media.width) > 2 ? false : true,
                  backgroundColor: kAccentColor,
                  enableFeedback: true,
                  mouseCursor: SystemMouseCursors.click,
                  tooltip: "Scroll to top",
                  hoverColor: kAccentColor,
                  hoverElevation: 50.0,
                  child: const FaIcon(FontAwesomeIcons.chevronUp, size: 18),
                )
              : const SizedBox(),
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              children: [
                FutureBuilder(
                    future: _orders,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: media.height - 100,
                          width: media.width,
                          child: Center(
                            child:
                                CircularProgressIndicator(color: kAccentColor),
                          ),
                        );
                      }
                      return Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: snapshot.data!.isEmpty
                            ? const EmptyCard()
                            : Scrollbar(
                                controller: _scrollController,
                                child: ListView.separated(
                                  controller: _scrollController,
                                  itemCount: snapshot.data!.length,
                                  padding: const EdgeInsets.all(10),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      kHalfSizedBox,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) =>
                                      TrackOrderDetailsContainer(
                                    order: snapshot.data![index],
                                  ),
                                ),
                              ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
