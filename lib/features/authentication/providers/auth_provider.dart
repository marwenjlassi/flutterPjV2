import 'package:flutter/foundation.dart';
import 'package:exam_flutter/features/authentication/models/user_model.dart';
import 'package:exam_flutter/features/authentication/services/auth_service.dart';

/// Authentication provider for state management
class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService) {
    _checkAuthStatus();
  }

  // State variables
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Check authentication status on app start
  Future<void> _checkAuthStatus() async {
    try {
      _setLoading(true);
      
      final user = await _authService.getCurrentUser();
      
      if (user != null) {
        _currentUser = user;
        _isAuthenticated = true;
      }
    } catch (e) {
      _isAuthenticated = false;
      _currentUser = null;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign up user
  Future<bool> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      clearError();
      _setLoading(true);

      final user = await _authService.registerUser(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      // Do not auto login after registration
      // _currentUser = user;
      // _isAuthenticated = true;

      // Do not authenticate yet, let user sign in manually
      // await _authService.logoutUser();
      // await _authService.authenticateUser(
      //   email: email,
      //   password: password,
      // );

      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
      return false;
    }
  }

  /// Sign in user
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      clearError();
      _setLoading(true);

      final user = await _authService.authenticateUser(
        email: email,
        password: password,
      );

      _currentUser = user;
      _isAuthenticated = true;

      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
      return false;
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    try {
      _setLoading(true);

      await _authService.logoutUser();

      _currentUser = null;
      _isAuthenticated = false;
      _errorMessage = null;

      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
    }
  }

  /// Reset password
  Future<bool> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      clearError();
      _setLoading(true);

      // Check if email exists
      final emailExists = await _authService.emailExists(email);

      if (!emailExists) {
        _setError('No account found with this email');
        _setLoading(false);
        return false;
      }

      final success = await _authService.resetPassword(
        email: email,
        newPassword: newPassword,
      );

      _setLoading(false);
      
      if (success) {
        notifyListeners();
      }
      
      return success;
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
      return false;
    }
  }

  /// Check if email already exists
  Future<bool> checkEmailExists(String email) async {
    try {
      return await _authService.emailExists(email);
    } catch (e) {
      return false;
    }
  }
}
