class Country {
  final String? code;
  final String? name;

  Country({
    this.code,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      name: json['name'],
    );
  }
}
