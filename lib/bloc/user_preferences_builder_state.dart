import 'package:equatable/equatable.dart';
import 'package:taku_time/models/user_preferences_builder.dart';

abstract class UserPreferencesBuilderState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserPreferencesBuilderInitial extends UserPreferencesBuilderState {}

class UserPreferencesBuilderLoaded extends UserPreferencesBuilderState {
  final UserPreferencesBuilder preferencesBuilder;

  UserPreferencesBuilderLoaded(this.preferencesBuilder);

  @override
  List<Object> get props => [preferencesBuilder];
}

class UserPreferencesBuilderUpdated extends UserPreferencesBuilderState {
  final UserPreferencesBuilder preferencesBuilder;

  UserPreferencesBuilderUpdated(this.preferencesBuilder);

  @override
  List<Object> get props => [preferencesBuilder];
}

class UserPreferencesBuilderError extends UserPreferencesBuilderState {}
