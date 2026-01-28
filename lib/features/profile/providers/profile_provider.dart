import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_flutter/features/profile/models/address_model.dart';
import 'package:exam_flutter/features/profile/models/payment_method_model.dart';

class ProfileProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _addressKey = 'user_addresses';
  static const String _paymentKey = 'user_payments';

  List<AddressModel> _addresses = [];
  List<PaymentMethodModel> _paymentMethods = [];

  ProfileProvider(this._prefs) {
    _loadData();
  }

  List<AddressModel> get addresses => [..._addresses];
  List<PaymentMethodModel> get paymentMethods => [..._paymentMethods];

  void _loadData() {
    // Load Addresses
    final addressList = _prefs.getStringList(_addressKey) ?? [];
    if (addressList.isEmpty) {
      _addresses = [
        AddressModel(id: '1', title: 'Home', address: '123 Foodie Street, Italian District', isDefault: true),
        AddressModel(id: '2', title: 'Office', address: '456 Tech Avenue, Innovation Park'),
      ];
    } else {
      _addresses = addressList.map((item) => AddressModel.fromJson(json.decode(item))).toList();
    }

    // Load Payments
    final paymentList = _prefs.getStringList(_paymentKey) ?? [];
    if (paymentList.isEmpty) {
      _paymentMethods = [
        PaymentMethodModel(id: '1', type: 'Visa', number: '**** **** **** 4567', expiry: '12/26', isSelected: true),
        PaymentMethodModel(id: '2', type: 'MasterCard', number: '**** **** **** 8901', expiry: '08/25'),
      ];
    } else {
      _paymentMethods = paymentList.map((item) => PaymentMethodModel.fromJson(json.decode(item))).toList();
    }
    notifyListeners();
  }

  Future<void> addAddress(AddressModel address) async {
    _addresses.add(address);
    await _saveAddresses();
    notifyListeners();
  }

  Future<void> removeAddress(String id) async {
    _addresses.removeWhere((a) => a.id == id);
    await _saveAddresses();
    notifyListeners();
  }

  Future<void> _saveAddresses() async {
    final list = _addresses.map((a) => json.encode(a.toJson())).toList();
    await _prefs.setStringList(_addressKey, list);
  }

  Future<void> addPaymentMethod(PaymentMethodModel method) async {
    _paymentMethods.add(method);
    await _savePayments();
    notifyListeners();
  }

  Future<void> _savePayments() async {
    final list = _paymentMethods.map((p) => json.encode(p.toJson())).toList();
    await _prefs.setStringList(_paymentKey, list);
  }
}
