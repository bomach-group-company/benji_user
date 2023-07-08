import 'package:alpha_logistics/app/address/add%20new%20address.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20elevatedbutton.dart';
import 'package:flutter/material.dart';

import '../../providers/constants.dart';
import '../../theme/colors.dart';
import 'address details.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  //===================================================\\

  //===================== RADIO LIST TILE =======================\\

  List<String> listTitleTitles = [
    "Home",
    "School",
    "My Apartment",
    "My Office",
    "My Parent's House",
  ];
  List<String> listTileSubtitles = [
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
  ];

  String? currentOption;

  @override
  void initState() {
    super.initState();
    currentOption = listTitleTitles[0];
  }

  List<String> listTileDefaultTitle = [
    "Default",
    "",
    "",
    "",
    "",
  ];

  List<Color> ListTileDefaultColor = [
    Color(
      0xFFFFCFCF,
    ),
    Color(
      0x00000000,
    ),
    Color(
      0x00000000,
    ),
    Color(
      0x00000000,
    ),
    Color(
      0x00000000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Addresses ",
        toolbarHeight: 80,
        backgroundColor: kPrimaryColor,
        actions: [],
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                for (int i = 0; i < listTitleTitles.length; i++)
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: kDefaultPadding / 2,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddressDetails(),
                          ),
                        );
                      },
                      enableFeedback: true,
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: kAccentColor,
                      ),
                      title: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              listTitleTitles[i],
                              style: TextStyle(
                                color: Color(
                                  0xFF151515,
                                ),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kWidthSizedBox,
                            Container(
                              width: 58,
                              height: 24,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: ShapeDecoration(
                                color: ListTileDefaultColor[i],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    listTileDefaultTitle[i],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: kAccentColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                          top: kDefaultPadding / 2,
                        ),
                        child: Container(
                          child: Text(
                            listTileSubtitles[1],
                            style: TextStyle(
                              color: Color(
                                0xFF4C4C4C,
                              ),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: kDefaultPadding * 5,
                ),
              ],
            ),
            MyElevatedButton(
              title: "Add New Address",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewAddress(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
