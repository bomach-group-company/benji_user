import 'dart:math' as math;

class DistanceCalculator {
  static const double _earthRadiusKm = 6371.0;

  static double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    final double startLatRadians = _degreesToRadians(startLatitude);
    final double startLngRadians = _degreesToRadians(startLongitude);
    final double endLatRadians = _degreesToRadians(endLatitude);
    final double endLngRadians = _degreesToRadians(endLongitude);

    final double deltaLat = endLatRadians - startLatRadians;
    final double deltaLng = endLngRadians - startLngRadians;

    final double a = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(startLatRadians) *
            math.cos(endLatRadians) *
            math.sin(deltaLng / 2) *
            math.sin(deltaLng / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    final double distance = _earthRadiusKm * c;

    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }
}
