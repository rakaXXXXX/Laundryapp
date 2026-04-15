import 'package:laundry_app/features/auth/domain/models/user_model.dart';

abstract class AuthService {
  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String phone, String password);
  Future<User> googleSignIn();
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<void> saveUser(User user);
}

class MockAuthService implements AuthService {
  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (email == 'demo@laundry.com' && password == 'password') {
      return User(
        id: '1',
        name: 'Demo User',
        email: email,
        phone: '+1234567890',
      );
    }
    
    throw Exception('Invalid credentials');
  }

  @override
  Future<User> register(String name, String email, String phone, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
    );
  }

  @override
  Future<User> googleSignIn() async {
    await Future.delayed(const Duration(seconds: 2));
    
    return User(
      id: 'google_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Google User',
      email: 'google@example.com',
      phone: '',
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return null to simulate no logged in user
    return null;
  }

  @override
  Future<void> saveUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}