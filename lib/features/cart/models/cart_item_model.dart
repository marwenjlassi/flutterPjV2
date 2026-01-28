import 'package:exam_flutter/features/food/models/food_model.dart';

class CartItemModel {
  final FoodModel food;
  int quantity;

  CartItemModel({
    required this.food,
    this.quantity = 1,
  });

  double get totalPrice => food.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'food': food.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      food: FoodModel.fromJson(json['food']),
      quantity: json['quantity'],
    );
  }
}
