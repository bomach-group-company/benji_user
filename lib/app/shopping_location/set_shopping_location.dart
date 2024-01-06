import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/button/my_outlined_elevatedbutton.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      ).then((value) => ApiProcessorController.errorSnack(
          "Location permissions are permanently denied, we cannot request permissions."));
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      ApiProcessorController.successSnack("Location is enabled already");
    }
  }

  void setShoppingLocation() {
    if (countryValue == "" || countryValue.isEmpty) {
      ApiProcessorController.errorSnack("Please select a country");
    }
    if (stateValue == "" || stateValue.isEmpty) {
      ApiProcessorController.errorSnack("Please select a state");
    }
    if (!stateValue.contains("Enugu")) {
      ApiProcessorController.errorSnack(
        "Sorry, we are only available in Enugu",
      );
    }
    if (cityValue == "" || cityValue.isEmpty) {
      ApiProcessorController.errorSnack("Please select a city");
    }
  }

  void useCurrentLocation() async {
    checkLocationPermission();
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyElevatedButton(
              title: "Save",
              onPressed: setShoppingLocation,
            ),
            kSizedBox,
            MyOutlinedElevatedButton(
              title: "Use my location",
              onPressed: useCurrentLocation,
            ),
          ],
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
              countryFilter: const [CscCountry.Nigeria],
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
                  stateValue = value ?? "";
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value ?? "";
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
