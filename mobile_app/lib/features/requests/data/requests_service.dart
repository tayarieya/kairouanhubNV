import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api_client.dart';
import 'models/request_models.dart';

final requestsServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return RequestsService(apiClient);
});

class RequestsService {
  final ApiClient _apiClient;

  RequestsService(this._apiClient);

  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.dio.get('/categories');
      final data = response.data['data'] as List;
      return data.map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Service>> getServices() async {
    try {
      final response = await _apiClient.dio.get('/services');
      final data = response.data['data'] as List;
      return data.map((e) => Service.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<JobRequest>> getMyRequests() async {
    try {
      final response = await _apiClient.dio.get('/requests');
      final data = response.data['data'] as List;
      return data.map((e) => JobRequest.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createRequest({
    required int categoryId,
    required int serviceId,
    required String details,
    required String city,
    required String scheduledDate,
  }) async {
    try {
      await _apiClient.dio.post('/requests', data: {
        'category_id': categoryId,
        'service_id': serviceId,
        'details': details,
        'city': city,
        'scheduled_date': scheduledDate,
      });
    } catch (e) {
      rethrow;
    }
  }
}
