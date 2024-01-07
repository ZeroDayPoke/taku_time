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
    on<ReloadUserPreferences>(_onReloadUserPreferences);
    on<UpdateUserPreference>(_onUpdateUserPreference);
    on<ResetUserPreferences>(_onResetUserPreferences);
    on<SaveUserPreferences>(_onSaveUserPreferences);
    add(LoadUserPreferencesBuilder());
  }

  void _onLoadUserPreferencesBuilder(
    LoadUserPreferencesBuilder event,
    Emitter<UserPreferencesBuilderState> emit,
  ) async {
    await _loadAndEmitPreferences(emit);
  }

  void _onReloadUserPreferences(
    ReloadUserPreferences event,
    Emitter<UserPreferencesBuilderState> emit,
  ) async {
    await _loadAndEmitPreferences(emit);
  }

  Future<void> _loadAndEmitPreferences(
      Emitter<UserPreferencesBuilderState> emit) async {
    try {
      final prefs = await _preferencesService.loadPreferences();
      _currentBuilder = UserPreferencesBuilder.fromUserPreferences(prefs);
      emit(UserPreferencesBuilderLoaded(_currentBuilder!));
    } catch (e) {
      debugPrint('Error loading preferences: $e');
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
      _currentBuilder =
          _currentBuilder!.updatePreference(event.key, event.value);
      emit(UserPreferencesBuilderUpdated(_currentBuilder!));
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
  ) async {
    if (_currentBuilder != null) {
      await _savePreferences();
      await _loadAndEmitPreferences(emit);
    }
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
