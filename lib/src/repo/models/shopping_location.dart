class ShoppingLocationCountry {
  final String countryName;
  final String countryShortName;
  final int countryPhoneCode;

  ShoppingLocationCountry({
    required this.countryName,
    required this.countryShortName,
    required this.countryPhoneCode,
  });

  factory ShoppingLocationCountry.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ShoppingLocationCountry(
      countryName: json['country_name'] ?? '',
      countryShortName: json['country_short_name'] ?? '',
      countryPhoneCode: json['country_phone_code'] ?? '',
    );
  }
}

class ShoppingLocationState {
  final String state;

  ShoppingLocationState({
    required this.state,
  });

  factory ShoppingLocationState.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ShoppingLocationState(
      state: json['state_name'] ?? '',
    );
  }
}


class ShoppingLocationCity {
  final String city;

  ShoppingLocationCity({
    required this.city,
  });

  factory ShoppingLocationCity.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ShoppingLocationCity(
      city: json['city_name'] ?? '',
    );
  }
}
