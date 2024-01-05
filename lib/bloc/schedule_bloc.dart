import 'package:flutter_bloc/flutter_bloc.dart';
import 'schedule_event.dart';
import 'schedule_state.dart';
import '../services/schedule_service.dart';
import '../bloc/block_bloc.dart';
import '../bloc/block_event.dart';
import '../bloc/block_state.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../bloc/user_preferences_builder_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final BlockBloc blockBloc;
  final UserPreferencesBuilderBloc userPreferencesBuilderBloc;
  final ScheduleService scheduleService;

  ScheduleBloc({
    required this.blockBloc,
    required this.userPreferencesBuilderBloc,
    required this.scheduleService,
  }) : super(ScheduleInitial()) {
    on<LoadSchedule>(_onLoadSchedule);
    on<UpdateSchedule>(_onUpdateSchedule);
  }

  void _onLoadSchedule(LoadSchedule event, Emitter<ScheduleState> emit) async {
    blockBloc.add(LoadBlocks());
    userPreferencesBuilderBloc.add(LoadUserPreferencesBuilder());

    try {
      final blockState = await blockBloc.stream
          .firstWhere((state) => state is BlockLoadSuccess);
      final userPreferencesState = await userPreferencesBuilderBloc.stream
          .firstWhere((state) => state is UserPreferencesBuilderLoaded);

      if (blockState is BlockLoadSuccess &&
          userPreferencesState is UserPreferencesBuilderLoaded) {
        final blocks = blockState.blocks;

        final schedule = scheduleService.generateWeeklyPlan(blocks);
        emit(ScheduleLoadSuccess(schedule));
      } else {
        emit(ScheduleLoadFailure());
      }
    } catch (error) {
      emit(ScheduleLoadFailure());
    }
  }

  void _onUpdateSchedule(
      UpdateSchedule event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoadInProgress());
    try {
      final blockState = await blockBloc.stream
          .firstWhere((state) => state is BlockLoadSuccess);

      if (blockState is BlockLoadSuccess) {
        var schedule = scheduleService.generateWeeklyPlan(blockState.blocks);
        emit(ScheduleLoadSuccess(schedule));
      } else {
        emit(ScheduleLoadFailure());
      }
    } catch (_) {
      emit(ScheduleLoadFailure());
    }
  }
}
