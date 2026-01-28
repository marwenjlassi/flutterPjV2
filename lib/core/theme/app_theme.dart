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
        secondary: AppConstants.accentRed,
        surface: AppConstants.white,
        error: AppConstants.errorRed,
        onPrimary: AppConstants.white,
        onSecondary: AppConstants.white,
        onSurface: AppConstants.darkText,
        onError: AppConstants.white,
      ),
      
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      
      // Typography using Google Fonts
      textTheme: GoogleFonts.poppinsTextTheme(
        TextTheme(
          // Display styles
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppConstants.darkText,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppConstants.darkText,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppConstants.darkText,
          ),
          
          // Headline styles
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppConstants.darkText,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppConstants.darkText,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppConstants.darkText,
          ),
          
          // Title styles
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppConstants.darkText,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppConstants.darkText,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppConstants.darkText,
          ),
          
          // Body styles
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppConstants.darkText,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppConstants.darkText,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppConstants.lightText,
          ),
          
          // Label styles
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppConstants.darkText,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppConstants.darkText,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppConstants.lightText,
          ),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacing16,
          vertical: AppConstants.spacing16,
        ),
        
        // Border styles
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(
            color: AppConstants.lightText.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(
            color: AppConstants.lightText.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(
            color: AppConstants.primaryOrange,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(
            color: AppConstants.errorRed,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(
            color: AppConstants.errorRed,
            width: 2,
          ),
        ),
        
        // Label and hint styles
        labelStyle: TextStyle(
          color: AppConstants.lightText,
          fontSize: 14,
        ),
        hintStyle: TextStyle(
          color: AppConstants.lightText.withValues(alpha: 0.7),
          fontSize: 14,
        ),
        errorStyle: const TextStyle(
          color: AppConstants.errorRed,
          fontSize: 12,
        ),
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryOrange,
          foregroundColor: AppConstants.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacing24,
            vertical: AppConstants.spacing16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryOrange,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacing16,
            vertical: AppConstants.spacing8,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: AppConstants.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        ),
        margin: const EdgeInsets.all(AppConstants.spacing8),
      ),
      
      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.white,
        foregroundColor: AppConstants.darkText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppConstants.darkText,
        ),
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: AppConstants.darkText,
        size: 24,
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

  /// Background gradient for auth screens
  static LinearGradient get backgroundGradient => LinearGradient(
        colors: [
          AppConstants.backgroundColor,
          AppConstants.primaryOrange.withValues(alpha: 0.05),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
