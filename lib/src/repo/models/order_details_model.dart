import 'client_model.dart';
import 'product_model.dart';

class OrderDetails {
  final String id;
  final String deliveryAddress;
  final String status;
  final int quantity;
  final String created;
  final Client clientId;
  final Product productId;

  OrderDetails({
    required this.id,
    required this.deliveryAddress,
    required this.status,
    required this.quantity,
    required this.created,
    required this.clientId,
    required this.productId,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      quantity: json['quantity'],
      created: json['created'],
      clientId: Client.fromJson(json['client_id']),
      productId: Product.fromJson(json['product_id']),
    );
  }
}
