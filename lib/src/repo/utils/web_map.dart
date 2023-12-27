import 'dart:convert';

List parseLatLng(String jsonResponse) {
  Map<String, dynamic> decodedResponse = jsonDecode(jsonResponse);

  if (decodedResponse['status'] == 'OK') {
    List<dynamic> results = decodedResponse['results'];

    if (results.isNotEmpty) {
      Map<String, dynamic> geometry = results[0]['geometry'];
      Map<String, dynamic> location = geometry['location'];

      double latitude = location['lat'];
      double longitude = location['lng'];

      print('Latitude: $latitude');
      print('Longitude: $longitude');
      return [latitude, longitude];
    } else {
      print('No results found');
      return [];
    }
  } else {
    print('Error: ${decodedResponse['status']}');
    return [];
  }
}
