import 'package:flutter/material.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope( // wrap with Riverpod
      child: MaterialApp.router(
        title: 'Task Management',
        theme: AppTheme.lightTheme,     // custom theme
        routerConfig: appRouter,        // GoRouter instance
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
