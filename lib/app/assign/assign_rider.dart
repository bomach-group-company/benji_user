// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:benji/src/repo/utils/network_utils.dart';
import 'package:benji/src/repo/utils/points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/providers/keys.dart';
import '../../theme/colors.dart';

class AssignRiderMap extends StatefulWidget {
  final List<LatLng> latlng;
  const AssignRiderMap(
      {super.key,
      this.latlng = const [
        LatLng(6.45651722359882, 7.508459257912696),
        LatLng(6.456080131101715, 7.51028316003324)
      ]});

  @override
  State<AssignRiderMap> createState() => _AssignRiderMapState();
}

class _AssignRiderMapState extends State<AssignRiderMap> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();

    _markerTitle = <String>["Rider", "Rider"];
    _markerSnippet = <String>["Rider location", "Rider location"];
    _loadMapData();
  }

  //============================================================= ALL VARIABLES ======================================================================\\

  //====================================== Setting Google Map Consts =========================================\\

  Position? _userPosition;
  late LatLng _businessLocation;
  final List<LatLng> _polylineCoordinates = [];
  Uint8List? _markerImage;
  final List<Marker> _markers = <Marker>[];
  final List<MarkerId> _markerId = <MarkerId>[
    const MarkerId("Rider"),
    const MarkerId("Rider")
  ];
  List<String>? _markerTitle;
  List<String>? _markerSnippet;
  final List<String> _customMarkers = <String>[
    "assets/icons/person_location.png",
    "assets/icons/person_location.png",
  ];
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
    await _getUserCurrentLocation();
    await _loadCustomMarkers();
    getPolyPoints();
  }

//============================================== Get Current Location ==================================================\\

  Future<Position> _getUserCurrentLocation() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (location) => _userPosition = location,
    );

    LatLng latLngPosition =
        LatLng(userLocation.latitude, userLocation.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 16);

    _newGoogleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    return userLocation;
  }

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
    Position userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (location) => _userPosition = location,
    );
    List<LatLng> latLng = <LatLng>[
      LatLng(userLocation.latitude, userLocation.longitude),
      _businessLocation
    ];
    for (int i = 0; i < _customMarkers.length; i++) {
      final Uint8List markerIcon =
          await _getBytesFromAssets(_customMarkers[i], 100);

      _markers.add(
        Marker(
          markerId: _markerId[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: latLng[i],
          infoWindow: InfoWindow(
            title: _markerTitle![i],
            snippet: _markerSnippet![i],
          ),
        ),
      );
      setState(() {});
    }
  }

  //============================================== Adding polypoints ==================================================\\
  void getPolyPoints() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (location) => _userPosition = location,
    );
    if (kIsWeb) {
      String routeStr =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${userLocation.latitude},${userLocation.longitude}&destination=${_businessLocation.latitude},${_businessLocation.longitude}&mode=driving&avoidHighways=false&avoidFerries=true&avoidTolls=false&alternatives=false&key=$googleMapsApiKey';
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
      PointLatLng(userLocation.latitude, userLocation.longitude),
      PointLatLng(_businessLocation.latitude, _businessLocation.longitude),
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
          _userPosition == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: kAccentColor,
                  ),
                )
              : GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _userPosition!.latitude, _userPosition!.longitude),
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
                  padding: const EdgeInsets.only(
                    bottom: 20,
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
        ],
      ),
    );
  }
}
