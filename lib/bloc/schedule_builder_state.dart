import '../models/schedule_builder.dart';
import '../models/schedule.dart';

abstract class ScheduleBuilderState {}

class ScheduleBuilderInitial extends ScheduleBuilderState {}

class ScheduleBuildingInProgress extends ScheduleBuilderState {
  final ScheduleBuilder scheduleBuilder;
  ScheduleBuildingInProgress(this.scheduleBuilder);
}

class ScheduleBuildingComplete extends ScheduleBuilderState {
  final Schedule finalizedSchedule;
  ScheduleBuildingComplete(this.finalizedSchedule);
}

class ScheduleBuildingFailure extends ScheduleBuilderState {
  final String error;
  ScheduleBuildingFailure(this.error);
}
