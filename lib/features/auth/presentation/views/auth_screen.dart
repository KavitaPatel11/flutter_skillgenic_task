import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/core/constants/app_colors.dart';
import 'package:flutter_task_skillgenic/core/widgets/primary_button.dart';
import 'package:flutter_task_skillgenic/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';





import '../widgets/country_picker_field.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFFFE7D6), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  const Icon(Icons.task_alt, color: AppColors.primary, size: 40),
                  const SizedBox(height: 8),
                  const Text(
                    "TO-DO",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.arrow_back),
                            const SizedBox(width: 8),
                            const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Already have an account? "),
                            TextButton(
                              onPressed: () {}, // go to login
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const CustomTextField(label: "Full Name", hint: "John Doe"),
                        const SizedBox(height: 16),
                        const CustomTextField(
                            label: "Email", hint: "JohnDoe@gmail.com"),
                        const SizedBox(height: 16),
                        const CustomTextField(
                          label: "Date of birth",
                          hint: "18/03/2024",
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        const SizedBox(height: 16),
                        const CountryPickerField(),
                        const SizedBox(height: 16),
                        const CustomTextField(
                          label: "Set Password",
                          hint: "********",
                          obscure: true,
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: "Register",
                          onPressed: () {
                             context.go('/home');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
