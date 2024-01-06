import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';

class SetShoppingLocation extends StatefulWidget {
  const SetShoppingLocation({super.key});

  @override
  State<SetShoppingLocation> createState() => _SetShoppingLocationState();
}

class _SetShoppingLocationState extends State<SetShoppingLocation> {
  /// Variables to store country state city data in onChanged method.
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  void setShoppingLocation(){}

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "Set your shopping location",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: MyElevatedButton(
          title: "Save",
          onPressed: setShoppingLocation,
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: deviceType(media.width) > 2
              ? const EdgeInsets.all(kDefaultPadding)
              : const EdgeInsets.all(kDefaultPadding / 2),
          children: [
            Center(
              child: Column(
                children: [
                  Lottie.asset("assets/animations/shopping/frame_1.json"),
                  kSizedBox,
                  Text(
                    "Vendors and Products are displayed based on your shopping location",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            kSizedBox,
            CSCPicker(
              layout: Layout.vertical,
              defaultCountry: CscCountry.Nigeria,
              currentCountry: "Nigeria",
              currentState: "Enugu",
              countryDropdownLabel: "Select a Country",
              stateDropdownLabel: "Select a State",
              cityDropdownLabel: "Select a City",
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value!;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value!;
                });
              },
            ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
