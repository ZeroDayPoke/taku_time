import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_slider.dart';
import 'setting_switch.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';

class RelaxBlockCard extends StatelessWidget {
  final String activityName;
  final String durationKeyName;
  final String enableKeyName;
  final String weeklySessionsKeyName;

  const RelaxBlockCard({
    Key? key,
    required this.activityName,
    required this.durationKeyName,
    required this.enableKeyName,
    required this.weeklySessionsKeyName,
  }) : super(key: key);

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

          final bool isEnabled =
              preferencesBuilder.getValueForKey(enableKeyName) as bool;
          final int duration =
              preferencesBuilder.getValueForKey(durationKeyName) as int;
          final int sessions =
              preferencesBuilder.getValueForKey(weeklySessionsKeyName) as int;
          final int totalTime = isEnabled ? duration * sessions : 0;

          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('$activityName Settings'),
                  subtitle:
                      isEnabled ? Text('Total time: $totalTime mins') : null,
                ),
                SettingSlider(
                  title: '$activityName Duration',
                  min: 0,
                  max: 120,
                  divisions: 12,
                  keyName: durationKeyName,
                  preferencesBuilder: preferencesBuilder,
                ),
                SettingSlider(
                  title: 'Weekly $activityName Sessions',
                  min: 0,
                  max: 20,
                  divisions: 7,
                  keyName: weeklySessionsKeyName,
                  preferencesBuilder: preferencesBuilder,
                ),
                SettingSwitch(
                  title: 'Enable $activityName',
                  keyName: enableKeyName,
                  preferencesBuilder: preferencesBuilder,
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
