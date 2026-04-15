import 'package:flutter/material.dart';
import 'package:laundry_app/features/auth/domain/models/user_model.dart';
import 'package:laundry_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:laundry_app/core/services/api_services.dart';

class ProfileProvider with ChangeNotifier {
  final AuthRepositoryImpl _repository;

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ProfileProvider()
      : _repository = AuthRepositoryImpl(apiService: MockApiService()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _repository.getCurrentUser();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(User updatedUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Update via repo or direct
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
