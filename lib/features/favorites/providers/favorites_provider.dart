import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _key = 'favorite_restaurants';
  Set<String> _favoriteIds = {};

  FavoritesProvider(this._prefs) {
    _loadFavorites();
  }

  Set<String> get favoriteIds => _favoriteIds;

  void _loadFavorites() {
    final list = _prefs.getStringList(_key) ?? [];
    _favoriteIds = list.toSet();
    notifyListeners();
  }

  Future<void> toggleFavorite(String restaurantId) async {
    if (_favoriteIds.contains(restaurantId)) {
      _favoriteIds.remove(restaurantId);
    } else {
      _favoriteIds.add(restaurantId);
    }
    await _prefs.setStringList(_key, _favoriteIds.toList());
    notifyListeners();
  }

  bool isFavorite(String restaurantId) {
    return _favoriteIds.contains(restaurantId);
  }
}
