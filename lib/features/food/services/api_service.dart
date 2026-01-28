import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exam_flutter/features/food/models/food_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<FoodModel>> getFoods() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List products = data['products'];
        return products.map((json) => FoodModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load foods');
      }
    } catch (e) {
      throw Exception('Error fetching foods: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/categories'));
      if (response.statusCode == 200) {
        final List categories = json.decode(response.body);
        // DummyJSON categories can be objects or strings depending on version
        return categories.map((c) => c is Map ? c['slug'].toString() : c.toString()).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<FoodModel>> getFoodsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/category/$category'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List products = data['products'];
        return products.map((json) => FoodModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load foods for category $category');
      }
    } catch (e) {
      throw Exception('Error fetching foods by category: $e');
    }
  }
}
