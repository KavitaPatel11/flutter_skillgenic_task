import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/settings_viewmodel.dart';

final settingsViewModelProvider = StateNotifierProvider<SettingsViewModel, String>((ref) {
  return SettingsViewModel();
});
