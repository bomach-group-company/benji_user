// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class VendorsAboutTab extends StatefulWidget {
  final Widget list;
  const VendorsAboutTab({
    super.key,
    required this.list,
  });

  @override
  State<VendorsAboutTab> createState() => _VendorsAboutTabState();
}

class _VendorsAboutTabState extends State<VendorsAboutTab> {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: mediaWidth,
      child: widget.list,
    );
  }
}
