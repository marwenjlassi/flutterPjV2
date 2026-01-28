import 'package:flutter/foundation.dart';
import 'package:exam_flutter/features/food/models/food_model.dart';
import 'package:exam_flutter/features/food/services/api_service.dart';

class FoodProvider with ChangeNotifier {
  final ApiService _apiService;
  List<FoodModel> _foods = [];
  List<FoodModel> _popularFoods = [];
  bool _isLoading = false;
  String? _error;

  FoodProvider(this._apiService);

  List<FoodModel> get foods => _foods;
  List<FoodModel> get popularFoods => _popularFoods;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPopularFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final allFoods = await _apiService.getFoods();
      // Sort by rating and take top 10
      _popularFoods = allFoods..sort((a, b) => b.rating.compareTo(a.rating));
      _popularFoods = _popularFoods.take(10).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFoodsByCategory(String cuisine) async {
    _isLoading = true;
    _error = null;
    _foods = [];
    notifyListeners();

    try {
      _foods = await _apiService.getFoodsByCuisine(cuisine);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
