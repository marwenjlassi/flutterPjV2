import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exam_flutter/features/food/models/food_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<FoodModel>> getFoods() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/recipes?limit=100'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List recipes = data['recipes'];
        return recipes.map((json) => FoodModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load foods');
      }
    } catch (e) {
      throw Exception('Error fetching foods: $e');
    }
  }

  Future<List<String>> getCuisines() async {
    try {
      // DummyJSON recipes don't have a dedicated categories endpoint for cuisines,
      // so we fetch all recipes and extract unique cuisines.
      final response = await http.get(Uri.parse('$_baseUrl/recipes?limit=100'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List recipes = data['recipes'];
        final Set<String> cuisines = recipes.map((r) => r['cuisine'].toString()).toSet();
        return cuisines.toList();
      } else {
        throw Exception('Failed to load cuisines');
      }
    } catch (e) {
      throw Exception('Error fetching cuisines: $e');
    }
  }

  Future<List<FoodModel>> getFoodsByCuisine(String cuisine) async {
    try {
      // DummyJSON doesn't have a direct filter by cuisine in URL for recipes,
      // so we fetch all and filter locally for better UX.
      final response = await http.get(Uri.parse('$_baseUrl/recipes?limit=100'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List recipes = data['recipes'];
        return recipes
            .where((r) => r['cuisine'] == cuisine)
            .map((json) => FoodModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load foods for cuisine $cuisine');
      }
    } catch (e) {
      throw Exception('Error fetching foods by cuisine: $e');
    }
  }

  Future<List<FoodModel>> searchFoods(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/recipes/search?q=$query'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List recipes = data['recipes'];
        return recipes.map((json) => FoodModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search foods');
      }
    } catch (e) {
      throw Exception('Error searching foods: $e');
    }
  }
}
