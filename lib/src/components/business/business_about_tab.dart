// ignore_for_file: unused_local_variable

import 'package:benji/app/business/about_business.dart';
import 'package:benji/src/repo/models/vendor/vendor.dart';
import 'package:flutter/material.dart';

class BusinessAboutTab extends StatefulWidget {
  final BusinessModel vendor;

  const BusinessAboutTab({
    super.key,
    required this.vendor,
  });

  @override
  State<BusinessAboutTab> createState() => _BusinessAboutTabState();
}

class _BusinessAboutTabState extends State<BusinessAboutTab> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AboutBusiness(
        vendor: widget.vendor,
      ),
    );
  }
}
