import 'package:flutter/foundation.dart';
import 'package:exam_flutter/features/cart/models/cart_item_model.dart';
import 'package:exam_flutter/features/food/models/food_model.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItemModel> _items = {};

  Map<int, CartItemModel> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.totalPrice;
    });
    return total;
  }

  void addItem(FoodModel food) {
    if (_items.containsKey(food.id)) {
      _items.update(
        food.id,
        (existing) => CartItemModel(
          food: existing.food,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        food.id,
        () => CartItemModel(food: food),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(int foodId) {
    if (!_items.containsKey(foodId)) return;
    
    if (_items[foodId]!.quantity > 1) {
      _items.update(
        foodId,
        (existing) => CartItemModel(
          food: existing.food,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(foodId);
    }
    notifyListeners();
  }

  void removeItem(int foodId) {
    _items.remove(foodId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
