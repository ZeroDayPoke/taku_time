import 'package:equatable/equatable.dart';

abstract class UserPreferencesBuilderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserPreferencesBuilder extends UserPreferencesBuilderEvent {}

class UpdateUserPreference<T> extends UserPreferencesBuilderEvent {
  final String key;
  final T value;

  UpdateUserPreference({required this.key, required this.value});

  @override
  List<Object> get props => [key, value ?? ''];
}

class ResetUserPreferences extends UserPreferencesBuilderEvent {}

class SaveUserPreferences extends UserPreferencesBuilderEvent {}
