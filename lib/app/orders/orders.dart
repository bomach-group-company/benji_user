import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:flutter/material.dart';

import '../../modules/track order details container.dart';
import '../../reusable widgets/search field.dart';
import '../../theme/colors.dart';
import '../../theme/constants.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  //=================================== ALL VARIABLES ====================================\\

  //=================================== CONTROLLERS ====================================\\
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "My Orders ",
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: Column(
              children: [
                SearchField(
                  hintText: "Search your orders",
                  searchController: searchController,
                ),
                kSizedBox,
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: Text(
                          'May 2021',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      kSizedBox,
                      TrackOrderDetailsContainer(
                        shipIconDetail: Icons.cancel_rounded,
                        shipIconDetailColor: kAccentColor,
                        shipDetailText: "Unshipped",
                        shipDetailTextColor: kAccentColor,
                      ),
                      kHalfSizedBox,
                      TrackOrderDetailsContainer(
                        shipIconDetail: Icons.check_circle_rounded,
                        shipIconDetailColor: kSuccessColor,
                        shipDetailText: "Delivered",
                        shipDetailTextColor: kSuccessColor,
                      ),
                      kSizedBox,
                      Container(
                        child: Text(
                          'April 2021',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      kSizedBox,
                      TrackOrderDetailsContainer(
                        shipIconDetail: Icons.local_shipping_rounded,
                        shipIconDetailColor: kSecondaryColor,
                        shipDetailText: "Shipped",
                        shipDetailTextColor: kSecondaryColor,
                      ),
                      kHalfSizedBox,
                      TrackOrderDetailsContainer(
                        shipIconDetail: Icons.error_rounded,
                        shipIconDetailColor: KLoadingColor,
                        shipDetailText: "Closed",
                        shipDetailTextColor: KLoadingColor,
                      ),
                      kHalfSizedBox,
                      TrackOrderDetailsContainer(
                        shipIconDetail: Icons.check_circle_rounded,
                        shipIconDetailColor: kSuccessColor,
                        shipDetailText: "Delivered",
                        shipDetailTextColor: kSuccessColor,
                      ),
                      kSizedBox,
                      Container(
                        child: Text(
                          'April 2021',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      kSizedBox,
                      TrackOrderDetailsContainer(
                        shipIconDetail: Icons.error_rounded,
                        shipIconDetailColor: KLoadingColor,
                        shipDetailText: "Closed",
                        shipDetailTextColor: KLoadingColor,
                      ),
                      SizedBox(
                        height: kDefaultPadding * 3,
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'View More',
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding * 3,
                      ),
                    ],
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
