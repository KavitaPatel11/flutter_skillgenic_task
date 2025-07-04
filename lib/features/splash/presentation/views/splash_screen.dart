import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_task_skillgenic/core/constants/static_assets.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger navigation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/onboarding'); // ✅ use go_router route name
      });
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight, // 👈 Top-Right
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 245, 140, 70),
              Color(0xFFEB5E00),
              Color.fromARGB(255, 245, 140, 70),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Center(
            child: Image.asset(StaticAssets.splashLogo),
          ),
        ),
      ),
    );
  }
}
