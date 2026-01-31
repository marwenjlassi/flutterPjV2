import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/models/food_model.dart';
import 'package:exam_flutter/features/cart/providers/cart_provider.dart';
import 'package:exam_flutter/features/food/widgets/review_dialog.dart';
import 'package:exam_flutter/features/food/providers/food_provider.dart';

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final food = ModalRoute.of(context)!.settings.arguments as FoodModel;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Beautiful Image Header
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'food_${food.id}',
                child: Image.network(
                  food.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.3),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Food Details Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacing20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          food.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ReviewDialog(
                                foodTitle: food.title,
                                onSubmit: (rating, comment) {
                                  context.read<FoodProvider>().addReview(food.id, rating, comment);
                                },
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                food.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '(Rate)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppConstants.primaryOrange,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Category and Prep Time
                  Row(
                    children: [
                      const Icon(Icons.restaurant_menu, size: 16, color: AppConstants.lightText),
                      const SizedBox(width: 6),
                      Text(
                        food.category,
                        style: const TextStyle(color: AppConstants.lightText, fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.access_time, size: 16, color: AppConstants.lightText),
                      const SizedBox(width: 6),
                      Text(
                        '${food.prepTime} min',
                        style: const TextStyle(color: AppConstants.lightText, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description Section
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    food.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppConstants.darkText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const SizedBox(height: 24),

                  // Ingredients Section
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: food.ingredients.map((ingredient) {
                      return Chip(
                        label: Text(ingredient),
                        backgroundColor: AppConstants.primaryOrange.withValues(alpha: 0.1),
                        side: BorderSide.none,
                        labelStyle: const TextStyle(color: AppConstants.primaryOrange),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Reviews Section
                  const Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (food.reviews.isEmpty)
                    const Text('No reviews yet. Be the first to rate!', style: TextStyle(color: AppConstants.lightText))
                  else
                    ...food.reviews.map((review) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.userName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        review.rating.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                review.comment,
                                style: const TextStyle(color: AppConstants.darkText),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${review.date.day}/${review.date.month}/${review.date.year}',
                                style: const TextStyle(color: AppConstants.lightText, fontSize: 12),
                              ),
                              const Divider(),
                            ],
                          ),
                        )),
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(AppConstants.spacing20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              '\$${food.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryOrange,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartProvider>().addItem(food);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${food.title} added to cart!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'ADD TO CART',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
