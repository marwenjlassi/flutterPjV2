import 'package:email_validator/email_validator.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';

/// Form validation utilities
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  /// Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required';
    }
    
    if (!EmailValidator.validate(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < AppConstants.passwordMinLength) {
      return 'Password must be at least ${AppConstants.passwordMinLength} characters';
    }
    
    // Check for at least one letter and one number
    final hasLetter = value.contains(RegExp(r'[a-zA-Z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    
    if (!hasLetter || !hasDigit) {
      return 'Password must contain both letters and numbers';
    }
    
    return null;
  }

  /// Validate password confirmation
  static String? validatePasswordConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Validate full name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    
    if (value.trim().length < AppConstants.nameMinLength) {
      return 'Name must be at least ${AppConstants.nameMinLength} characters';
    }
    
    // Check if name contains only letters and spaces
    if (!value.trim().contains(RegExp(r'^[a-zA-ZÀ-ÿ\s]+$'))) {
      return 'Name can only contain letters';
    }
    
    return null;
  }

  /// Validate phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove spaces and special characters
    final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    if (cleanPhone.length < AppConstants.phoneMinLength) {
      return 'Phone number must be at least ${AppConstants.phoneMinLength} digits';
    }
    
    // Check if phone contains only digits
    if (!cleanPhone.contains(RegExp(r'^[0-9]+$'))) {
      return 'Phone number can only contain digits';
    }
    
    return null;
  }

  /// Check password strength (returns 0-100)
  static int getPasswordStrength(String password) {
    if (password.isEmpty) return 0;
    
    int strength = 0;
    
    // Length check
    if (password.length >= 6) strength += 20;
    if (password.length >= 8) strength += 10;
    if (password.length >= 12) strength += 10;
    
    // Contains lowercase
    if (password.contains(RegExp(r'[a-z]'))) strength += 15;
    
    // Contains uppercase
    if (password.contains(RegExp(r'[A-Z]'))) strength += 15;
    
    // Contains digits
    if (password.contains(RegExp(r'[0-9]'))) strength += 15;
    
    // Contains special characters
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 15;
    
    return strength.clamp(0, 100);
  }

  /// Get password strength label
  static String getPasswordStrengthLabel(int strength) {
    if (strength < 30) return 'Weak';
    if (strength < 60) return 'Fair';
    if (strength < 80) return 'Good';
    return 'Strong';
  }

  /// Get password strength color
  static String getPasswordStrengthColor(int strength) {
    if (strength < 30) return 'error';
    if (strength < 60) return 'warning';
    if (strength < 80) return 'success';
    return 'excellent';
  }
}
