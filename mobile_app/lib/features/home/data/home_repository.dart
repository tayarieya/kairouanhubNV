import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api_client.dart';
import '../../../models/service_model.dart';

// Repository to fetch data from API
class HomeRepository {
  final Dio _dio;

  HomeRepository(this._dio);

  Future<List<ServiceModel>> getFeaturedServices() async {
    try {
      final response = await _dio.get('/home');
      final responseBody = response.data;
      
      if (responseBody['status'] == 'success') {
        final List<dynamic> servicesJson = responseBody['data']['featured_services'];
        return servicesJson.map((json) => ServiceModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      // Fallback to empty list or handle error
      return [];
    }
  }
}

final homeRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return HomeRepository(apiClient.dio);
});
