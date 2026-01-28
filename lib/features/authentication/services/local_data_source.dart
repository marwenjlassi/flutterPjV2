import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/authentication/models/user_model.dart';

/// Local data source using SharedPreferences for user data
class LocalDataSource {
  final SharedPreferences _prefs;

  LocalDataSource(this._prefs);

  /// Save a user to SharedPreferences
  Future<bool> saveUser(UserModel user) async {
    try {
      // Get all users
      final users = await getAllUsers();
      
      // Check if user already exists (by email)
      final existingIndex = users.indexWhere((u) => u.email == user.email);
      
      if (existingIndex != -1) {
        // Update existing user
        users[existingIndex] = user;
      } else {
        // Add new user
        users.add(user);
      }
      
      // Convert users to JSON strings
      final usersJson = users.map((u) => jsonEncode(u.toJson())).toList();
      
      // Save to SharedPreferences
      return await _prefs.setStringList(AppConstants.keyUsers, usersJson);
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }

  /// Get user by email
  Future<UserModel?> getUser(String email) async {
    try {
      final users = await getAllUsers();
      
      try {
        return users.firstWhere((user) => user.email == email);
      } catch (e) {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  /// Get all registered users
  Future<List<UserModel>> getAllUsers() async {
    try {
      final usersJson = _prefs.getStringList(AppConstants.keyUsers) ?? [];
      
      return usersJson
          .map((jsonStr) => UserModel.fromJson(jsonDecode(jsonStr)))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  /// Update user data
  Future<bool> updateUser(UserModel user) async {
    try {
      return await saveUser(user);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  /// Delete user by email
  Future<bool> deleteUser(String email) async {
    try {
      final users = await getAllUsers();
      
      // Remove user with matching email
      users.removeWhere((user) => user.email == email);
      
      // Convert users to JSON strings
      final usersJson = users.map((u) => jsonEncode(u.toJson())).toList();
      
      // Save to SharedPreferences
      return await _prefs.setStringList(AppConstants.keyUsers, usersJson);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  /// Save current logged in user
  Future<bool> setCurrentUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      return await _prefs.setString(AppConstants.keyCurrentUser, userJson);
    } catch (e) {
      throw Exception('Failed to set current user: $e');
    }
  }

  /// Get currently logged in user
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = _prefs.getString(AppConstants.keyCurrentUser);
      
      if (userJson == null) {
        return null;
      }
      
      return UserModel.fromJson(jsonDecode(userJson));
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  /// Clear current user session (logout)
  Future<bool> clearCurrentUser() async {
    try {
      return await _prefs.remove(AppConstants.keyCurrentUser);
    } catch (e) {
      throw Exception('Failed to clear current user: $e');
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final currentUser = await getCurrentUser();
      return currentUser != null;
    } catch (e) {
      return false;
    }
  }
}
