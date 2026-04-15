import 'package:shared_preferences/shared_preferences.dart';
import 'package:laundry_app/features/auth/domain/models/user_model.dart';
import 'package:laundry_app/core/services/api_services.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(
      String name, String email, String phone, String password);
  Future<User?> getCurrentUser();
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<User> login(String email, String password) async {
    // Mock API
    final response = await _apiService
        .post('/auth/login', {'email': email, 'password': password});

    if (response['success']) {
      final userData = response['data']['user'];
      final user = User.fromJson(userData);
      await _saveUser(user);
      return user;
    }
    throw Exception('Login failed');
  }

  @override
  Future<User> register(
      String name, String email, String phone, String password) async {
    final response = await _apiService.post('/auth/register', {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });

    if (response['success']) {
      final userData = response['data']['user'];
      final user = User.fromJson(userData);
      await _saveUser(user);
      return user;
    }
    throw Exception('Registration failed');
  }

  @override
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      final email = prefs.getString('email');
      final name = prefs.getString('name');
      if (email != null && name != null) {
        return User(
          id: prefs.getString('userId') ?? '',
          name: name,
          email: email,
          phone: prefs.getString('phone') ?? '',
        );
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('phone');
    await prefs.remove('userId');
    await _apiService.post('/auth/logout', {});
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', user.email);
    await prefs.setString('name', user.name);
    await prefs.setString('phone', user.phone);
    await prefs.setString('userId', user.id);
  }
}
