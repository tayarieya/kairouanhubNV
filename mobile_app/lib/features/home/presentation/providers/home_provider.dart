import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/home_repository.dart';

final featuredServicesProvider = FutureProvider<List<ServiceModel>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getFeaturedServices();
});
