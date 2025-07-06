import 'package:flutter/material.dart';
import 'package:flutter_task_skillgenic/features/home/home_provider.dart';
import 'package:flutter_task_skillgenic/features/home/presentation/views/main_screen.dart';
import 'package:flutter_task_skillgenic/features/home/presentation/widgets/custom_bottom_navbar.dart';
import 'package:flutter_task_skillgenic/features/notifications/data/notification_service.dart';

import '../../../calendar/presentation/views/calendar_screen.dart';
import '../../../notifications/presentation/views/notifications_screen.dart';
import '../../../settings/presentation/views/settings_screen.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';



class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MainScreen(),
    NotificationsScreen(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
@override
void initState() {
  super.initState();
  _requestNotificationPermission();
}

Future<void> _requestNotificationPermission() async {
  await NotificationService.requestNotificationPermission();
}
  @override
  Widget build(BuildContext context) {
    final connection = ref.watch(connectivityProvider); // ✅ Watch connectivity

    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          if (connection.value == ConnectivityResult.none)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: MaterialBanner(
                backgroundColor: Colors.redAccent,
                content: const Text('You’re offline'),
                actions: [Container()],
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}

