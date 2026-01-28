import 'package:flutter/foundation.dart';
import 'package:exam_flutter/features/food/models/restaurant_model.dart';
import 'package:exam_flutter/features/food/services/api_service.dart';

class RestaurantProvider with ChangeNotifier {
  final ApiService _apiService;
  List<RestaurantModel> _restaurants = [];
  bool _isLoading = false;
  String? _error;

  RestaurantProvider(this._apiService);

  List<RestaurantModel> get restaurants => _restaurants;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRestaurants() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final categories = await _apiService.getCategories();
      _restaurants = categories.map((cat) {
        // Use a placeholder image for each restaurant based on category
        final imageUrl = 'https://dummyjson.com/image/400x200/FF6B35/white?text=$cat';
        return RestaurantModel.fromCategory(cat, imageUrl);
      }).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
