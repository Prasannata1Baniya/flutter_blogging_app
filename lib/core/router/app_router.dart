import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/blog/presentation/pages/main_page.dart';
import 'auth_refresh_notifier.dart';

final _authRefreshNotifier =
AuthRefreshNotifier(FirebaseAuth.instance);

final appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: _authRefreshNotifier,

  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null;

    final isAuthPage =
        state.matchedLocation == '/login' ||
            state.matchedLocation == '/register';

    final isWelcomePage =
        state.matchedLocation == '/';

    if (!isLoggedIn && !isAuthPage && !isWelcomePage) {
      return '/login';
    }

    if (isLoggedIn && isAuthPage) {
      return '/home';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const MainPage(),
    ),
  ],
);