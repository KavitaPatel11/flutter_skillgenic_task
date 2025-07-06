import 'package:flutter/material.dart';
import 'package:flutter_task_skillgenic/features/auth/auth_provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authViewModelProvider).value;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Gradient Header
          Container(
            width: double.infinity,
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFD8BB), Color(0xFFFF7914)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const SizedBox(),
          ),

          // Profile Image with edit button
          Transform.translate(
            offset: const Offset(0, -60),
            child: const Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Name and Title (from Firestore)
          Text(
            user.name ?? "John Doe",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email ?? "example@email.com",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            "Phone: ${user.phone ?? 'N/A'}",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 30),

          const _ProfileOption(
            icon: Icons.edit,
            text: "Edit Profile",
          ),
          const _ProfileOption(
            icon: Icons.lock_outline,
            text: "Change Password",
          ),
_ProfileOption(
  icon: Icons.logout,
  text: "Log out",
  iconColor: Colors.red,
  onTab: () async {
    // Call logout
    await ref.read(authViewModelProvider.notifier).logout();

    // Delay navigation safely to next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go('/login'); // Navigate to login page
      }
    });
  },
),


        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback? onTab;

  const _ProfileOption(
      {required this.icon,
      required this.text,
      this.iconColor = Colors.orange,
      this.onTab});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTab, // TODO: handle tap
    );
  }
}
