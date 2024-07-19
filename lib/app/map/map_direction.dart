// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/src/providers/keys.dart';
import 'package:benji/src/repo/controller/error_controller.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDirection extends StatefulWidget {
  final double pickLat;
  final double pickLng;
  final double dropLat;
  final double dropLng;
  const MapDirection({
    super.key,
    required this.pickLat,
    required this.pickLng,
    required this.dropLat,
    required this.dropLng,
  });

  @override
  State<MapDirection> createState() => _MapDirectionState();
}

class _MapDirectionState extends State<MapDirection> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();
    _markerTitle = <String>["Rider", "Pickup", 'Dropoff'];
    _markerSnippet = <String>["Rider", "Pickup", "Your address"];

    pickLocation = LatLng(widget.pickLat, widget.pickLng);
    dropLocation = LatLng(widget.dropLat, widget.dropLng);
    riderLocation = const LatLng(6.494750367991621, 7.495600697299079);
    _loadMapData();

    // Timer(const Duration(seconds: 10), () {
    //   setState(() {
    //     riderLocation = const LatLng(6.501836136133997, 7.488233062201004);
    //   });
    //   _loadCustomMarkers().then((value) {
    //     getPolyPoints();
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }
  //============================================================= ALL VARIABLES ======================================================================\\

  late LatLng pickLocation;
  late LatLng dropLocation;
  late LatLng riderLocation;

  final List<LatLng> _polylineCoordinates = [];

  Uint8List? _markerImage;
  final List<Marker> _markers = <Marker>[];
  final List<MarkerId> _markerId = <MarkerId>[
    const MarkerId("0"),
    const MarkerId("1"),
    const MarkerId("2")
  ];
  List<String>? _markerTitle;
  List<String>? _markerSnippet;
  final List<String> _customMarkers = <String>[
    "assets/icons/delivery_bike.png",
    "assets/icons/store.png",
    "assets/icons/person_location.png",
  ];

  //============================================================= BOOL VALUES ======================================================================\\

  //========================================================== GlobalKeys ============================================================\\

  //=================================== CONTROLLERS ======================================================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  // GoogleMapController? _newGoogleMapController;

  //============================================================== FUNCTIONS ===================================================================\\

  //======================================= Google Maps ================================================\\

  /// When the location services are not enabled or permissions are denied the `Future` will return an error.
  Future<void> _loadMapData() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ApiProcessorController.errorSnack('Location services are disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ApiProcessorController.errorSnack(
            'Location permissions are denied, allow in settings');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ApiProcessorController.errorSnack(
          'Location permissions are denied, allow in settings');
      return;
    }
    print('part 1');
    await _loadCustomMarkers();
    getPolyPoints();
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

  Future _loadCustomMarkers() async {
    print('part 3 -1');

    List<LatLng> latLng = <LatLng>[riderLocation, pickLocation, dropLocation];
    for (int i = 0; i < latLng.length; i++) {
      print('load marker $i');
      final Uint8List markerIcon =
          await _getBytesFromAssets(_customMarkers[i], 100);
      print('sdfghjjhgf');
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
    }
    setState(() {});
    print('part 3');
  }

  //==============================================  Polypoints ==================================================\\

  void getPolyPoints() async {
    // if (kIsWeb) {
    //   String routeStr =
    //       'https://maps.googleapis.com/maps/api/directions/json?origin=${from.latitude},${from.longitude}&destination=${to.latitude},${to.longitude}&mode=driving&avoidHighways=false&avoidFerries=true&avoidTolls=false&alternatives=false&key=$googleMapsApiKey';
    //   String? response = await NetworkUtility.fetchUrl(Uri.parse(routeStr));

    //   if (response == null) {
    //     return;
    //   }
    //   Map data = jsonDecode(response);
    //   if (data['routes'].isEmpty) {
    //     return;
    //   }

    //   var overviewPolyline = MyNetworkUtil().decodeEncodedPolyline(
    //       data['routes'][0]['overview_polyline']['points']);
    //   if (overviewPolyline.isNotEmpty) {
    //     for (var point in overviewPolyline) {
    //       _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //     }
    //     setState(() {});
    //   }
    //   return;
    // }
    print('getRouteBetweenCoordinates 1');

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey,
      PointLatLng(riderLocation.latitude, riderLocation.longitude),
      PointLatLng(pickLocation.latitude, pickLocation.longitude),
    );

    print('getRouteBetweenCoordinates 2');

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
    print('getRouteBetweenCoordinates 3');

    result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey,
      PointLatLng(pickLocation.latitude, pickLocation.longitude),
      PointLatLng(dropLocation.latitude, dropLocation.longitude),
    );
    print('getRouteBetweenCoordinates 4');

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

//============================================== Create Google Maps ==================================================\\

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Track",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                // onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: riderLocation,
                  zoom: 14,
                ),
                markers: Set.of(_markers),
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("Delivery route"),
                    points: _polylineCoordinates,
                    color: kAccentColor,
                    consumeTapEvents: true,
                    geodesic: true,
                    width: 5,
                    visible: true,
                  ),
                },
                compassEnabled: true,
                mapToolbarEnabled: true,
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: false,
                fortyFiveDegreeImageryEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                cameraTargetBounds: CameraTargetBounds.unbounded,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: ListTile(
                leading: Container(
                  width: 47,
                  height: 47,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF979797),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x16000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF00300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: kTextWhiteColor,
                  ),
                ),
                title: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    ' Jay wills',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                subtitle: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                    ),
                    kHalfWidthSizedBox,
                    Text(
                      '3.2km away',
                      style: TextStyle(
                        color: Color(0xFF575757),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
