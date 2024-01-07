import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_slider.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';

class StressBlockCard extends StatelessWidget {
  final String activityName;
  final String durationKeyName;
  final String sessionKeyName;

  const StressBlockCard({
    Key? key,
    required this.activityName,
    required this.durationKeyName,
    required this.sessionKeyName,
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

          final int duration =
              preferencesBuilder.getValueForKey(durationKeyName) as int;
          final int sessions =
              preferencesBuilder.getValueForKey(sessionKeyName) as int;
          final int totalTime = duration * sessions * 7;

          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('$activityName Management'),
                  subtitle: Text('Total time: $totalTime mins'),
                ),
                SettingSlider(
                  title: '$activityName Session Duration',
                  min: 0,
                  max: 120,
                  divisions: 12,
                  keyName: durationKeyName,
                  preferencesBuilder: preferencesBuilder,
                ),
                SettingSlider(
                  title: 'Daily $activityName Sessions',
                  min: 0,
                  max: 7,
                  divisions: 7,
                  keyName: sessionKeyName,
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
