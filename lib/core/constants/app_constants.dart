import 'package:flutter/material.dart';

/// Application-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // ==================== COLORS ====================
  
  /// Primary orange color for food delivery theme
  static const Color primaryOrange = Color(0xFFFF6B35);
  
  /// Accent red color
  static const Color accentRed = Color(0xFFE63946);
  
  /// Dark text color
  static const Color darkText = Color(0xFF2D3142);
  
  /// Light text color
  static const Color lightText = Color(0xFF8B8B8B);
  
  /// Background color
  static const Color backgroundColor = Color(0xFFF8F9FA);
  
  /// Success green
  static const Color successGreen = Color(0xFF06D6A0);
  
  /// Error red
  static const Color errorRed = Color(0xFFEF476F);
  
  /// White
  static const Color white = Color(0xFFFFFFFF);

  // ==================== SPACING ====================
  
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;

  // ==================== BORDER RADIUS ====================
  
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusCircular = 100.0;

  // ==================== SHARED PREFERENCES KEYS ====================
  
  static const String keyUsers = 'users';
  static const String keyCurrentUser = 'current_user';
  static const String keyRememberMe = 'remember_me';

  // ==================== VALIDATION ====================
  
  static const int passwordMinLength = 6;
  static const int nameMinLength = 2;
  static const int phoneMinLength = 10;

  // ==================== APP INFO ====================
  
  static const String appName = 'Food Delivery';
  static const String appVersion = '1.0.0';
}
