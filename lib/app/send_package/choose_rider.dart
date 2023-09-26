// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../theme/colors.dart';

class ChooseRider extends StatefulWidget {
  const ChooseRider({super.key});

  @override
  State<ChooseRider> createState() => _ChooseRiderState();
}

class _ChooseRiderState extends State<ChooseRider> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();
    // _getPolyPoints();
    _markerTitle = <String>["Me", "Rider"];
    _markerSnippet = <String>["My Location", "Rider location"];
    _loadMapData();
  }

  //============================================================= ALL VARIABLES ======================================================================\\

  //====================================== Setting Google Map Consts =========================================\\

  Position? _userPosition;

  static const LatLng _vendorLocation =
      LatLng(6.463810164127019, 7.539888438605598);
  final List<LatLng> _polylineCoordinates = [];
  // List<LatLng> _latLng = <LatLng>[_userLocation, _vendorLocation];
  Uint8List? _markerImage;
  final List<Marker> _markers = <Marker>[];
  final List<MarkerId> _markerId = <MarkerId>[
    const MarkerId("0"),
    const MarkerId("1")
  ];
  List<String>? _markerTitle;
  List<String>? _markerSnippet;
  final List<String> _customMarkers = <String>[
    "assets/icons/person_location.png",
    "assets/icons/delivery_bike.png",
  ];
  //============================================================= BOOL VALUES ======================================================================\\
  bool _isExpanded = false;

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
    // await _getPolyPoints();
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
        CameraPosition(target: latLngPosition, zoom: 12.68);

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
      _vendorLocation
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "Choose a rider",
        elevation: 0.0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            _userPosition == null
                ? Center(child: SpinKitChasingDots(color: kAccentColor))
                : GoogleMap(
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _userPosition!.latitude,
                        _userPosition!.longitude,
                      ),
                      zoom: 12.68,
                    ),
                    markers: Set.of(_markers),
                    padding: EdgeInsets.only(
                      bottom: _isExpanded ? media.width * 0.32 : 90,
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
      ),
    );
  }
}
