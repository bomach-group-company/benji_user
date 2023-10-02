import 'package:flutter/material.dart';

class EndToEndRow extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final int flex1;
  final int flex2;

  const EndToEndRow({
    super.key,
    required this.widget1,
    required this.widget2,
    this.flex1 = 2,
    this.flex2 = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: flex1,
          child: widget1,
        ),
        Expanded(
          flex: flex2,
          child: Container(
            alignment: Alignment.centerRight,
            child: widget2,
          ),
        ),
      ],
    );
  }
}
