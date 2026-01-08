import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/services/presentation/screens/service_details_screen.dart';
import '../features/requests/presentation/screens/requests_list_screen.dart';
import '../features/requests/presentation/screens/create_request_screen.dart';
import '../features/requests/presentation/screens/request_details_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/requests/data/models/request_models.dart';
import '../features/home/presentation/screens/main_screen.dart';
import '../features/events/presentation/screens/events_screen.dart';
import '../features/favorites/presentation/screens/favorites_screen.dart';
import 'webview_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
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
        builder: (context, state) => const MainScreen(),
        routes: [
          GoRoute(
            path: 'service/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ServiceDetailsScreen(serviceId: id);
            },
          ),
          GoRoute(
            path: 'events',
            builder: (context, state) => const EventsScreen(),
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
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
