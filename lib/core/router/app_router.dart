
import 'package:flutter_task_skillgenic/features/auth/presentation/views/auth_screen.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/views/add_todo_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/views/splash_screen.dart';


// Splash
// Onboarding
import '../../features/onboarding/presentation/views/onboarding_screen.dart';
// Auth
import '../../features/auth/presentation/views/login_screen.dart';
// Home
import '../../features/home/presentation/views/home_screen.dart';

// Calendar
import '../../features/calendar/presentation/views/calendar_screen.dart';
// Search
import '../../features/search/presentation/views/search_screen.dart';
// Settings
import '../../features/settings/presentation/views/settings_screen.dart';
// Notifications
import '../../features/notifications/presentation/views/notifications_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
     GoRoute(
      path: '/signup',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
 
       GoRoute(
      path: '/add-task',
      builder: (context, state) => const AddTodoSheet(),
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
);
