// ignore_for_file: unused_field, library_prefixes

import 'dart:async';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:benji_user/src/repo/models/googleMaps/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as Lottie;

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/textformfield/my textformfield.dart';
import '../../theme/colors.dart';

class GetLocationOnMap extends StatefulWidget {
  const GetLocationOnMap({super.key});

  @override
  State<GetLocationOnMap> createState() => _GetLocationOnMapState();
}

class _GetLocationOnMapState extends State<GetLocationOnMap> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();

    _markerTitle = <String>["Me"];
    _markerSnippet = <String>["My Location"];
    _loadMapData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //============================================================= ALL VARIABLES ======================================================================\\

  //============================================================= BOOL VALUES ======================================================================\\
  bool animatedPinIsVisible = true;

  //====================================== Setting Google Map Consts =========================================\\

  Position? _userPosition;
  CameraPosition? _cameraPosition;

  Uint8List? _markerImage;
  late LatLng draggedLatLng;
  final List<Marker> _markers = <Marker>[];
  final List<MarkerId> _markerId = <MarkerId>[
    const MarkerId("0"),
  ];
  List<String>? _markerTitle;
  List<String>? _markerSnippet;
  final List<String> _customMarkers = <String>[
    "assets/icons/person_location.png",
  ];
  //============================================================= BOOL VALUES ======================================================================\\

  //========================================================== GlobalKeys ============================================================\\

  //=================================== CONTROLLERS ======================================================\\
  final _searchEC = TextEditingController();

  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? _newGoogleMapController;

  //=================================== FOCUS NODES ======================================================\\
  final _searchFN = FocusNode();

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
    await _getAndGoToUserCurrentLocation();
    await _loadCustomMarkers();
  }

//============================================== Get Current Location ==================================================\\

  Future<Position> _getAndGoToUserCurrentLocation() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (location) => _userPosition = location,
    );

    LatLng latLngPosition =
        LatLng(userLocation.latitude, userLocation.longitude);
    setState(() {
      draggedLatLng = latLngPosition;
    });
    _cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

    _newGoogleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(_cameraPosition!),
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

//========================================================== Locate a place =============================================================\\

  Future<void> _locatePlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    _goToSpecifiedLocation(LatLng(lat, lng), 18);
    // _markers.add(
    //   Marker(
    //     markerId: const MarkerId("1"),
    //     icon: BitmapDescriptor.defaultMarker,
    //     position: LatLng(lat, lng),
    //     infoWindow: InfoWindow(
    //       title: _searchEC.text,
    //       snippet: "Pinned Location",
    //     ),
    //   ),
    // );
  }

  void _searchPlaceFunc() async {
    setState(() {
      animatedPinIsVisible = false;
    });
    var place = await LocationService().getPlace(_searchEC.text);
    _locatePlace(place);
  }

//============================================== Go to specified location by LatLng ==================================================\\
  Future _goToSpecifiedLocation(LatLng position, double zoom) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: position,
      zoom: zoom,
    )));
    await _getPlaceMark(position);
  }

//========================================================== Get PlaceMark Address and LatLng =============================================================\\

  Future _getPlaceMark(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addressStr =
        "${address.name} ${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";

    setState(() {
      _searchEC.text = addressStr;
    });
  }

//============================================== Create Google Maps ==================================================\\

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    _newGoogleMapController = controller;
  }

//========================================================== Navigation =============================================================\\
  void _selectLocation() async {
    _getPlaceMark(draggedLatLng);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: MyAppBar(
          title: "Pin your location",
          elevation: 0.0,
          actions: const [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _selectLocation,
          backgroundColor: kAccentColor,
          tooltip: "Select Location",
          mouseCursor: SystemMouseCursors.click,
          child: const FaIcon(
            FontAwesomeIcons.locationCrosshairs,
            size: 18,
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _userPosition == null
              ? Center(child: SpinKitChasingDots(color: kAccentColor))
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormField(
                            controller: _searchEC,
                            focusNode: _searchFN,
                            hintText: "Enter your search",
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: _searchPlaceFunc,
                          icon: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 18,
                            color: kAccentColor,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _userPosition!.latitude,
                                _userPosition!.longitude,
                              ),
                              zoom: 14,
                            ),
                            onTap: (LatLng value) {},
                            onCameraIdle: () {
                              setState(() {
                                animatedPinIsVisible = true;
                              });
                              _getPlaceMark(draggedLatLng);
                            },
                            onCameraMove: (cameraPosition) {
                              setState(() {
                                animatedPinIsVisible = true;
                                draggedLatLng = cameraPosition.target;
                              });
                            },
                            markers: Set.of(_markers),
                            compassEnabled: true,
                            mapToolbarEnabled: true,
                            minMaxZoomPreference:
                                MinMaxZoomPreference.unbounded,
                            tiltGesturesEnabled: true,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: true,
                            fortyFiveDegreeImageryEnabled: true,
                            myLocationButtonEnabled: true,
                            liteModeEnabled: false,
                            myLocationEnabled: true,
                            cameraTargetBounds: CameraTargetBounds.unbounded,
                            rotateGesturesEnabled: true,
                            scrollGesturesEnabled: true,
                          ),
                          animatedPinIsVisible == false
                              ? const SizedBox()
                              : Center(
                                  child: Container(
                                    child: Lottie.Lottie.asset(
                                      "assets/animations/google_maps/location_pin.json",
                                      width: 60,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
