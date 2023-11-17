class VendorDataModel {
  String productId;
  int quantity;
  String message;

  VendorDataModel({
    required this.productId,
    required this.quantity,
    required this.message,
  });

  factory VendorDataModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VendorDataModel(
      productId: json['product_id'] ?? '',
      quantity: json['quantity'] ?? 1,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "message": message,
    };
  }
}

class VendorInfo {
  List<VendorDataModel> vendorData;
  String deliveryAddressId;
  String latitude;
  String longitude;

  VendorInfo({
    required this.vendorData,
    required this.deliveryAddressId,
    required this.latitude,
    required this.longitude,
  });

  factory VendorInfo.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    List<dynamic> vendorDataList = json['vendor_data'] ?? [];
    List<VendorDataModel> vendorData = vendorDataList
        .map((vendorDataJson) => VendorDataModel.fromJson(vendorDataJson))
        .toList();

    return VendorInfo(
      vendorData: vendorData,
      deliveryAddressId: json['delivery_address_id'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vendor_data": vendorData.map((data) => data.toJson()).toList(),
      'delivery_address_id': deliveryAddressId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
