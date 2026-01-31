import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/screens/home_page.dart';
import 'package:exam_flutter/features/cart/screens/cart_page.dart';
import 'package:exam_flutter/features/orders/screens/orders_page.dart';
import 'package:exam_flutter/features/authentication/screens/profile_page.dart';
import 'package:exam_flutter/features/favorites/screens/favorites_page.dart';
import 'package:exam_flutter/features/main_shell/widgets/app_drawer.dart';
import 'package:exam_flutter/features/cart/providers/cart_provider.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavoritesPage(), // Added Favorites tab
    const CartPage(),
    const OrdersPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppConstants.primaryOrange,
        unselectedItemColor: AppConstants.lightText,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Badge(
                  label: Text(cart.itemCount.toString()),
                  isLabelVisible: cart.itemCount > 0,
                  child: const Icon(Icons.shopping_cart_outlined),
                );
              },
            ),
            activeIcon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            activeIcon: Icon(Icons.local_shipping),
            label: 'Tracking',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
