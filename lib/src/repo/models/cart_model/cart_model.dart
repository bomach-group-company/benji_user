class ProductUserData {
  String productId;
  int quantity;
  double preTotal;
  String deliveryAddress;
  String latitude;
  String longitude;
  String message;

  ProductUserData({
    required this.productId,
    required this.quantity,
    required this.preTotal,
    required this.deliveryAddress,
    required this.latitude,
    required this.longitude,
    required this.message,
  });

  factory ProductUserData.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ProductUserData(
      productId: json['product_id'] ?? '',
      quantity: json['quantity'] ?? 1,
      preTotal: json['pre_total'] ?? 0,
      deliveryAddress: json['delivery_address_id'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "pre_total": preTotal,
      "delivery_address_id": deliveryAddress,
      "latitude": latitude,
      "longitude": longitude,
      "message": message,
    };
  }
}

class VendorInfo {
  List<ProductUserData> productUser;
  int vendorId;

  VendorInfo({
    required this.productUser,
    required this.vendorId,
  });

  factory VendorInfo.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    List<dynamic> productUserList = json['vendor_data'] ?? [];
    List<ProductUserData> productUser = productUserList
        .map((productUserJson) => ProductUserData.fromJson(productUserJson))
        .toList();

    return VendorInfo(
      productUser: productUser,
      vendorId: json['vendor_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vendor_data": productUser.map((data) => data.toJson()).toList(),
      "vendor_id": vendorId,
    };
  }
}

class AllCartItem {
  List<VendorInfo> data;

  AllCartItem({
    required this.data,
  });

  factory AllCartItem.fromJson(List? list) {
    list ??= [];
    return AllCartItem(
      data: list.map((item) => VendorInfo.fromJson(item)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return data.map((item) => item.toJson()).toList();
  }
}
