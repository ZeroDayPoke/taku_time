import '../models/user_preferences.dart';

abstract class UserPreferencesState {}

class UserPreferencesInitial extends UserPreferencesState {}

class UserPreferencesLoaded extends UserPreferencesState {
  final UserPreferences preferences;

  UserPreferencesLoaded(this.preferences);
}

class UserPreferencesError extends UserPreferencesState {}
