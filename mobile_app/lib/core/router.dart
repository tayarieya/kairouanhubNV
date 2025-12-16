import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/services/service_details_screen.dart';
import '../features/requests/presentation/screens/requests_list_screen.dart';
import '../features/requests/presentation/screens/create_request_screen.dart';
import '../features/requests/presentation/screens/request_details_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/requests/data/models/request_models.dart';
import '../pages/main_page_view.dart'; // Import MainPageView
import 'webview_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainPageView(),
        routes: [
          GoRoute(
            path: 'service/:id',
            builder: (context, state) {
              return ServiceDetailsScreen(serviceId: state.pathParameters['id']!);
            },
          ),
          GoRoute(
            path: 'webview',
            builder: (context, state) {
              final extra = state.extra as Map<String, String>;
              return WebViewScreen(
                url: extra['url']!,
                title: extra['title']!,
              );
            },
          ),
        ],
      ),
      // Keep these accessible if needed, though MainPageView might link to them differently
      GoRoute(
        path: '/requests',
        builder: (context, state) => const RequestsListScreen(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const CreateRequestScreen(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final request = state.extra as JobRequest;
              return RequestDetailsScreen(request: request);
            },
          ),
        ],
      ),
    ],
  );
});
