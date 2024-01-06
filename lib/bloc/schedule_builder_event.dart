import '../models/block.dart';

abstract class ScheduleBuilderEvent {}

class StartScheduleBuilding extends ScheduleBuilderEvent {}

class AddBlockToSchedule extends ScheduleBuilderEvent {
  final Block block;
  AddBlockToSchedule(this.block);
}

class RemoveBlockFromSchedule extends ScheduleBuilderEvent {
  final Block block;
  RemoveBlockFromSchedule(this.block);
}

class FinalizeScheduleBuilding extends ScheduleBuilderEvent {}
