import 'package:exam_flutter/features/cart/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final List<CartItemModel> items;
  final double totalAmount;
  final DateTime date;
  final String status; // 'Pending', 'Delivered'
  final String deliveryAddress;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    required this.status,
    required this.deliveryAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((i) => i.toJson()).toList(),
      'totalAmount': totalAmount,
      'date': date.toIso8601String(),
      'status': status,
      'deliveryAddress': deliveryAddress,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      items: (json['items'] as List).map((i) => CartItemModel.fromJson(i)).toList(),
      totalAmount: json['totalAmount'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      deliveryAddress: json['deliveryAddress'],
    );
  }
}
