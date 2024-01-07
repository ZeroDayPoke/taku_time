import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_slider.dart';
import 'setting_switch.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';

class ExerciseBlockCard extends StatelessWidget {
  const ExerciseBlockCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreferencesBuilderBloc, UserPreferencesBuilderState>(
      builder: (context, state) {
        if (state is UserPreferencesBuilderLoaded ||
            state is UserPreferencesBuilderUpdated) {
          UserPreferencesBuilder preferencesBuilder;
          if (state is UserPreferencesBuilderLoaded) {
            preferencesBuilder = state.preferencesBuilder;
          } else if (state is UserPreferencesBuilderUpdated) {
            preferencesBuilder = state.preferencesBuilder;
          } else {
            return const SizedBox.shrink();
          }
          bool isExerciseEnabled =
              preferencesBuilder.getValueForKey('doExercise');
          int exerciseDuration =
              preferencesBuilder.getValueForKey('defaultExerciseDuration');
          bool isHighIntensityEnabled =
              preferencesBuilder.getValueForKey('enableHighIntensityExercise');
          int highIntensityBlocks = preferencesBuilder
              .getValueForKey('weeklyHighIntensityExerciseBlocks');

          int totalExerciseTime =
              isExerciseEnabled ? exerciseDuration * 7 * 3 : 0;
          int totalHighIntensityTime = isHighIntensityEnabled
              ? exerciseDuration * highIntensityBlocks
              : 0;

          return Card(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Exercise Settings'),
                    subtitle: Text(
                        'Total Time: ${totalExerciseTime + totalHighIntensityTime} minutes/week'),
                  ),
                  SettingSwitch(
                    title: 'Enable Exercise',
                    keyName: 'doExercise',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingSlider(
                    title: 'Default Exercise Duration',
                    min: 15,
                    max: 120,
                    divisions: 12,
                    keyName: 'defaultExerciseDuration',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingSwitch(
                    title: 'Enable High Intensity Exercise',
                    keyName: 'enableHighIntensityExercise',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingSlider(
                    title: 'Weekly High Intensity Exercise Blocks',
                    min: 0,
                    max: 4,
                    divisions: 4,
                    keyName: 'weeklyHighIntensityExerciseBlocks',
                    preferencesBuilder: preferencesBuilder,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
