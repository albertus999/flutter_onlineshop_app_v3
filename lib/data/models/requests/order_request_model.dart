// import 'package:meta/meta.dart';
import 'dart:convert';

class OrderRequestModel {
    final int addressId;
    final String paymentMethod;
    final String shippingService;
    final int shippingCost;
    final String paymentVaName;
    final int subtotal;
    final int totalCost;
    final List<Item> items;

    OrderRequestModel({
        required this.addressId,
        required this.paymentMethod,
        required this.shippingService,
        required this.shippingCost,
        required this.paymentVaName,
        required this.subtotal,
        required this.totalCost,
        required this.items,
    });

    factory OrderRequestModel.fromJson(String str) => OrderRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderRequestModel.fromMap(Map<String, dynamic> json) => OrderRequestModel(
        addressId: json["address_id"],
        paymentMethod: json["payment_method"],
        shippingService: json["shipping_service"],
        shippingCost: json["shipping_cost"],
        paymentVaName: json["payment_va_name"],
        subtotal: json["subtotal"],
        totalCost: json["total_cost"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "address_id": addressId,
        "payment_method": paymentMethod,
        "shipping_service": shippingService,
        "shipping_cost": shippingCost,
        "payment_va_name": paymentVaName,
        "subtotal": subtotal,
        "total_cost": totalCost,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class Item {
    final int productId;
    final int quantity;

    Item({
        required this.productId,
        required this.quantity,
    });

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
    };
}
