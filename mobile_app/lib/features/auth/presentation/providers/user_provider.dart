import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_service.dart';
import '../../../../models/user_model.dart';

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  final token = await authService.getToken();
  if (token == null) return null;
  return authService.getUser();
});
