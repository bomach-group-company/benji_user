// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/providers/constants.dart';
import '../../src/repo/models/vendor/vendor.dart';
import '../../theme/colors.dart';
import 'all_vendor_products.dart';

class VendorLocation extends StatefulWidget {
  final VendorModel vendor;
  const VendorLocation({
    Key? key,
    required this.vendor,
  }) : super(key: key);

  @override
  State<VendorLocation> createState() => _VendorLocationState();
}

class _VendorLocationState extends State<VendorLocation> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();
    // _getPolyPoints();
    _loadMapData();
  }

  //============================================================= ALL VARIABLES ======================================================================\\

  //====================================== Setting Google Map Consts =========================================\\

  Position? _userPosition;

  static const LatLng _vendorLocation =
      LatLng(6.463810164127019, 7.539888438605598);
  List<LatLng> _polylineCoordinates = [];
  // List<LatLng> _latLng = <LatLng>[_userLocation, _vendorLocation];
  Uint8List? _markerImage;
  List<Marker> _markers = <Marker>[];
  List<MarkerId> _markerId = <MarkerId>[MarkerId("0"), MarkerId("1")];
  List<String> _markerTitle = <String>["Me", "Ntachi Osa"];
  List<String> _markerSnippet = <String>["My Location", "4.7 Star Rating"];
  List<String> _customMarkers = <String>[
    "assets/icons/person_location.png",
    "assets/icons/store.png",
  ];
  //============================================================= BOOL VALUES ======================================================================\\
  bool _isExpanded = false;

  //========================================================== GlobalKeys ============================================================\\

  //=================================== CONTROLLERS ======================================================\\
  Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? _newGoogleMapController;

  //============================================================== FUNCTIONS ===================================================================\\

  //======================================= Google Maps ================================================\\

  /// When the location services are not enabled or permissions are denied the `Future` will return an error.
  Future<void> _loadMapData() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    // Test if location services are enabled.
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    await _getUserCurrentLocation();
    await _loadCustomMarkers();
    // await _getPolyPoints();
  }

//============================================== Get Current Location ==================================================\\

  Future<Position> _getUserCurrentLocation() async {
    Position _userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (location) => _userPosition = location,
    );

    LatLng _latLngPosition =
        LatLng(_userLocation.latitude, _userLocation.longitude);

    CameraPosition _cameraPosition =
        new CameraPosition(target: _latLngPosition, zoom: 12.68);

    _newGoogleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(_cameraPosition),
    );

    return _userLocation;
  }

  //====================================== Get bytes from assets =========================================\\

  Future<Uint8List> _getBytesFromAssets(String path, int width) async {
    ByteData _data = await rootBundle.load(path);
    ui.Codec _codec = await ui.instantiateImageCodec(
      _data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo _fi = await _codec.getNextFrame();
    return (await _fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //====================================== Get Location Markers =========================================\\

  _loadCustomMarkers() async {
    Position _userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (location) => _userPosition = location,
    );
    List<LatLng> _latLng = <LatLng>[
      LatLng(_userLocation.latitude, _userLocation.longitude),
      _vendorLocation
    ];
    for (int i = 0; i < _customMarkers.length; i++) {
      final Uint8List _markerIcon =
          await _getBytesFromAssets(_customMarkers[i], 100);

      _markers.add(
        Marker(
          markerId: _markerId[i],
          icon: BitmapDescriptor.fromBytes(_markerIcon),
          position: _latLng[i],
          infoWindow: InfoWindow(
            title: "${_markerTitle[i]}",
            snippet: "${_markerSnippet[i]}",
          ),
        ),
      );
      setState(() {});
    }
  }

  //============================================== Adding polypoints ==================================================\\
  // _getPolyPoints() async {
  //   Position _userLocation = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   ).then(
  //     (location) => _userPosition = location,
  //   );
  //   PolylinePoints _polyLinePoints = PolylinePoints();
  //   PolylineResult _result = await _polyLinePoints.getRouteBetweenCoordinates(
  //     googleMapsApiKey,
  //     PointLatLng(_userLocation.latitude, _userLocation.longitude),
  //     PointLatLng(_vendorLocation.latitude, _vendorLocation.longitude),
  //   );

  //   if (_result.points.isNotEmpty) {
  //     _result.points.forEach(
  //       (PointLatLng point) =>
  //           _polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
  //     );
  //     setState(() {});
  //   }
  // }

//============================================== Create Google Maps ==================================================\\

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    _newGoogleMapController = controller;
  }

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
        title: "Vendor's location",
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        actions: [],
        toolbarHeight: kToolbarHeight,
      ),
      body: Stack(
        children: [
          _userPosition == null
              ? Center(child: SpinKitChasingDots(color: kAccentColor))
              : GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _userPosition!.latitude, _userPosition!.longitude),
                    zoom: 12.68,
                  ),
                  markers: Set.of(_markers),
                  padding: EdgeInsets.only(
                    bottom: _isExpanded ? mediaHeight * 0.32 : 90,
                  ),
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                  tiltGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  fortyFiveDegreeImageryEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
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
                      widget.vendor.shopName ?? 'Not Available',
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
                              '${(widget.vendor.averageRating ?? 0).toPrecision(1)}',
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
                              widget.vendor.isOnline ?? false
                                  ? "Online"
                                  : 'Offline',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: widget.vendor.isOnline ?? false
                                    ? kSuccessColor
                                    : kAccentColor,
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
