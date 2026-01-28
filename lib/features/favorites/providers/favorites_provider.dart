import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _restaurantKey = 'favorite_restaurants';
  static const String _foodKey = 'favorite_foods';
  
  Set<String> _favoriteRestaurantIds = {};
  Set<String> _favoriteFoodIds = {};

  FavoritesProvider(this._prefs) {
    _loadFavorites();
  }

  Set<String> get favoriteRestaurantIds => _favoriteRestaurantIds;
  Set<String> get favoriteFoodIds => _favoriteFoodIds;

  void _loadFavorites() {
    _favoriteRestaurantIds = (_prefs.getStringList(_restaurantKey) ?? []).toSet();
    _favoriteFoodIds = (_prefs.getStringList(_foodKey) ?? []).toSet();
    notifyListeners();
  }

  Future<void> toggleRestaurantFavorite(String restaurantId) async {
    if (_favoriteRestaurantIds.contains(restaurantId)) {
      _favoriteRestaurantIds.remove(restaurantId);
    } else {
      _favoriteRestaurantIds.add(restaurantId);
    }
    await _prefs.setStringList(_restaurantKey, _favoriteRestaurantIds.toList());
    notifyListeners();
  }

  Future<void> toggleFoodFavorite(String foodId) async {
    if (_favoriteFoodIds.contains(foodId)) {
      _favoriteFoodIds.remove(foodId);
    } else {
      _favoriteFoodIds.add(foodId);
    }
    await _prefs.setStringList(_foodKey, _favoriteFoodIds.toList());
    notifyListeners();
  }

  bool isRestaurantFavorite(String restaurantId) {
    return _favoriteRestaurantIds.contains(restaurantId);
  }

  bool isFoodFavorite(String foodId) {
    return _favoriteFoodIds.contains(foodId);
  }

  // Backward compatibility for existing code
  bool isFavorite(String id) => isRestaurantFavorite(id);
  Future<void> toggleFavorite(String id) => toggleRestaurantFavorite(id);
}
