import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/favorites/providers/favorites_provider.dart';
import 'package:exam_flutter/features/food/providers/restaurant_provider.dart';
import 'package:exam_flutter/features/food/widgets/restaurant_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final restaurantProvider = context.watch<RestaurantProvider>();
    
    final favoriteRestaurants = restaurantProvider.restaurants
        .where((r) => favoritesProvider.isFavorite(r.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: favoriteRestaurants.isEmpty
          ? const Center(child: Text('No favorite restaurants yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.spacing16),
              itemCount: favoriteRestaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(restaurant: favoriteRestaurants[index]);
              },
            ),
    );
  }
}
