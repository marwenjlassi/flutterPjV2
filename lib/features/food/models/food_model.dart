import 'package:equatable/equatable.dart';

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
    };
  }

  @override
  List<Object?> get props => [id, title, description, price, rating, category, thumbnail, ingredients, prepTime];
}
