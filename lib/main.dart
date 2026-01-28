import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_flutter/core/theme/app_theme.dart';

// Services
import 'package:exam_flutter/features/authentication/services/local_data_source.dart';
import 'package:exam_flutter/features/authentication/services/auth_repository.dart';
import 'package:exam_flutter/features/authentication/services/auth_service.dart';
import 'package:exam_flutter/features/food/services/api_service.dart';
import 'package:exam_flutter/features/location/services/location_service.dart';

// Providers
import 'package:exam_flutter/features/authentication/providers/auth_provider.dart';
import 'package:exam_flutter/features/food/providers/restaurant_provider.dart';
import 'package:exam_flutter/features/food/providers/food_provider.dart';
import 'package:exam_flutter/features/cart/providers/cart_provider.dart';
import 'package:exam_flutter/features/favorites/providers/favorites_provider.dart';
import 'package:exam_flutter/features/orders/providers/order_provider.dart';
import 'package:exam_flutter/features/location/providers/location_provider.dart';

// Screens
import 'package:exam_flutter/features/welcome/screens/welcome_screen.dart';
import 'package:exam_flutter/features/authentication/screens/sign_in_screen.dart';
import 'package:exam_flutter/features/authentication/screens/sign_up_screen.dart';
import 'package:exam_flutter/features/authentication/screens/forgot_password_screen.dart';
import 'package:exam_flutter/features/main_shell/screens/main_shell.dart';
import 'package:exam_flutter/features/food/screens/food_list_page.dart';
import 'package:exam_flutter/features/favorites/screens/favorites_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    // Services
    final localDataSource = LocalDataSource(prefs);
    final authRepository = AuthRepository(localDataSource);
    final authService = AuthService(authRepository);
    final apiService = ApiService();
    final locationService = LocationService();
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authService)),
        ChangeNotifierProvider(create: (_) => RestaurantProvider(apiService)),
        ChangeNotifierProvider(create: (_) => FoodProvider(apiService)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider(prefs)),
        ChangeNotifierProvider(create: (_) => OrderProvider(prefs)),
        ChangeNotifierProvider(create: (_) => LocationProvider(locationService)),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            title: 'Food Delivery',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: authProvider.isAuthenticated ? '/home' : '/',
            routes: {
              '/': (context) => const WelcomeScreen(),
              '/signin': (context) => const SignInScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/forgot-password': (context) => const ForgotPasswordScreen(),
              '/home': (context) => const MainShell(),
              '/food-list': (context) => const FoodListPage(),
              '/favorites': (context) => const FavoritesPage(),
            },
          );
        },
      ),
    );
  }
}
