import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laundry_app/features/auth/domain/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      final name = prefs.getString('name');
      final phone = prefs.getString('phone');
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn && email != null && name != null) {
        _user = User(
          id: prefs.getString('userId') ?? '1',
          name: name,
          email: email,
          phone: phone ?? '',
          createdAt: DateTime.tryParse(prefs.getString('createdAt') ?? ''),
        );
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user: $e');
      // Handle error gracefully
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock authentication - in real app, call API here
      if (email == 'demo@laundry.com' && password == 'password123') {
        final prefs = await SharedPreferences.getInstance();
        
        await prefs.setString('email', email);
        await prefs.setString('name', 'Demo User');
        await prefs.setString('phone', '+1234567890');
        await prefs.setString('userId', '1');
        await prefs.setString('createdAt', DateTime.now().toIso8601String());
        await prefs.setBool('isLoggedIn', true);

        _user = User(
          id: '1',
          name: 'Demo User',
          email: email,
          phone: '+1234567890',
          createdAt: DateTime.now(),
        );
        
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print('Login error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      final prefs = await SharedPreferences.getInstance();
      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      
      await prefs.setString('email', email);
      await prefs.setString('name', name);
      await prefs.setString('phone', phone);
      await prefs.setString('userId', userId);
      await prefs.setString('createdAt', DateTime.now().toIso8601String());
      await prefs.setBool('isLoggedIn', true);

      _user = User(
        id: userId,
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );
      
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Register error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      final prefs = await SharedPreferences.getInstance();
      final userId = 'google_${DateTime.now().millisecondsSinceEpoch}';
      
      await prefs.setString('email', 'google@example.com');
      await prefs.setString('name', 'Google User');
      await prefs.setString('phone', '');
      await prefs.setString('userId', userId);
      await prefs.setString('createdAt', DateTime.now().toIso8601String());
      await prefs.setBool('isLoggedIn', true);

      _user = User(
        id: userId,
        name: 'Google User',
        email: 'google@example.com',
        phone: '',
        createdAt: DateTime.now(),
      );
      
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Google sign in error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      
      // Clear only authentication-related data
      await prefs.remove('isLoggedIn');
      await prefs.remove('email');
      await prefs.remove('userId');
      
      // Or clear everything
      // await prefs.clear();

      _user = null;
      _isAuthenticated = false;
      _isLoading = false;
      
      notifyListeners();
    } catch (e) {
      print('Logout error: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
}