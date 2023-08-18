import 'package:flutter/material.dart';

import '../../app/address/deliver_to.dart';
import '../../theme/colors.dart';

class AppBarDeliveryLocation extends StatelessWidget {
  final String deliveryLocation;
  const AppBarDeliveryLocation({
    super.key,
    required this.deliveryLocation,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DeliverTo(),
          ),
        );
      },
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
                width: 150,
                child: Text(
                  deliveryLocation,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                Icons.chevron_right_rounded,
                color: kAccentColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
