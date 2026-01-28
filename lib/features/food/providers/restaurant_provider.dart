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
  String _selectedCategory = 'All';

  RestaurantProvider(this._apiService);

  List<RestaurantModel> get restaurants => _filteredRestaurants;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

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

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    _filteredRestaurants = _allRestaurants;

    // Apply category filter
    if (_selectedCategory != 'All') {
      _filteredRestaurants = _filteredRestaurants
          .where((r) => r.category == _selectedCategory)
          .toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredRestaurants = _filteredRestaurants
          .where((r) =>
              r.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              r.category.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }
}
