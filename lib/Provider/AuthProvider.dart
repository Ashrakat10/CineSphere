import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:CineSphere/Service/FirebaseAuthService.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  Future<bool> signUp({required String email, required String password}) async {
    _setLoading(true);
    _errorMessage = '';

    try {
      final result = await _authService.signUp(
        email: email,
        password: password,
      );
      _user = result.user;
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e.code);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _setLoading(true);
    _errorMessage = '';

    try {
      final result = await _authService.logIn(email: email, password: password);
      _user = result.user;
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e.code);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authService.logOut();
      _user = null;
    } catch (e) {
      _errorMessage = 'Logout failed';
    } finally {
      _setLoading(false);
    }
  }

  void checkCurrentUser() {
    _user = _authService.currentUser;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered';

      case 'invalid-email':
        return 'Please enter a valid email';

      case 'weak-password':
        return 'Password is too weak';

      case 'user-not-found':
        return 'No account found with this email';

      case 'wrong-password':
        return 'Incorrect email or password';

      case 'invalid-credential':
        return 'Incorrect email or password';

      case 'network-request-failed':
        return 'Please check your internet connection';

      default:
        return 'Something went wrong. Please try again';
    }
  }
}
