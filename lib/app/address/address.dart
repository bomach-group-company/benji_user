import 'package:benji_user/src/others/my_future_builder.dart';
import 'package:flutter/material.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/user/address_model.dart';
import '../../theme/colors.dart';
import 'add_new_address.dart';

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

  Future<Map> _getData() async {
    return {
      'current': (await getCurrentAddress()).id ?? '',
      'addresses': await getAddressesByUser(),
    };
  }

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
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
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
                  MyFutureBuilder(
                    future: _getData(),
                    child: (data) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data['addresses'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsetsDirectional.symmetric(
                              vertical: kDefaultPadding / 2,
                            ),
                            child: ListTile(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => AddressDetails(),
                                //   ),
                                // );
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
                                      data['addresses'][index].title ?? '',
                                      style: TextStyle(
                                        color: Color(
                                          0xFF151515,
                                        ),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    kWidthSizedBox,
                                    data['current'] ==
                                            data['addresses'][index].id
                                        ? Container(
                                            width: 58,
                                            height: 24,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: ShapeDecoration(
                                              color: kAccentColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  8,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'default',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                  top: kDefaultPadding / 2,
                                ),
                                child: Container(
                                  child: Text(
                                    data['addresses'][index].streetAddress ??
                                        '',
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
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding * 3,
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
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
