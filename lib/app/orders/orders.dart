import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:flutter/material.dart';

import '../../reusable widgets/search field.dart';

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
    return Scaffold(
      appBar: MyAppBar(
        title: "My Orders ",
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SearchField(
                hintText: "Search your orders",
                searchController: searchController,
              ),
              ListView(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
