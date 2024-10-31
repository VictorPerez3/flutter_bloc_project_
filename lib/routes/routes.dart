import 'package:go_router/go_router.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/details_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailsScreen(id: id);
      },
    ),
  ],
  redirect: (context, state) {
    final location = state.uri.toString();
    if (location.contains('/.well-known/home')) {
      return '/home';
    }
    if (location.contains('/.well-known/details')) {
      final id = location.split('/').last;
      return '/details/$id';
    }
    return null;
  },
);
