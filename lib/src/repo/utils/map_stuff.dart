import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromCoordinates(
    String latitude, String longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    if (placemarks.isNotEmpty) {
      Placemark firstPlacemark = placemarks.first;
      String address =
          '${firstPlacemark.street}, ${firstPlacemark.locality}, ${firstPlacemark.administrativeArea}, ${firstPlacemark.country}';
      return address;
    } else {
      return 'No address found';
    }
  } catch (e) {
    return 'Error getting address';
  }
}
