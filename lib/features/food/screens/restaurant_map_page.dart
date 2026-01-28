import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/providers/restaurant_provider.dart';
import 'package:exam_flutter/features/food/models/restaurant_model.dart';

class RestaurantMapPage extends StatelessWidget {
  const RestaurantMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Locations'),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Simulated Map Background
              Container(
                color: Colors.grey[200],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, size: 100, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Interactive Map View',
                        style: TextStyle(fontSize: 20, color: Colors.grey[600], fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Showing ${provider.restaurants.length} restaurants near you',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ),

              // Simulated Markers
              ...provider.restaurants.map((restaurant) {
                // Randomly position markers for simulation
                final top = 100.0 + (restaurant.id.hashCode % 400);
                final left = 50.0 + (restaurant.id.hashCode % 300);

                return Positioned(
                  top: top,
                  left: left,
                  child: GestureDetector(
                    onTap: () => _showRestaurantInfo(context, restaurant),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
                          ),
                          child: Text(
                            restaurant.name,
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.location_on, color: AppConstants.primaryOrange, size: 30),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }

  void _showRestaurantInfo(BuildContext context, RestaurantModel restaurant) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: restaurant.imageUrl.startsWith('assets/')
                      ? Image.asset(restaurant.imageUrl, width: 80, height: 80, fit: BoxFit.cover)
                      : Image.network(restaurant.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(restaurant.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(restaurant.category, style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' ${restaurant.rating.toStringAsFixed(1)}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/food-list', arguments: restaurant);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('VIEW MENU'),
            ),
          ],
        ),
      ),
    );
  }
}
