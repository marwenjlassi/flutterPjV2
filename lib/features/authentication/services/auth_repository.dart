import 'package:exam_flutter/features/authentication/services/local_data_source.dart';
import 'package:exam_flutter/features/authentication/models/user_model.dart';

/// Repository for authentication data operations
class AuthRepository {
  final LocalDataSource _localDataSource;

  AuthRepository(this._localDataSource);

  /// Register a new user
  Future<UserModel> registerUser(UserModel user) async {
    try {
      // Check if user already exists
      final existingUser = await _localDataSource.getUser(user.email);
      
      if (existingUser != null) {
        throw Exception('An account with this email already exists');
      }
      
      // Save user
      final success = await _localDataSource.saveUser(user);
      
      if (!success) {
        throw Exception('Failed to register user');
      }
      
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Login user
  Future<UserModel> loginUser(String email, String password) async {
    try {
      // Get user by email
      final user = await _localDataSource.getUser(email);
      
      if (user == null) {
        throw Exception('No account found with this email');
      }
      
      // In a real app, password would be hashed and compared
      // For now, direct comparison (will be handled in service layer)
      if (user.password != password) {
        throw Exception('Incorrect password');
      }
      
      // Set as current user
      await _localDataSource.setCurrentUser(user);
      
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Logout user
  Future<void> logoutUser() async {
    try {
      await _localDataSource.clearCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  /// Get current logged in user
  Future<UserModel?> getCurrentUser() async {
    try {
      return await _localDataSource.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      return await _localDataSource.isLoggedIn();
    } catch (e) {
      return false;
    }
  }

  /// Update user password
  Future<bool> updatePassword(String email, String newPassword) async {
    try {
      final user = await _localDataSource.getUser(email);
      
      if (user == null) {
        throw Exception('User not found');
      }
      
      // Update password
      final updatedUser = user.copyWith(password: newPassword);
      
      return await _localDataSource.updateUser(updatedUser);
    } catch (e) {
      rethrow;
    }
  }

  /// Get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      return await _localDataSource.getUser(email);
    } catch (e) {
      return null;
    }
  }
}
