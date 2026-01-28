import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/providers/restaurant_provider.dart';
import 'package:exam_flutter/features/food/providers/food_provider.dart';
import 'package:exam_flutter/features/location/providers/location_provider.dart';
import 'package:exam_flutter/features/food/widgets/restaurant_card.dart';
import 'package:exam_flutter/features/food/widgets/popular_food_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<RestaurantProvider>().fetchRestaurants();
      context.read<FoodProvider>().fetchPopularFoods();
      context.read<LocationProvider>().updateLocation();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final restaurantProvider = context.read<RestaurantProvider>();
          final foodProvider = context.read<FoodProvider>();
          final locationProvider = context.read<LocationProvider>();
          
          await Future.wait([
            restaurantProvider.fetchRestaurants(),
            foodProvider.fetchPopularFoods(),
            locationProvider.updateLocation(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            // Custom AppBar with Location
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Deliver to', style: TextStyle(fontSize: 10, color: Colors.white70)),
                    Consumer<LocationProvider>(
                      builder: (context, location, child) {
                        return Text(
                          location.currentAddress,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
              ],
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacing16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    context.read<RestaurantProvider>().searchRestaurants(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search restaurants or cuisines...',
                    prefixIcon: const Icon(Icons.search, color: AppConstants.primaryOrange),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                      borderSide: const BorderSide(color: AppConstants.primaryOrange, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),

            // Popular Food Section
            Consumer<RestaurantProvider>(
              builder: (context, restaurantProvider, child) {
                if (restaurantProvider.searchQuery.isNotEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
                
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Popular Food',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('View All', style: TextStyle(color: AppConstants.primaryOrange)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing12),
                      SizedBox(
                        height: 220,
                        child: Consumer<FoodProvider>(
                          builder: (context, foodProvider, child) {
                            if (foodProvider.isLoading && foodProvider.popularFoods.isEmpty) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            
                            if (foodProvider.popularFoods.isEmpty) {
                              return const Center(child: Text('No popular foods available'));
                            }
                            
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
                              scrollDirection: Axis.horizontal,
                              itemCount: foodProvider.popularFoods.length,
                              itemBuilder: (context, index) {
                                return PopularFoodCard(food: foodProvider.popularFoods[index]);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
                        child: Text(
                          'Restaurants',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing12),
                    ],
                  ),
                );
              },
            ),
            
            // Restaurant List
            Consumer<RestaurantProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                }

                if (provider.error != null) {
                  return SliverFillRemaining(child: Center(child: Text('Error: ${provider.error}')));
                }

                if (provider.restaurants.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: AppConstants.lightText),
                          SizedBox(height: 16),
                          Text('No restaurants found', style: TextStyle(color: AppConstants.lightText)),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final restaurant = provider.restaurants[index];
                        return RestaurantCard(restaurant: restaurant);
                      },
                      childCount: provider.restaurants.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
