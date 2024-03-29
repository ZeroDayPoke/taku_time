import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_slider.dart';
import 'settings_number_picker.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';

class RestBlockCard extends StatelessWidget {
  const RestBlockCard({Key? key}) : super(key: key);

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

          final int restDuration =
              preferencesBuilder.getValueForKey('defaultRestDuration') as int;
          final int totalSleepTime = restDuration * 7;

          return Card(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Rest Settings'),
                    subtitle: Text('Total sleep time: $totalSleepTime mins'),
                  ),
                  SettingSlider(
                    title: 'Default Rest Duration',
                    min: 0,
                    max: 800,
                    divisions: 60,
                    keyName: 'defaultRestDuration',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingNumberPicker(
                    title: 'Sleep Time Hour',
                    keyName: 'sleepTimeHour',
                    preferencesBuilder: preferencesBuilder,
                  ),
                  SettingNumberPicker(
                    title: 'Sleep Time Minute',
                    keyName: 'sleepTimeMinute',
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
