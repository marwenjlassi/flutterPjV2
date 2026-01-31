import 'package:flutter/foundation.dart';
import 'package:exam_flutter/features/food/models/food_model.dart';
import 'package:exam_flutter/features/food/models/review_model.dart';
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
      
      // Add dummy reviews to popular foods
      for (var i = 0; i < _popularFoods.length; i++) {
        _popularFoods[i] = _addDummyReviews(_popularFoods[i]);
      }
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
      // Add dummy reviews
      for (var i = 0; i < _foods.length; i++) {
        _foods[i] = _addDummyReviews(_foods[i]);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  FoodModel _addDummyReviews(FoodModel food) {
    // Only add reviews if empty (to avoid overwriting if we had real data)
    if (food.reviews.isNotEmpty) return food;

    final reviews = [
      ReviewModel(
        id: '1',
        userName: 'John Doe',
        rating: 5.0,
        comment: 'Absolutely delicious! The flavors were perfectly balanced.',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ReviewModel(
        id: '2',
        userName: 'Jane Smith',
        rating: 4.5,
        comment: 'Great food, fast delivery. Will order again.',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ReviewModel(
        id: '3',
        userName: 'Mike Johnson',
        rating: 4.0,
        comment: 'Good portion size, but could be a bit spicier.',
        date: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];

    return FoodModel(
      id: food.id,
      title: food.title,
      description: food.description,
      price: food.price,
      rating: food.rating,
      category: food.category,
      thumbnail: food.thumbnail,
      ingredients: food.ingredients,
      prepTime: food.prepTime,
      reviews: reviews,
    );
  }

  void addReview(int foodId, double rating, String comment) {
    // Update in _foods
    final index = _foods.indexWhere((f) => f.id == foodId);
    if (index != -1) {
      final newReview = ReviewModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: 'You', // In a real app, get from AuthProvider
        rating: rating,
        comment: comment,
        date: DateTime.now(),
      );
      
      final updatedReviews = List<ReviewModel>.from(_foods[index].reviews)..insert(0, newReview);
      
      // Calculate new average rating
      double totalRating = 0;
      for (var r in updatedReviews) {
        totalRating += r.rating;
      }
      final newAverage = totalRating / updatedReviews.length;

      _foods[index] = FoodModel(
        id: _foods[index].id,
        title: _foods[index].title,
        description: _foods[index].description,
        price: _foods[index].price,
        rating: newAverage,
        category: _foods[index].category,
        thumbnail: _foods[index].thumbnail,
        ingredients: _foods[index].ingredients,
        prepTime: _foods[index].prepTime,
        reviews: updatedReviews,
      );
    }

    // Update in _popularFoods
    final popIndex = _popularFoods.indexWhere((f) => f.id == foodId);
    if (popIndex != -1) {
       final newReview = ReviewModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: 'You',
        rating: rating,
        comment: comment,
        date: DateTime.now(),
      );
      
      final updatedReviews = List<ReviewModel>.from(_popularFoods[popIndex].reviews)..insert(0, newReview);
      
       // Calculate new average rating
      double totalRating = 0;
      for (var r in updatedReviews) {
        totalRating += r.rating;
      }
      final newAverage = totalRating / updatedReviews.length;

      _popularFoods[popIndex] = FoodModel(
        id: _popularFoods[popIndex].id,
        title: _popularFoods[popIndex].title,
        description: _popularFoods[popIndex].description,
        price: _popularFoods[popIndex].price,
        rating: newAverage,
        category: _popularFoods[popIndex].category,
        thumbnail: _popularFoods[popIndex].thumbnail,
        ingredients: _popularFoods[popIndex].ingredients,
        prepTime: _popularFoods[popIndex].prepTime,
        reviews: updatedReviews,
      );
    }
    notifyListeners();
  }

  void updateFoodRating(int foodId, double newRating) {
    // Deprecated in favor of addReview, but kept for compatibility if needed
    // We can redirect to addReview with empty comment
    addReview(foodId, newRating, '');
  }
}
