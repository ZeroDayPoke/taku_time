import 'package:flutter_bloc/flutter_bloc.dart';
import 'schedule_event.dart';
import 'schedule_state.dart';
import '../services/schedule_service.dart';
import '../bloc/block_bloc.dart';
import '../bloc/block_event.dart';
import '../bloc/block_state.dart';
import '../bloc/user_preferences_bloc.dart';
import '../bloc/user_preferences_event.dart';
import '../bloc/user_preferences_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final BlockBloc blockBloc;
  final UserPreferencesBloc userPreferencesBloc;
  final ScheduleService scheduleService;

  ScheduleBloc({
    required this.blockBloc,
    required this.userPreferencesBloc,
    required this.scheduleService,
  }) : super(ScheduleInitial()) {
    on<LoadSchedule>(_onLoadSchedule);
    on<UpdateSchedule>(_onUpdateSchedule);
  }

  void _onLoadSchedule(LoadSchedule event, Emitter<ScheduleState> emit) async {
    blockBloc.add(LoadBlocks());
    userPreferencesBloc.add(LoadUserPreferences());

    try {
      final blockState = await blockBloc.stream
          .firstWhere((state) => state is BlockLoadSuccess);
      final userPreferencesState = await userPreferencesBloc.stream
          .firstWhere((state) => state is UserPreferencesLoaded);

      if (blockState is BlockLoadSuccess &&
          userPreferencesState is UserPreferencesLoaded) {
        final blocks = blockState.blocks;
        final userPreferences = userPreferencesState.preferences;

        final schedule =
            scheduleService.generateWeeklyPlan(userPreferences, blocks);
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
      // Fetch the current list of blocks from the BlockBloc
      final blockState = await blockBloc.stream
          .firstWhere((state) => state is BlockLoadSuccess);

      if (blockState is BlockLoadSuccess) {
        var schedule = scheduleService.generateWeeklyPlan(
            event.preferences, blockState.blocks);
        emit(ScheduleLoadSuccess(schedule));
      } else {
        emit(ScheduleLoadFailure());
      }
    } catch (_) {
      emit(ScheduleLoadFailure());
    }
  }
}
