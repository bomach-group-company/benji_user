class ShoppingLocationCountry {
  final String country;

  ShoppingLocationCountry({
    required this.country,
  });

  factory ShoppingLocationCountry.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ShoppingLocationCountry(
      country: json['country'] ?? '',
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
      state: json['state'] ?? '',
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
      city: json['city'] ?? '',
    );
  }
}
