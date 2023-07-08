import 'package:flutter/material.dart';

class AppBarDeliveryLocation extends StatelessWidget {
  final String deliveryLocation;
  const AppBarDeliveryLocation({
    super.key,
    required this.deliveryLocation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver to',
            style: TextStyle(
              color: Color(
                0xFFEC2623,
              ),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              Container(
                width: 130,
                child: Text(
                  deliveryLocation,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Color(
                      0xFF676767,
                    ),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Color(
                  0xFF828282,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
