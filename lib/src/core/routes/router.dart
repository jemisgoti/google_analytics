// GoRouter configuration
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/src/features/analytics/presentation/pages/dashboard.dart';
import 'package:test_app/src/features/analytics/presentation/pages/login_screen.dart';
import 'package:test_app/src/features/analytics/presentation/pages/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: SplashScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: LoginScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: Dashboard.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const Dashboard(),
      ),
    ],
  );
}
