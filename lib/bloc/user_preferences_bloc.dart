import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_preferences_event.dart';
import 'user_preferences_state.dart';
import '../models/user_preferences.dart';

class UserPreferencesBloc
    extends Bloc<UserPreferencesEvent, UserPreferencesState> {
  UserPreferencesBloc() : super(UserPreferencesInitial()) {
    on<LoadUserPreferences>(_onLoadUserPreferences);
    on<UpdateUserPreferences>(_onUpdateUserPreferences);
  }

  void _onLoadUserPreferences(
    LoadUserPreferences event,
    Emitter<UserPreferencesState> emit,
  ) async {
    try {
      final preferences = await UserPreferences.loadPreferences();
      emit(UserPreferencesLoaded(preferences));
    } catch (e) {
      emit(UserPreferencesError());
    }
  }

  void _onUpdateUserPreferences(
    UpdateUserPreferences event,
    Emitter<UserPreferencesState> emit,
  ) async {
    try {
      await event.preferences.savePreferences();
      emit(UserPreferencesLoaded(event.preferences));
    } catch (e) {
      emit(UserPreferencesError());
    }
  }
}
