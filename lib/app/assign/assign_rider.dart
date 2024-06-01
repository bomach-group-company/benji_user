// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:benji/src/components/button/my_elevatedbutton.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/repo/utils/network_utils.dart';
import 'package:benji/src/repo/utils/points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/providers/keys.dart';
import '../../theme/colors.dart';

class AssignRiderMap extends StatefulWidget {
  final List<LatLng> latlngRiders;
  final String itemId;
  final String itemType;
  const AssignRiderMap({
    super.key,
    required this.itemId,
    required this.itemType,
    this.latlngRiders = const [
      LatLng(6.456527884386727, 7.507912087276524),
      LatLng(6.45651722359882, 7.508459257912696),
      LatLng(6.456080131101715, 7.51028316003324),
      LatLng(6.457700569685034, 7.5071610687563),
    ],
  });

  @override
  State<AssignRiderMap> createState() => _AssignRiderMapState();
}

class _AssignRiderMapState extends State<AssignRiderMap> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();

    _loadMapData();
  }

  //============================================================= ALL VARIABLES ======================================================================\\

  //====================================== Setting Google Map Consts =========================================\\

  final List<LatLng> _polylineCoordinates = [];
  final List<Marker> _markers = <Marker>[];

  bool loadingMap = true;
  int? selectedRider;
  final String _markerTitle = "Rider";
  final String _markerSnippet = "Rider location";

  final String _customMarkers = "assets/icons/delivery_bike.png";
  final String _selectedMarker = "assets/icons/package.png";
  //============================================================= BOOL VALUES ======================================================================\\

  //========================================================== GlobalKeys ============================================================\\

  //=================================== CONTROLLERS ======================================================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? _newGoogleMapController;

  //============================================================== FUNCTIONS ===================================================================\\

  //======================================= Google Maps ================================================\\

  /// When the location services are not enabled or permissions are denied the `Future` will return an error.
  Future<void> _loadMapData() async {
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
        Get.back();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    await _loadCustomMarkers();
    // getPolyPoints();
    setState(() {
      loadingMap = false;
    });
  }

//============================================== Get Current Location ==================================================\\

  //====================================== Get bytes from assets =========================================\\

  Future<Uint8List> _getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //====================================== Get Location Markers =========================================\\

  _loadCustomMarkers() async {
    List<LatLng> latLng = widget.latlngRiders;
    for (int i = 0; i < latLng.length; i++) {
      Uint8List markerIcon = await _getBytesFromAssets(_customMarkers, 100);
      Uint8List markerIcon2 = await _getBytesFromAssets(_selectedMarker, 100);

      _markers.add(
        Marker(
          onTap: () {
            setState(() {
              selectedRider = i;
            });
          },
          markerId: MarkerId("Rider$i"),
          icon: BitmapDescriptor.fromBytes(
              selectedRider == i ? markerIcon2 : markerIcon),
          position: latLng[i],
          infoWindow: InfoWindow(
            title: _markerTitle,
            snippet: _markerSnippet,
          ),
        ),
      );
      setState(() {});
    }
  }

  //============================================== Adding polypoints ==================================================\\
  void getPolyPoints(LatLng from, LatLng to) async {
    if (kIsWeb) {
      String routeStr =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${from.latitude},${from.longitude}&destination=${to.latitude},${to.longitude}&mode=driving&avoidHighways=false&avoidFerries=true&avoidTolls=false&alternatives=false&key=$googleMapsApiKey';
      String? response = await NetworkUtility.fetchUrl(Uri.parse(routeStr));
      // var resp = await http.get(Uri.parse(routeStr));
      if (response == null) {
        return;
      }
      Map data = jsonDecode(response);
      if (data['routes'].isEmpty) {
        return;
      }

      var overviewPolyline = MyNetworkUtil().decodeEncodedPolyline(
          data['routes'][0]['overview_polyline']['points']);
      if (overviewPolyline.isNotEmpty) {
        for (var point in overviewPolyline) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {});
      }
      return;
    }
    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey,
      PointLatLng(from.latitude, from.longitude),
      PointLatLng(to.latitude, to.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

//============================================== Create Google Maps ==================================================\\

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    _newGoogleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "Assign Rider",
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        actions: const [],
      ),
      body: Stack(
        children: [
          loadingMap
              ? Center(
                  child: CircularProgressIndicator(
                    color: kAccentColor,
                  ),
                )
              : GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: widget.latlngRiders[0],
                    zoom: 18,
                  ),
                  markers: Set.of(_markers),
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("Available Riders"),
                      points: _polylineCoordinates,
                      color: kAccentColor,
                      width: 4,
                    ),
                  },
                  padding: EdgeInsets.only(
                    bottom: selectedRider == null ? 100 : 400,
                  ),
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                  tiltGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  fortyFiveDegreeImageryEnabled: true,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            left: 0,
            right: 0,
            bottom: selectedRider == null ? -200 : 0,
            child: Container(
              // width: 200,
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 2, vertical: kDefaultPadding),
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: kBlackColor.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                    blurStyle: BlurStyle.normal,
                  ),
                ],
                color: const Color(0xFFFEF8F8),
                shape: const RoundedRectangleBorder(
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
                          selectedRider = null;
                        });
                      },
                      child: Text(
                        selectedRider != null ? "Hide" : "",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: media.width,
                    child: const Text(
                      'rider name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  Container(
                    width: media.width,
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: kAccentColor,
                          size: 15,
                        ),
                        kHalfWidthSizedBox,
                        SizedBox(
                          width: media.width - 200,
                          child: Text(
                            "rider address ${(selectedRider ?? 0).toString()}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kSizedBox,
                  MyElevatedButton(
                    title: "Assign task",
                    onPressed: () async {},
                  ),
                  kHalfSizedBox
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
