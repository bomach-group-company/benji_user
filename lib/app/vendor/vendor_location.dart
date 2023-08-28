// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import 'all_vendor_products.dart';

class VendorLocation extends StatefulWidget {
  const VendorLocation({super.key});

  @override
  State<VendorLocation> createState() => _VendorLocationState();
}

class _VendorLocationState extends State<VendorLocation> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();
    _marker.addAll(_listOfMarkers);
  }

  //============================================================= ALL VARIABLES ======================================================================\\

  //============================================================= BOOL VALUES ======================================================================\\
  bool _isExpanded = false;

  //===================== GlobalKeys =======================\\

  //=================================== CONTROLLERS ======================================================\\
  Completer<GoogleMapController> _googleMapController = Completer();

  GoogleMapController? _newGoogleMapController;

  //============================================== FUNCTIONS =============================================================\\
  void _handleRefresh() {}

  //=========================== Google Maps ====================================\\

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
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
      );
    }

    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // _currentPosition = _position;

    _marker.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(_position.latitude, _position.latitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "My location", onTap: () {}),
      ),
    );

    LatLng _latLngPosition = LatLng(_position.latitude, _position.longitude);
    CameraPosition _cameraPosition =
        new CameraPosition(target: _latLngPosition, zoom: 14);
    _newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await _position;
  }

  List<Marker> _marker = [];
  List<Marker> _listOfMarkers = [
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(6.463987057779448, 7.539842027339904),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Ntachi Osa"),
    ),
  ];
  List<LatLng> _latLng = <LatLng>[];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.455888229466976, 7.507826262254407),
    zoom: 14,
  );

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    _newGoogleMapController = controller;
    _determinePosition();
  }

//=================================================================================\\

//====================================================================== FUNCTIONS =======================================================================\\

//========================================================== Navigation =============================================================\\
  void _viewProducts() => Get.off(
        () => AllVendorProducts(),
        routeName: 'AllVendorProducts',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "Vendors location",
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        actions: [],
        toolbarHeight: kToolbarHeight,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _determinePosition(),
            builder: (context, snapshot) {
              return GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                initialCameraPosition: _kGooglePlex,
                markers: Set.of(_marker),
                polylines: {},
                tileOverlays: {},
                padding: EdgeInsets.only(
                    bottom: _isExpanded ? mediaHeight * 0.56 : 90),
                buildingsEnabled: true,
                compassEnabled: true,
                indoorViewEnabled: true,
                mapToolbarEnabled: true,
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                tiltGesturesEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                cameraTargetBounds: CameraTargetBounds.unbounded,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                trafficEnabled: false,
              );
            },
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            left: 0,
            right: 0,
            bottom: _isExpanded ? 0 : -140,
            child: Container(
              width: 200,
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: kBlackColor.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                    blurStyle: BlurStyle.normal,
                  ),
                ],
                color: Color(0xFFFEF8F8),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    color: Color(0xFFFDEDED),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? "See less" : "See more",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mediaWidth - 200,
                    child: Text(
                      "Ntachi Osa",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.locationDot,
                        color: kAccentColor,
                        size: 15,
                      ),
                      kHalfWidthSizedBox,
                      SizedBox(
                        width: mediaWidth - 100,
                        child: Text(
                          "Old Abakaliki Rd, Thinkers Corner 400103, Enugu",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHalfSizedBox,
                  InkWell(
                    onTap: _viewProducts,
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
                        width: mediaWidth * 0.23,
                        height: 57,
                        decoration: ShapeDecoration(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: kStarColor,
                              size: 17,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "4.8",
                              style: const TextStyle(
                                color: kBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: mediaWidth * 0.25,
                        height: 57,
                        decoration: ShapeDecoration(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Online",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kSuccessColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.36,
                              ),
                            ),
                            const SizedBox(width: 5),
                            FaIcon(
                              Icons.info,
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
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            bottom: _isExpanded ? 180 : 40,
            left: mediaWidth / 2.7,
            child: Container(
              width: 100,
              height: 100,
              decoration: ShapeDecoration(
                color: kPageSkeletonColor,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/vendors/ntachi-osa-logo.png",
                  ),
                  fit: BoxFit.cover,
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
