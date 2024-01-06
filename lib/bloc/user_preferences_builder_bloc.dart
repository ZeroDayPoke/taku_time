import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_preferences_builder_event.dart';
import 'user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';
import '../services/preferences_service.dart';
import 'package:flutter/foundation.dart';

class UserPreferencesBuilderBloc
    extends Bloc<UserPreferencesBuilderEvent, UserPreferencesBuilderState> {
  final PreferencesService _preferencesService;
  UserPreferencesBuilder? _currentBuilder;

  UserPreferencesBuilderBloc({PreferencesService? preferencesService})
      : _preferencesService = preferencesService ?? PreferencesService(),
        super(UserPreferencesBuilderInitial()) {
    on<LoadUserPreferencesBuilder>(_onLoadUserPreferencesBuilder);
    on<UpdateUserPreference>(_onUpdateUserPreference);
    on<ResetUserPreferences>(_onResetUserPreferences);
    on<SaveUserPreferences>(_onSaveUserPreferences);

    add(LoadUserPreferencesBuilder());
  }

  void _onLoadUserPreferencesBuilder(
    LoadUserPreferencesBuilder event,
    Emitter<UserPreferencesBuilderState> emit,
  ) async {
    debugPrint('Processing LoadUserPreferencesBuilder Event');
    try {
      final prefs = await _preferencesService.loadPreferences();
      _currentBuilder = UserPreferencesBuilder.fromUserPreferences(prefs);
      debugPrint('Loaded preferences: ${_currentBuilder!.getAllPreferences()}');
      debugPrint('Emitting UserPreferencesBuilderLoaded State');
      emit(UserPreferencesBuilderLoaded(_currentBuilder!));
    } catch (e) {
      debugPrint('Error in LoadUserPreferencesBuilder: $e');
      emit(UserPreferencesBuilderError());
    }
  }

  void _onUpdateUserPreference<T>(
    UpdateUserPreference<T> event,
    Emitter<UserPreferencesBuilderState> emit,
  ) {
    debugPrint(
        'Processing UpdateUserPreference Event for key: ${event.key}, value: ${event.value}');
    if (_currentBuilder != null) {
      var updatedBuilder =
          _currentBuilder!.updatePreference(event.key, event.value);
      emit(UserPreferencesBuilderUpdated(updatedBuilder));
    }
  }

  void _onResetUserPreferences(
    ResetUserPreferences event,
    Emitter<UserPreferencesBuilderState> emit,
  ) {
    debugPrint('Processing ResetUserPreferences Event');
    _currentBuilder = UserPreferencesBuilder.defaultBuilder();
    emit(UserPreferencesBuilderLoaded(_currentBuilder!));
    _savePreferences();
  }

  void _onSaveUserPreferences(
    SaveUserPreferences event,
    Emitter<UserPreferencesBuilderState> emit,
  ) {
    _savePreferences();
  }

  Future<void> _savePreferences() async {
    if (_currentBuilder != null) {
      try {
        await _preferencesService.savePreferences(_currentBuilder!.build());
        debugPrint('Preferences saved successfully');
      } catch (e) {
        debugPrint('Error saving preferences: $e');
      }
    }
  }
}
