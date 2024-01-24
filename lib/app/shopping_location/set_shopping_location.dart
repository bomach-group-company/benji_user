import 'package:benji/app/home/home.dart';
import 'package:benji/app/packages/item_category_dropdown_menu.dart';
import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/components/button/my_outlined_elevatedbutton.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/src/repo/controller/shopping_location_controller.dart';
import 'package:benji/src/repo/utils/shopping_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../src/components/button/my_elevatedbutton.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constant.dart';
import '../../theme/colors.dart';

class SetShoppingLocation extends StatefulWidget {
  const SetShoppingLocation({super.key, this.navTo});
  final Function()? navTo;

  @override
  State<SetShoppingLocation> createState() => _SetShoppingLocationState();
}

class _SetShoppingLocationState extends State<SetShoppingLocation> {
  /// Variables to store country state city data in onChanged method.
  TextEditingController countryEC = TextEditingController();
  TextEditingController stateEC = TextEditingController();
  TextEditingController cityEC = TextEditingController();

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

  Future setShoppingLocationForm() async {
    if (countryEC.text.isEmpty) {
      ApiProcessorController.errorSnack("Please select a country");
    }
    if (stateEC.text.isEmpty) {
      ApiProcessorController.errorSnack("Please select a state");
    }
    if (cityEC.text.isEmpty) {
      ApiProcessorController.errorSnack(
        "Please select a city",
      );
    }
    await setShoppingLocation(countryEC.text, stateEC.text, cityEC.text);
    if (widget.navTo == null) {
      Get.off(
        () => const Home(),
        routeName: 'Home',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
    } else {
      widget.navTo!();
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
              onPressed: setShoppingLocationForm,
            ),
            // kSizedBox,
            // MyOutlinedElevatedButton(
            //   title: "Use my location",
            //   onPressed: useCurrentLocation,
            // ),
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
            const Text(
              "Select Country",
              style: TextStyle(
                fontSize: 17.6,
                fontWeight: FontWeight.w400,
              ),
            ),
            kHalfSizedBox,
            GetBuilder<ShoppingLocationController>(
              initState: (state) => ShoppingLocationController.instance
                  .getShoppingLocationCountries(),
              builder: (controller) => ItemDropDownMenu(
                onSelected: (value) {
                  controller.getShoppingLocationState(value);
                  countryEC.text = value!.toString();
                  setState(() {});
                },
                itemEC: countryEC,
                mediaWidth: media.width - 20,
                hintText: "Choose country",
                dropdownMenuEntries2:
                    controller.isLoadCountry.value && controller.country.isEmpty
                        ? [
                            const DropdownMenuEntry(
                                value: 'Loading...',
                                label: 'Loading...',
                                enabled: false),
                          ]
                        : controller.country.isEmpty
                            ? [
                                const DropdownMenuEntry(
                                    value: 'EMPTY',
                                    label: 'EMPTY',
                                    enabled: false),
                              ]
                            : controller.country
                                .map(
                                  (item) => DropdownMenuEntry(
                                    value: item.countryCode,
                                    label: item.countryName,
                                  ),
                                )
                                .toList(),
              ),
            ),
            kSizedBox,
            const Text(
              "Select state",
              style: TextStyle(
                fontSize: 17.6,
                fontWeight: FontWeight.w400,
              ),
            ),
            kHalfSizedBox,
            GetBuilder<ShoppingLocationController>(
              builder: (controller) => ItemDropDownMenu(
                onSelected: (value) {
                  stateEC.text = value!.toString();
                  controller.getShoppingLocationCity(value);
                  setState(() {});
                },
                itemEC: stateEC,
                mediaWidth: media.width - 20,
                hintText: "Choose state",
                dropdownMenuEntries2: countryEC.text.isEmpty
                    ? [
                        const DropdownMenuEntry(
                            value: 'Select Country',
                            label: 'Select Country',
                            enabled: false),
                      ]
                    : controller.isLoadState.value && controller.state.isEmpty
                        ? [
                            const DropdownMenuEntry(
                                value: 'Loading...',
                                label: 'Loading...',
                                enabled: false),
                          ]
                        : controller.state.isEmpty
                            ? [
                                const DropdownMenuEntry(
                                    value: 'EMPTY',
                                    label: 'EMPTY',
                                    enabled: false),
                              ]
                            : controller.state
                                .map(
                                  (item) => DropdownMenuEntry(
                                    value: item.stateCode,
                                    label: item.stateName,
                                  ),
                                )
                                .toList(),
              ),
            ),
            kSizedBox,

            const Text(
              "Select city",
              style: TextStyle(
                fontSize: 17.6,
                fontWeight: FontWeight.w400,
              ),
            ),
            kHalfSizedBox,
            GetBuilder<ShoppingLocationController>(
              builder: (controller) => ItemDropDownMenu(
                onSelected: (value) {
                  cityEC.text = value!.toString();
                  setState(() {});
                },
                itemEC: cityEC,
                mediaWidth: media.width - 20,
                hintText: "Choose city",
                dropdownMenuEntries2: stateEC.text.isEmpty
                    ? [
                        const DropdownMenuEntry(
                            value: 'Select State',
                            label: 'Select State',
                            enabled: false),
                      ]
                    : controller.isLoadCity.value && controller.city.isEmpty
                        ? [
                            const DropdownMenuEntry(
                                value: 'Loading...',
                                label: 'Loading...',
                                enabled: false),
                          ]
                        : controller.city.isEmpty
                            ? [
                                const DropdownMenuEntry(
                                    value: 'EMPTY',
                                    label: 'EMPTY',
                                    enabled: false),
                              ]
                            : controller.city
                                .map(
                                  (item) => DropdownMenuEntry(
                                    value: item.cityCode,
                                    label: item.cityName,
                                  ),
                                )
                                .toList(),
              ),
            ),

            // CSCPicker(
            //   layout: Layout.vertical,
            //   countryFilter: const [CscCountry.Nigeria],
            //   countryDropdownLabel: "Select a Country",
            //   stateDropdownLabel: "Select a State",
            //   cityDropdownLabel: "Select a City",
            //   onCountryChanged: (value) {
            //     setState(() {
            //       countryValue = value;
            //     });
            //   },
            //   onStateChanged: (value) {
            //     setState(() {
            //       stateValue = value ?? "";
            //     });
            //   },
            //   onCityChanged: (value) {
            //     setState(() {
            //       cityValue = value ?? "";
            //     });
            //   },
            // ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
