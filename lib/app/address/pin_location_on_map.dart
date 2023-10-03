// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui' as ui; // Import the ui library with an alias

import 'package:benji_user/src/common_widgets/button/my_elevatedbutton.dart';
import 'package:benji_user/src/repo/models/googleMaps/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../src/common_widgets/appbar/my_appbar.dart';
import '../../src/common_widgets/textformfield/my textformfield.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class PinLocationOnMap extends StatefulWidget {
  const PinLocationOnMap({super.key});

  @override
  State<PinLocationOnMap> createState() => _PinLocationOnMapState();
}

class _PinLocationOnMapState extends State<PinLocationOnMap> {
  //============================================================== INITIAL STATE ====================================================================\\
  @override
  void initState() {
    super.initState();
    // _getPolyPoints();
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

  //====================================== Setting Google Map Consts =========================================\\

  Position? _userPosition;

  Uint8List? _markerImage;
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
    await _getUserCurrentLocation();
    await _loadCustomMarkers();
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
        CameraPosition(target: latLngPosition, zoom: 14);

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

//============================================== Create Google Maps ==================================================\\

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    _newGoogleMapController = controller;
  }

//========================================================== Navigation =============================================================\\
  void _selectLocation() {}

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
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
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: _userPosition == null
              ? Center(child: SpinKitChasingDots(color: kAccentColor))
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
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
                        ),
                        IconButton(
                          onPressed: () {
                            LocationService().getPlace(_searchEC.text);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 18,
                            color: kAccentColor,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GoogleMap(
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
                        markers: Set.of(_markers),
                        compassEnabled: true,
                        mapToolbarEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
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
                    ),
                    Container(
                      height: media.height * 0.24,
                      width: media.width,
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFEF8F8),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  color: Color(0xFFFDEDED),
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  blurRadius: 24,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(5),
                              leading: Image.asset(
                                "assets/icons/location-icon.png",
                                height: 50,
                                width: 50,
                              ),
                              title: const Text(
                                "Pinned Location",
                                style: TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                "Dummy location, location",
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          kSizedBox,
                          MyElevatedButton(
                            title: "Select Location",
                            onPressed: _selectLocation,
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
