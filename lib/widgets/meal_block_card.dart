import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_slider.dart';
import 'setting_switch.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';

class MealBlockCard extends StatelessWidget {
  const MealBlockCard({Key? key}) : super(key: key);

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

          final bool isFasting =
              preferencesBuilder.getValueForKey('isFasting') as bool;
          final int mealDuration =
              preferencesBuilder.getValueForKey('defaultMealDuration') as int;
          final int totalTime = mealDuration * (isFasting ? 10 : 14);

          return Card(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Meal Settings'),
                    subtitle: Text(
                        'Total time: $totalTime mins w/ isFasting: $isFasting'),
                  ),
                  SettingSwitch(
                    title: 'Is Fasting',
                    keyName: 'isFasting',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingSlider(
                    title: 'Default Meal Duration',
                    min: 15,
                    max: 120,
                    divisions: 12,
                    keyName: 'defaultMealDuration',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingSlider(
                    title: 'Meal Time Hour',
                    min: 0,
                    max: 23,
                    divisions: 23,
                    keyName: 'mealTimeHour',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingSlider(
                    title: 'Meal Time Minute',
                    min: 0,
                    max: 59,
                    divisions: 59,
                    keyName: 'mealTimeMinute',
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
