import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/api_client.dart';

final authServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthService(apiClient.dio, apiClient);
});

class AuthService {
  final Dio _dio;
  final ApiClient _apiClient;
  final _storage = const FlutterSecureStorage();

  AuthService(this._dio, this._apiClient);

  Future<String?> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
        'device_name': 'mobile_app',
      });
      
      // Assuming the API returns { "token": "..." } or { "data": { "token": "..." } }
      // Based on standard Sanctum, it usually returns the token directly or in a wrapper.
      // I'll assume it returns 'token' or 'access_token'.
      final data = response.data;
      final token = data['token'] ?? data['access_token'];
      
      if (token != null) {
        await _storage.write(key: 'auth_token', value: token);
        _apiClient.setToken(token);
        return token;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'device_name': 'mobile_app',
      });
      
      final data = response.data;
      final token = data['token'] ?? data['access_token'];
      
      if (token != null) {
        await _storage.write(key: 'auth_token', value: token);
        _apiClient.setToken(token);
        return token;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post('/logout');
    } catch (e) {
      // Ignore logout errors
    } finally {
      await _storage.delete(key: 'auth_token');
      _apiClient.clearToken();
    }
  }
  
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
}
