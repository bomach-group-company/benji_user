import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/button/my_elevatedbutton.dart';
import '../../src/common_widgets/button/my_outlined_elevatedbutton.dart';
import '../../src/common_widgets/snackbar/my_floating_snackbar.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import 'add_new_address.dart';

class DeliverTo extends StatefulWidget {
  const DeliverTo({super.key});

  @override
  State<DeliverTo> createState() => _DeliverToState();
}

class _DeliverToState extends State<DeliverTo> {
  //=================================== ALL VARIABLES =====================================\\

  //=========================== BOOL VALUES ====================================\\
  bool isLoading = false;

  //===================== RADIO LIST TILE =======================\\

  List<String> radioListTitles = [
    "Home",
    "School",
    "My Apartment",
    "My Office",
    "My Parent's House",
  ];
  List<String> radioListSubtitles = [
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
    "No 2 Chime Avenue New Haven Enugu.",
  ];

  String? currentOption;

  List<String> radioListTileDefaultTitle = [
    "Default",
    "",
    "",
    "",
    "",
  ];

  List<Color> radioListTileDefaultColor = [
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

  //===================== STATES =======================\\

  @override
  void initState() {
    super.initState();
    currentOption = radioListTitles[0];
  }

  //===================== FUNCTIONS =======================\\

  Future<void> applyDeliveryAddress() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay
    await Future.delayed(Duration(seconds: 1));

    //Display snackBar
    mySnackBar(
      context,
      "Succcess!",
      "Delivery address updated",
      Duration(
        seconds: 2,
      ),
    );

    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      // Navigate to the new page
      Navigator.of(context).pop(context);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Deliver to ",
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
                for (int i = 0; i < radioListTitles.length; i++)
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: kDefaultPadding / 2,
                    ),
                    child: RadioListTile(
                      value: radioListTitles[i],
                      groupValue: currentOption,
                      activeColor: kAccentColor,
                      enableFeedback: true,
                      controlAffinity: ListTileControlAffinity.trailing,
                      fillColor: MaterialStatePropertyAll(
                        kAccentColor,
                      ),
                      onChanged: ((value) {
                        setState(
                          () {
                            currentOption = value.toString();
                          },
                        );
                      }),
                      title: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              radioListTitles[i],
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
                                color: radioListTileDefaultColor[i],
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
                                    radioListTileDefaultTitle[i],
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
                            radioListSubtitles[1],
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
                  height: kDefaultPadding * 2,
                ),
              ],
            ),
            MyOutlinedElevatedButton(
              title: "Add New Address",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewAddress(),
                  ),
                );
              },
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            isLoading
                ? Center(
                    child: SpinKitChasingDots(
                      color: kAccentColor,
                      duration: const Duration(seconds: 1),
                    ),
                  )
                : MyElevatedButton(
                    title: "Apply",
                    onPressed: () {
                      applyDeliveryAddress();
                    },
                  ),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
          ],
        ),
      ),
    );
  }
}
