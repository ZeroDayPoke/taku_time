import 'package:flutter_bloc/flutter_bloc.dart';
import 'schedule_builder_event.dart';
import 'schedule_builder_state.dart';
import '../services/schedule_service.dart';
import '../models/schedule_builder.dart';
import '../models/schedule.dart';
import '../bloc/block_bloc.dart';
import '../bloc/block_event.dart';

class ScheduleBuilderBloc
    extends Bloc<ScheduleBuilderEvent, ScheduleBuilderState> {
  final BlockBloc blockBloc;
  final ScheduleService scheduleService;
  final ScheduleBuilder scheduleBuilder;

  ScheduleBuilderBloc({
    required this.scheduleService,
    required this.blockBloc,
  })  : scheduleBuilder = ScheduleBuilder(),
        super(ScheduleBuilderInitial()) {
    on<StartScheduleBuilding>(_onStartScheduleBuilding);
    on<AddBlockToSchedule>(_onAddBlockToSchedule);
    on<RemoveBlockFromSchedule>(_onRemoveBlockFromSchedule);
    on<FinalizeScheduleBuilding>(_onFinalizeScheduleBuilding);
  }

  void _onStartScheduleBuilding(
      StartScheduleBuilding event, Emitter<ScheduleBuilderState> emit) async {
    try {
      final activeSchedule = await scheduleService.getCurrentActiveSchedule();
      if (activeSchedule != null) {
        scheduleBuilder.reset(activeSchedule);
        emit(ScheduleBuildingInProgress(scheduleBuilder));
        blockBloc.add(InitializeBlocks(activeSchedule.blocks));
      }
    } catch (error) {
      emit(ScheduleBuildingFailure(error.toString()));
    }
  }

  void _onAddBlockToSchedule(
      AddBlockToSchedule event, Emitter<ScheduleBuilderState> emit) {
    try {
      scheduleBuilder.addBlock(event.block);
      emit(ScheduleBuildingInProgress(scheduleBuilder));
    } catch (error) {
      emit(ScheduleBuildingFailure(error.toString()));
    }
  }

  void _onRemoveBlockFromSchedule(
      RemoveBlockFromSchedule event, Emitter<ScheduleBuilderState> emit) {
    scheduleBuilder.removeBlock(event.block);
    emit(ScheduleBuildingInProgress(scheduleBuilder));
  }

  void _onFinalizeScheduleBuilding(
      FinalizeScheduleBuilding event, Emitter<ScheduleBuilderState> emit) {
    try {
      Schedule finalizedSchedule = scheduleBuilder.build();
      emit(ScheduleBuildingComplete(finalizedSchedule));
    } catch (error) {
      emit(ScheduleBuildingFailure(error.toString()));
    }
  }
}
