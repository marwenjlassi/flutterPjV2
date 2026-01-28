import 'package:equatable/equatable.dart';

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final double rating;
  final double latitude;
  final double longitude;
  final String address;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory RestaurantModel.fromCategory(String category, String imageUrl) {
    // Simulate restaurant data from category
    return RestaurantModel(
      id: category,
      name: '${category[0].toUpperCase()}${category.substring(1)} Palace',
      imageUrl: imageUrl,
      category: category,
      rating: 4.0 + (category.length % 10) / 10,
      latitude: 48.8566 + (category.length % 5) * 0.01, // Simulated lat
      longitude: 2.3522 + (category.length % 7) * 0.01, // Simulated lng
      address: '${10 + category.length} Foodie Street, ${category[0].toUpperCase()}${category.substring(1)} District',
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, category, rating, latitude, longitude, address];
}
