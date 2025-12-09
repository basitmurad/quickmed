import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  // ==================== CONTROLLERS ====================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ==================== VALIDATION ERRORS ====================
  String? emailError;
  String? passwordError;

  // ==================== LOADING STATE ====================
  bool isLoading = false;

  // ==================== LOGIN STATE ====================
  bool isLoggedIn = false;
  String? loggedInUserEmail;

  // ==================== GETTERS ====================

  /// Get login credentials as a Map
  Map<String, dynamic> getLoginCredentials() {
    return {
      'email': emailController.text.trim(),
      'password': passwordController.text,
    };
  }

  /// Check if form has data
  bool hasData() {
    return emailController.text.trim().isNotEmpty ||
        passwordController.text.isNotEmpty;
  }

  // ==================== VALIDATION METHODS ====================

  /// Validate email and password
  bool validateCredentials() {
    bool isValid = true;

    // Email Validation
    if (emailController.text.trim().isEmpty) {
      emailError = "Email is required";
      isValid = false;
    } else if (!_isValidEmail(emailController.text.trim())) {
      emailError = "Please enter a valid email";
      isValid = false;
    } else {
      emailError = null;
    }

    // Password Validation
    if (passwordController.text.isEmpty) {
      passwordError = "Password is required";
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError = "Password must be at least 6 characters";
      isValid = false;
    } else {
      passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  // ==================== LOGIN METHOD ====================

  /// Attempt to login with current credentials
  /// Returns true if successful, false otherwise
  Future<bool> login() async {
    // Validate first
    if (!validateCredentials()) {
      return false;
    }

    try {
      // Set loading state
      isLoading = true;
      notifyListeners();

      // Get credentials
      final credentials = getLoginCredentials();

      // Simulate API call (replace with your actual API call)
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace this with actual API call
      // Example:
      // final response = await AuthService.login(
      //   email: credentials['email'],
      //   password: credentials['password'],
      // );
      //
      // if (response.success) {
      //   isLoggedIn = true;
      //   loggedInUserEmail = credentials['email'];
      //   return true;
      // } else {
      //   passwordError = response.message ?? "Login failed";
      //   return false;
      // }

      // For now, accept any email/password (REMOVE THIS IN PRODUCTION)
      // This is just for testing purposes
      isLoggedIn = true;
      loggedInUserEmail = credentials['email'];

      return true;

    } catch (e) {
      // Handle errors
      passwordError = "An error occurred. Please try again.";
      notifyListeners();
      return false;
    } finally {
      // Reset loading state
      isLoading = false;
      notifyListeners();
    }
  }

  /// Login with specific credentials (useful for testing or social login)
  Future<bool> loginWithCredentials(String email, String password) async {
    emailController.text = email;
    passwordController.text = password;
    return await login();
  }

  // ==================== LOGOUT METHOD ====================

  /// Logout the current user
  void logout() {
    isLoggedIn = false;
    loggedInUserEmail = null;
    clearForm();
    notifyListeners();
  }

  // ==================== HELPER VALIDATION METHODS ====================

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // ==================== CLEAR METHODS ====================

  /// Clear specific field error
  void clearFieldError(String fieldName) {
    switch (fieldName) {
      case 'email':
        emailError = null;
        break;
      case 'password':
        passwordError = null;
        break;
    }
    notifyListeners();
  }

  /// Clear all errors
  void clearAllErrors() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }

  /// Clear form data
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    clearAllErrors();
  }

  // ==================== DISPOSE ====================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}