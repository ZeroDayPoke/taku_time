import 'package:taku_time/models/user_preferences_builder.dart';

abstract class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {}

class UpdateSchedule extends ScheduleEvent {
  final UserPreferencesBuilder userPreferencesBuilder;

  UpdateSchedule(this.userPreferencesBuilder);
}
