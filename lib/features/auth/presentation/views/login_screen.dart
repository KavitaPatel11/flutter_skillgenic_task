import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/auth/auth_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool rememberMe = false;

Future<void> login() async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter both email and password')),
    );
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return const Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    },
  );

  try {
    await ref.read(authViewModelProvider.notifier).login(email, password);

    if (context.mounted) {
     context.pop(); // Close loading dialog
      
      /// ✅ Navigation safely after frame is drawn
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.go('/home');
        }
      });
    }
  } catch (e) {
    if (context.mounted) {
     context.pop(); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {

    final authState = ref.watch(authViewModelProvider);

    ref.listen(authViewModelProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful')),
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

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFFFE7D6), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width > 500 ? 400 : size.width * 0.95,
              ),
              child: Column(
                children: [
                  const Icon(Icons.task_alt,
                      color: Color(0xFFFF6C0A), size: 40),
                  const SizedBox(height: 8),
                  const Text(
                    "TO-DO",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6C0A),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // White card
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
                        const Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don’t have an account? "),
                            TextButton(
                              onPressed: () {
                                context.push('/signup');
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFFFF6C0A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Email Field
                        const Text(
                          "Email",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Johndoe@gmail.com',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        const Text(
                          "Password",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (val) {
                                setState(() {
                                  rememberMe = val ?? false;
                                });
                              },
                            ),
                            const Text("Remember me"),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Color(0xFFFF6C0A), fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Login Button
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF6C0A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("Or"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Google Login
                        OutlinedButton.icon(
                          onPressed: () async {
                            // final user = await ref
                            //     .read(authViewModelProvider.notifier)
                            //     .signInWithGoogle();

                            // if (user != null && context.mounted) {
                            //   context.go(
                            //       '/home'); // Navigate to home on successful login
                            // } else {
                            //   if (context.mounted) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text('Google Sign-In failed')),
                            //     );
                            //   }
                            // }
                          },
                          icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                          label: const Text("Continue with Google"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            foregroundColor: Colors.black87,
                          ),
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
