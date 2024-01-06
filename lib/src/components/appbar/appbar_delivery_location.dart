import 'package:benji/src/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/colors.dart';
import '../../providers/responsive_constant.dart';

class AppBarLocation extends StatelessWidget {
  final String defaultAddress;
  final Function() onPressed;
  const AppBarLocation({
    super.key,
    required this.defaultAddress,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: onPressed,
            child: Container(
              constraints: BoxConstraints(maxWidth: media.width - 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Shopping Area',
                      style: TextStyle(
                        color: kAccentColor,
                        fontSize: deviceType(media.width) > 2 ? 16 : 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      defaultAddress.contains("Not")
                          ? "Add an address"
                          : defaultAddress,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: deviceType(media.width) > 2 ? 16 : 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          kHalfWidthSizedBox,
          FaIcon(
            FontAwesomeIcons.caretDown,
            size: deviceType(media.width) > 2 ? 26 : 16,
            color: kAccentColor,
          ),
        ],
      ),
    );
  }
}
