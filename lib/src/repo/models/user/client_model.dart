class Client {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String image;

  Client({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
    );
  }
}
