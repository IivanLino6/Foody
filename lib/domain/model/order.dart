// To parse this JSON data, do
//
//     final orderData = orderDataFromJson(jsonString);

import 'dart:convert';

import 'package:stripe_payment/domain/model/cart_list.dart';

OrderData orderDataFromJson(String str) => OrderData.fromJson(json.decode(str));

String orderDataToJson(OrderData data) => json.encode(data.toJson());

class OrderData {
    String id;
    String createdDate;
    List<CartList> items;
    String subtotalAmount;
    String totalAmount;
    String paymentMethod;
    String costumerId;

    OrderData({
        required this.id,
        required this.createdDate,
        required this.items,
        required this.subtotalAmount,
        required this.totalAmount,
        required this.paymentMethod,
        required this.costumerId,
    });
    
    factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        createdDate: json["createdDate"],
        items: json["items"] != null ? List.from(json["items"]) : [],
        subtotalAmount: json["subtotalAmount"],
        totalAmount: json["totalAmount"],
        paymentMethod: json["paymentMethod"],
        costumerId: json["costumerId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        'items': items.map((item) => item.toJson()).toList(),   //Mandamos llamar los methodos toJson
        "subtotalAmount": subtotalAmount,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod,
        "costumerId": costumerId,
    };
}
