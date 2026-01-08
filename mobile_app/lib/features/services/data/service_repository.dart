import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api_client.dart';
import '../../../models/service_model.dart';

class ServiceRepository {
  final Dio _dio;

  ServiceRepository(this._dio);

  Future<List<ServiceModel>> getServices({String? category}) async {
    try {
      final response = await _dio.get('/services', queryParameters: {
        if (category != null) 'category': category,
      });
      
      final responseBody = response.data;

      if (responseBody['status'] == 'success') {
        dynamic data = responseBody['data'];
        List<dynamic> servicesJson;
        
        // Handle pagination: if data is a Map containing 'data' key, use that.
        if (data is Map && data.containsKey('data')) {
           servicesJson = data['data'];
        } else if (data is List) {
           servicesJson = data;
        } else {
           servicesJson = [];
        }

        return servicesJson.map((json) => ServiceModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

final serviceRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ServiceRepository(apiClient.dio);
});

final servicesProvider = FutureProvider<List<ServiceModel>>((ref) async {
  return ref.watch(serviceRepositoryProvider).getServices();
});
