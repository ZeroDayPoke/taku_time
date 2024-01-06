import 'package:flutter/material.dart';
import 'package:taku_time/models/user_preferences_builder.dart';
import 'package:taku_time/models/block.dart';
import 'package:taku_time/services/block_allocators.dart';
import 'package:taku_time/utils/schedule_validator.dart';
import 'package:taku_time/models/user_preferences.dart';
import 'package:taku_time/models/schedule.dart';
import 'package:taku_time/repositories/schedule_repository.dart';

class ScheduleService {
  final ScheduleRepository scheduleRepository;
  // late final ScheduleValidator scheduleValidator;

  ScheduleService(this.scheduleRepository) {
    // scheduleValidator = ScheduleValidator(userPreferencesBuilder);
  }

  Future<Schedule?> getCurrentActiveSchedule() async {
    try {
      return await scheduleRepository.getCurrentActiveSchedule();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  List<String> get daysOfWeek => [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
}

int max(int a, int b) => (a > b) ? a : b;
