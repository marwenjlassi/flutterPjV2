import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_flutter/features/orders/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _key = 'order_history';
  List<OrderModel> _orders = [];

  OrderProvider(this._prefs) {
    _loadOrders();
  }

  List<OrderModel> get orders => [..._orders];

  void _loadOrders() {
    final list = _prefs.getStringList(_key) ?? [];
    _orders = list.map((item) => OrderModel.fromJson(json.decode(item))).toList();
    _orders.sort((a, b) => b.date.compareTo(a.date)); // Newest first
    notifyListeners();
  }

  Future<void> addOrder(OrderModel order) async {
    _orders.insert(0, order);
    final list = _orders.map((o) => json.encode(o.toJson())).toList();
    await _prefs.setStringList(_key, list);
    notifyListeners();
  }
}
