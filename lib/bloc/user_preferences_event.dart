import '../models/user_preferences.dart';

abstract class UserPreferencesEvent {}

class LoadUserPreferences extends UserPreferencesEvent {}

class UpdateUserPreferences extends UserPreferencesEvent {
  final UserPreferences preferences;

  UpdateUserPreferences(this.preferences);
}
