import 'dart:async';

import 'package:alpha_logistics/reusable%20widgets/my%20appbar.dart';
import 'package:alpha_logistics/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMap extends StatefulWidget {
  const DeliveryMap({super.key});

  @override
  State<DeliveryMap> createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  //====================== ALL VARIABLES =====================================\\

  //===================== GlobalKeys =======================\\

  //===================== CONTROLLERS =======================\\
  final _googleMapController = Completer<GoogleMapController>();
  //===================== GOOGLE MAP =======================\\
  Future<bool> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.denied) {
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        elevation: 0.0,
        title: "Track Order ",
      ),
      body: Stack(
        children: [
          FutureBuilder<bool>(
            future: getLocationPermission(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      6.456076934514027,
                      7.507987759047121,
                    ),
                    zoom: 16,
                    tilt: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController.complete(
                      controller,
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: kAccentColor,
                    strokeWidth: 10,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
