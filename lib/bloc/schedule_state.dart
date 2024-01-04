import '../models/block.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadInProgress extends ScheduleState {}

class ScheduleLoadSuccess extends ScheduleState {
  final Map<String, List<Block>> weeklySchedule;

  ScheduleLoadSuccess(this.weeklySchedule);
}

class ScheduleLoadFailure extends ScheduleState {}
