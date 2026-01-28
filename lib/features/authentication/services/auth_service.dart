import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:exam_flutter/features/authentication/models/user_model.dart';
import 'package:exam_flutter/features/authentication/services/auth_repository.dart';

/// Domain service for authentication with business logic
class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  /// Hash password using SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Register a new user
  Future<UserModel> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // Hash password
      final hashedPassword = _hashPassword(password);
      
      // Create user model
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
        email: email.trim().toLowerCase(),
        password: hashedPassword,
        phone: phone.trim(),
        createdAt: DateTime.now(),
      );
      
      // Register user through repository
      return await _repository.registerUser(user);
    } catch (e) {
      rethrow;
    }
  }

  /// Authenticate user (login)
  Future<UserModel> authenticateUser({
    required String email,
    required String password,
  }) async {
    try {
      // Hash password for comparison
      final hashedPassword = _hashPassword(password);
      
      // Authenticate through repository
      return await _repository.loginUser(
        email.trim().toLowerCase(),
        hashedPassword,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Logout user
  Future<void> logoutUser() async {
    try {
      await _repository.logoutUser();
    } catch (e) {
      rethrow;
    }
  }

  /// Get current logged in user
  Future<UserModel?> getCurrentUser() async {
    try {
      return await _repository.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      return await _repository.isLoggedIn();
    } catch (e) {
      return false;
    }
  }

  /// Reset password
  Future<bool> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      // Hash new password
      final hashedPassword = _hashPassword(newPassword);
      
      // Update password through repository
      return await _repository.updatePassword(
        email.trim().toLowerCase(),
        hashedPassword,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Verify if email exists
  Future<bool> emailExists(String email) async {
    try {
      final user = await _repository.getUserByEmail(email.trim().toLowerCase());
      return user != null;
    } catch (e) {
      return false;
    }
  }
}
