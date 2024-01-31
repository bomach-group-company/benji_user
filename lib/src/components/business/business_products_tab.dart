// ignore_for_file: unused_local_variable

import 'package:benji/app/business/business_products.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:flutter/material.dart';

class BusinessProductsTab extends StatefulWidget {
  final BusinessModel business;
  const BusinessProductsTab({super.key, required this.business});

  @override
  State<BusinessProductsTab> createState() => _BusinessProductsTabState();
}

class _BusinessProductsTabState extends State<BusinessProductsTab> {
  //===================== VARIABLES =======================\\

//============================================ FUNCTIONS ==============================================\\

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: mediaWidth,
      child: BusinessProducts(
        business: widget.business,
      ),
    );
  }
}
