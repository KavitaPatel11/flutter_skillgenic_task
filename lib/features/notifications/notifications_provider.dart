import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/notifications_viewmodel.dart';

final notificationsViewModelProvider = StateNotifierProvider<NotificationsViewModel, String>((ref) {
  return NotificationsViewModel();
});
