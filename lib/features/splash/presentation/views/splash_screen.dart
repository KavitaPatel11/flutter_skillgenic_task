import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_task_skillgenic/core/constants/static_assets.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        final isLoggedIn = FirebaseAuth.instance.currentUser != null;

        if (isLoggedIn) {
          context.go('/home'); // 🔁 Directly go to Home
        } else {
          context.go('/onboarding'); // 👈 Go to onboarding if not logged in
        }
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
