import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class AppBarDeliveryLocation extends StatelessWidget {
  final String deliveryLocation;
  final Function() toDeliverToPage;
  const AppBarDeliveryLocation({
    super.key,
    required this.deliveryLocation,
    required this.toDeliverToPage,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: toDeliverToPage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver to',
            style: TextStyle(
              color: kAccentColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              Container(
                width: media.width - 200,
                child: Text(
                  deliveryLocation,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: kTextGreyColor,
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
