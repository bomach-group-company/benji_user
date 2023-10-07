import 'package:benji/src/repo/models/order/order.dart';
import 'package:benji/src/repo/models/user/user_model.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/section/track_order_details_container.dart';
import '../../src/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({super.key});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  //=================================== ALL VARIABLES ====================================\\

  //=================================== CONTROLLERS ====================================\\
  TextEditingController searchController = TextEditingController();
  //=================================== Logic ====================================\\
  @override
  void initState() {
    super.initState();
    checkAuth(context);
    _orders = _getOrders();
  }

  late Future<List<Order>> _orders;

  Future<List<Order>> _getOrders() async {
    User? user = await getUser();
    List<Order> order = await getOrders(user!.id);
    if (kDebugMode) {
      print('the data $order');
    }
    return order;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "My Orders ",
          toolbarHeight: 80,
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            margin: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: Column(
              children: [
                FutureBuilder(
                    future: _orders,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(color: kAccentColor),
                        );
                      }
                      return Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: snapshot.data!.isEmpty
                            ? const EmptyCard()
                            : ListView.separated(
                                itemCount: snapshot.data!.length,
                                separatorBuilder: (context, index) =>
                                    kHalfSizedBox,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) =>
                                    TrackOrderDetailsContainer(
                                  order: snapshot.data![index],
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
