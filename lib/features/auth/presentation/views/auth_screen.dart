import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/core/constants/app_colors.dart';
import 'package:flutter_task_skillgenic/core/widgets/primary_button.dart';
import 'package:flutter_task_skillgenic/features/auth/auth_provider.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_text_field.dart';

import '../widgets/country_picker_field.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();
  final countryController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final dob = dobController.text.trim();
    final country = countryController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final authNotifier = ref.read(authViewModelProvider.notifier);
    final userCredential = await authNotifier.signUp(email, password);

    if (userCredential != null) {
      final uid = userCredential.user?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'name': name,
          'email': email,
          'phone': phone,
          'dob': dob,
          'country': country,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authState = ref.watch(authViewModelProvider);

    ref.listen(authViewModelProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signup successful')),
            );
            context.go('/home');
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
    });

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
                  const Icon(Icons.task_alt,
                      color: AppColors.primary, size: 40),
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
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Already have an account? "),
                            TextButton(
                              onPressed: () => context.go('/login'),
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
                        CustomTextField(
                          label: "Full Name",
                          hint: "John Doe",
                          controller: nameController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: "Email",
                          hint: "JohnDoe@gmail.com",
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {
                            FocusScope.of(context)
                                .unfocus(); // Close keyboard if open

                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000), // default dob
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              dobController.text =
                                  "${pickedDate.day.toString().padLeft(2, '0')}/"
                                  "${pickedDate.month.toString().padLeft(2, '0')}/"
                                  "${pickedDate.year}";
                            }
                          },
                          child: AbsorbPointer(
                            // Prevent manual typing
                            child: CustomTextField(
                              label: "Date of birth",
                              hint: "18/03/2024",
                              controller: dobController,
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        CustomTextField(
                          label: "Phone Number",
                          hint: "9876543210",
                          controller: phoneController,
                        ),
                        // CountryPickerField(controller: countryController),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: "Set Password",
                          hint: "********",
                          obscure: true,
                          controller: passwordController,
                          suffixIcon: const Icon(Icons.visibility_off),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: "Register",
                          onPressed: register,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
