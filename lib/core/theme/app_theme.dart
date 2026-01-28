import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';

/// Application theme configuration
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Get the main theme data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // Color scheme
      colorScheme: ColorScheme.light(
        primary: AppConstants.primaryOrange,
        secondary: const Color(0xFF2D3436),
        surface: Colors.white,
        error: AppConstants.errorRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppConstants.darkText,
        onError: Colors.white,
      ),
      
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      
      // Typography using Google Fonts
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppConstants.darkText),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppConstants.darkText),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppConstants.darkText),
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppConstants.darkText),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppConstants.darkText),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppConstants.darkText),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppConstants.darkText),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppConstants.darkText),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppConstants.darkText),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppConstants.darkText),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppConstants.darkText),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppConstants.lightText),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.primaryOrange, width: 1.5),
        ),
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryOrange,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: AppConstants.primaryOrange.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      
      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppConstants.darkText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppConstants.darkText,
        ),
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        ),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  /// Gradient for buttons and backgrounds
  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [
          AppConstants.primaryOrange,
          AppConstants.accentRed,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
