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

class UserPreferencesBuilderSaved extends UserPreferencesBuilderState {}

class UserPreferencesBuilderError extends UserPreferencesBuilderState {}
