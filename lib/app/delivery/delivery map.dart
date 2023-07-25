// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../src/providers/constants.dart';
import '../../src/reusable widgets/my appbar.dart';
import '../../src/reusable widgets/my elevatedbutton.dart';
import '../../theme/colors.dart';

class DeliveryMap extends StatefulWidget {
  const DeliveryMap({super.key});

  @override
  State<DeliveryMap> createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  //====================== ALL VARIABLES =====================================\\

  //===================== GlobalKeys =======================\\

  //===================== CONTROLLERS =======================\\
  GoogleMapController? _googleMapController;
  // final _googleMapController = Completer<GoogleMapController>();

  //===================== GOOGLE MAP =======================\\

  // Future<bool> getLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();

  //     if (permission == LocationPermission.denied) {
  //       return false;
  //     }
  //   }

  //   if (permission == LocationPermission.denied) {
  //     return false;
  //   }

  //   return false;
  // }

  final LatLng _latLng = const LatLng(
    6.456076934514027,
    7.507987759047121,
  );

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Track Order",
        toolbarHeight: 80,
        elevation: 0.0,
        backgroundColor: kPrimaryColor.withOpacity(
          0,
        ),
        actions: [],
      ),
      backgroundColor: kPrimaryColor,
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
            left: 20,
            right: 20,
            bottom: 25,
            child: MyElevatedButton(
              title: "Track Order",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: kPrimaryColor,
                  barrierColor: kBlackColor.withOpacity(
                    0.5,
                  ),
                  showDragHandle: true,
                  useSafeArea: true,
                  isScrollControlled: true,
                  isDismissible: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        kDefaultPadding,
                      ),
                    ),
                  ),
                  enableDrag: true,
                  builder: (context) => SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: kDefaultPadding,
                            right: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 167,
                                    child: Text(
                                      'Status',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.of(context).pushReplacement(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => TrackOrder(),
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      'See Details',
                                      style: TextStyle(
                                        color: Color(
                                          0xFFEC2623,
                                        ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 264,
                                child: Text(
                                  'Order received by vendor',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF222222,
                                    ),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              kSizedBox,
                              Container(
                                width: 280,
                                height: 85,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 280,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 111,
                                      top: 18,
                                      child: Container(
                                        width: 200,
                                        height: 62,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: SizedBox(
                                                width: 120,
                                                height: 29,
                                                child: Text(
                                                  "Chizzy\'s Food",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Color(
                                                      0xFF222222,
                                                    ),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 33,
                                              child: SizedBox(
                                                width: 64,
                                                height: 29,
                                                child: Text(
                                                  '3 Items',
                                                  style: TextStyle(
                                                    color: Color(
                                                      0xFF444343,
                                                    ),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 100,
                                              top: 33,
                                              child: Text(
                                                'Waiting',
                                                style: TextStyle(
                                                  color: Color(
                                                    0xFF808080,
                                                  ),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: -6,
                                      child: Container(
                                        width: 80,
                                        height: 96,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/food/chizzy's-food.png",
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kHalfSizedBox,
                              Divider(
                                color: Color(
                                  0xFFC4C4C4,
                                ),
                                thickness: 1.0,
                              ),
                              kHalfSizedBox,
                              Text(
                                'Delivery Officer',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              kHalfSizedBox,
                              Container(
                                width: 380,
                                height: 85,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 60,
                                      top: 18,
                                      child: Container(
                                        width: 290,
                                        height: 62,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: SizedBox(
                                                width: 184,
                                                height: 20,
                                                child: Text(
                                                  'Martins Okafor',
                                                  style: TextStyle(
                                                    color: kTextBlackColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 24,
                                              child: SizedBox(
                                                width: 100,
                                                height: 29,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 14,
                                                      color: Color(
                                                        0xFF575757,
                                                      ),
                                                    ),
                                                    Text(
                                                      '3.2km away',
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF575757,
                                                        ),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 200,
                                              top: 8,
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: ShapeDecoration(
                                                  color: Color(
                                                    0xFFEC2623,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      16,
                                                    ),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      spreadRadius: 0.7,
                                                      color: kBlackColor
                                                          .withOpacity(0.4),
                                                      offset:
                                                          const Offset(0, 4),
                                                    )
                                                  ],
                                                ),
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.phone_rounded,
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 20,
                                      child: Container(
                                        width: 48,
                                        height: 49,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/rider/martins-okafor.png",
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
