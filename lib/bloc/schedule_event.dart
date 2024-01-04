import '../models/user_preferences.dart';

abstract class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {
  final UserPreferences preferences;

  LoadSchedule(this.preferences);
}

class UpdateSchedule extends ScheduleEvent {
  final UserPreferences preferences;

  UpdateSchedule(this.preferences);
}
