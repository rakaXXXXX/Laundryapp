import 'dart:async';
import 'dart:convert';

abstract class ApiService {
  Future<Map<String, dynamic>> get(String endpoint);
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data);
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data);
  Future<Map<String, dynamic>> delete(String endpoint);
}

class MockApiService implements ApiService {
  @override
  Future<Map<String, dynamic>> get(String endpoint) async {
    await Future.delayed(const Duration(seconds: 1));
    
    switch (endpoint) {
      case '/services':
        return {
          'success': true,
          'data': [
            {
              'id': '1',
              'name': 'Regular Wash',
              'description': 'Standard wash & fold service',
              'price': 5.99,
            },
            {
              'id': '2',
              'name': 'Dry Cleaning',
              'description': 'Professional dry cleaning',
              'price': 12.99,
            },
          ],
        };
        
      case '/orders':
        return {
          'success': true,
          'data': [
            {
              'id': 'LAU-2024-00123',
              'serviceName': 'Regular Wash',
              'status': 2,
              'totalAmount': 28.97,
            },
          ],
        };
        
      default:
        return {
          'success': true,
          'data': null,
        };
    }
  }

  @override
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 2));
    
    switch (endpoint) {
      case '/auth/login':
        return {
          'success': true,
          'data': {
            'user': {
              'id': '1',
              'name': data['email']?.split('@').first ?? 'User',
              'email': data['email'],
              'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
            },
          },
        };
        
      case '/orders':
        return {
          'success': true,
          'data': {
            'orderId': 'LAU-${DateTime.now().millisecondsSinceEpoch}',
            'message': 'Order created successfully',
          },
        };
        
      default:
        return {
          'success': true,
          'data': null,
        };
    }
  }

  @override
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'success': true, 'data': data};
  }

  @override
  Future<Map<String, dynamic>> delete(String endpoint) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'success': true};
  }
}

class RealApiService implements ApiService {
  final String baseUrl;
  final Map<String, String> headers;

  RealApiService({required this.baseUrl}) : headers = {
    'Content-Type': 'application/json',
  };

  @override
  Future<Map<String, dynamic>> get(String endpoint) async {
    // Implement real HTTP GET request
    // using http or dio package
    throw UnimplementedError('Real API service not implemented');
  }

  @override
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    // Implement real HTTP POST request
    throw UnimplementedError('Real API service not implemented');
  }

  @override
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    // Implement real HTTP PUT request
    throw UnimplementedError('Real API service not implemented');
  }

  @override
  Future<Map<String, dynamic>> delete(String endpoint) async {
    // Implement real HTTP DELETE request
    throw UnimplementedError('Real API service not implemented');
  }
}