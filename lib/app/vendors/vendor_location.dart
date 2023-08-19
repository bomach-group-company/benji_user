// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../src/providers/constants.dart';
import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../theme/colors.dart';

class VendorLocation extends StatefulWidget {
  const VendorLocation({super.key});

  @override
  State<VendorLocation> createState() => _VendorLocationState();
}

class _VendorLocationState extends State<VendorLocation> {
  //====================== ALL VARIABLES =====================================\\

  //===================== GlobalKeys =======================\\

  //===================== CONTROLLERS =======================\\
  GoogleMapController? _googleMapController;
  // final _googleMapController = Completer<GoogleMapController>();

  //===================== GOOGLE MAP =======================\\

  final LatLng _latLng = const LatLng(
    6.456076934514027,
    7.507987759047121,
  );

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "Locate Vendor",
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        actions: [],
        toolbarHeight: kToolbarHeight,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            buildingsEnabled: true,
            compassEnabled: false,
            indoorViewEnabled: true,
            mapToolbarEnabled: true,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            tiltGesturesEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            trafficEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _latLng,
              zoom: 20.0,
              tilt: 16,
            ),
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.538,
            left: 0,
            right: 0,
            child: Container(
              width: 200,
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.1,
                    ),
                    blurRadius: 5,
                    spreadRadius: 2,
                    blurStyle: BlurStyle.normal,
                  ),
                ],
                color: Color(
                  0xFFFEF8F8,
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    color: Color(
                      0xFFFDEDED,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding * 2.6,
                ),
                child: Column(
                  children: [
                    Text(
                      "Ntachi Osa",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(
                          0xFF302F3C,
                        ),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: kAccentColor,
                          size: 15,
                        ),
                        kHalfWidthSizedBox,
                        Text(
                          "23 Liza street, GRA",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(context);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: mediaWidth / 4,
                        padding: EdgeInsets.all(kDefaultPadding / 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: kAccentColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "Show products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 102,
                          height: 56.67,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                19,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                color: kAccentColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "30 mins",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.28,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 102,
                          height: 56.67,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                19,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: HexColor(
                                  "#FF6838",
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "4.8",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.28,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 102,
                          height: 56.67,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                19,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Open',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(
                                    0xFF189D60,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.36,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.info_outline,
                                color: kAccentColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.47,
            left: MediaQuery.of(context).size.width / 2.7,
            child: Container(
              width: 107,
              height: 107,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/vendors/ntachi-osa-logo.png",
                  ),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    43.50,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
