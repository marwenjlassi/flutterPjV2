import 'package:flutter/foundation.dart';
import 'package:exam_flutter/features/food/models/food_model.dart';
import 'package:exam_flutter/features/food/services/api_service.dart';

class FoodProvider with ChangeNotifier {
  final ApiService _apiService;
  List<FoodModel> _foods = [];
  bool _isLoading = false;
  String? _error;

  FoodProvider(this._apiService);

  List<FoodModel> get foods => _foods;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchFoodsByCategory(String category) async {
    _isLoading = true;
    _error = null;
    _foods = [];
    notifyListeners();

    try {
      _foods = await _apiService.getFoodsByCategory(category);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
