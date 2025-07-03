import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/calendar_viewmodel.dart';

final calendarViewModelProvider = StateNotifierProvider<CalendarViewModel, String>((ref) {
  return CalendarViewModel();
});
