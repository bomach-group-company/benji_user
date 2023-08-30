class DeliveryAddress {
  final String id;
  final String streetAddress;
  final int user;
  final String title;
  final String details;
  final String recipientName;
  final String phone;
  final String country;
  final String state;
  final String city;
  final bool isCurrent;

  DeliveryAddress({
    required this.id,
    required this.streetAddress,
    required this.user,
    required this.title,
    required this.details,
    required this.recipientName,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.isCurrent,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['id'],
      streetAddress: json['street_address'],
      user: json['user'],
      title: json['title'],
      details: json['details'],
      recipientName: json['recipient_name'],
      phone: json['phone'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      isCurrent: json['is_current'],
    );
  }
}
