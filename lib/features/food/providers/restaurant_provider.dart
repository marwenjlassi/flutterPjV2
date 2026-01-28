import 'package:flutter/foundation.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/models/restaurant_model.dart';
import 'package:exam_flutter/features/food/services/api_service.dart';

class RestaurantProvider with ChangeNotifier {
  final ApiService _apiService;
  List<RestaurantModel> _allRestaurants = [];
  List<RestaurantModel> _filteredRestaurants = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  RestaurantProvider(this._apiService);

  List<RestaurantModel> get restaurants => _filteredRestaurants;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  Future<void> fetchRestaurants() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final cuisines = await _apiService.getCuisines();
      _allRestaurants = cuisines.map((cuisine) {
        // Use a landmark image for each restaurant based on cuisine
        final imageUrl = AppConstants.cuisineLandmarks[cuisine] ?? 
            AppConstants.defaultRestaurantImage;
        return RestaurantModel.fromCategory(cuisine, imageUrl);
      }).toList();
      _applySearch();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchRestaurants(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredRestaurants = _allRestaurants;
    } else {
      _filteredRestaurants = _allRestaurants
          .where((r) =>
              r.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              r.category.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }
}
