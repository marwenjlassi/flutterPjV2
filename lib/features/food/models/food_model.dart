import 'package:equatable/equatable.dart';
import 'package:exam_flutter/features/food/models/review_model.dart';

class FoodModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String category; // Cuisine type
  final String thumbnail;
  final List<String> ingredients;
  final int prepTime;
  final List<ReviewModel> reviews;

  const FoodModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.thumbnail,
    required this.ingredients,
    required this.prepTime,
    this.reviews = const [],
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      title: json['name'],
      description: (json['instructions'] as List).join(' '),
      // Recipes don't have price, so we simulate it based on ID or prep time
      price: 10.0 + (json['prepTimeMinutes'] as int) / 2,
      rating: (json['rating'] as num).toDouble(),
      category: json['cuisine'],
      thumbnail: json['image'],
      ingredients: List<String>.from(json['ingredients']),
      prepTime: json['prepTimeMinutes'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((r) => ReviewModel.fromJson(r)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'instructions': [description],
      'price': price,
      'rating': rating,
      'cuisine': category,
      'image': thumbnail,
      'ingredients': ingredients,
      'prepTimeMinutes': prepTime,
      'reviews': reviews.map((r) => r.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, title, description, price, rating, category, thumbnail, ingredients, prepTime, reviews];
}
