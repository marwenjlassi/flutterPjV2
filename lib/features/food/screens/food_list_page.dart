import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/models/restaurant_model.dart';
import 'package:exam_flutter/features/food/providers/food_provider.dart';
import 'package:exam_flutter/features/food/widgets/food_card.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final restaurant = ModalRoute.of(context)!.settings.arguments as RestaurantModel;
    context.read<FoodProvider>().fetchFoodsByCategory(restaurant.category);
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)!.settings.arguments as RestaurantModel;
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(restaurant.name),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, size: 12, color: AppConstants.primaryOrange),
                const SizedBox(width: 4),
                Text(
                  restaurant.address,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer<FoodProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          if (provider.foods.isEmpty) {
            return const Center(child: Text('No food items found.'));
          }

          return isLargeScreen
              ? GridView.builder(
                  padding: const EdgeInsets.all(AppConstants.spacing16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: provider.foods.length,
                  itemBuilder: (context, index) => FoodCard(food: provider.foods[index]),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppConstants.spacing16),
                  itemCount: provider.foods.length,
                  itemBuilder: (context, index) => FoodCard(food: provider.foods[index]),
                );
        },
      ),
    );
  }
}
