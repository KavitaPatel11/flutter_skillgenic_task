import 'package:flutter/material.dart';
import 'package:flutter_task_skillgenic/core/constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
                'assets/images/profile.png'), // Replace with your image asset
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Marketing Manager',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          const Divider(),
          _buildSettingsOption(
            icon: Icons.edit,
            title: 'Edit Profile',
            onTap: () {},
          ),
          _buildSettingsOption(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {},
          ),
          _buildSettingsOption(
            icon: Icons.logout,
            title: 'Log out',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
