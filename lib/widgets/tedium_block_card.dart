import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_slider.dart';
import 'setting_switch.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';

class TediumBlockCard extends StatelessWidget {
  const TediumBlockCard({Key? key}) : super(key: key);

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
              preferencesBuilder.getValueForKey('doTedium') as bool;
          final int duration =
              preferencesBuilder.getValueForKey('defaultTediumDuration') as int;
          final int totalTime = isEnabled ? duration * 7 : 0;

          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Tedium Settings'),
                  subtitle:
                      isEnabled ? Text('Total time: $totalTime mins') : null,
                ),
                SettingSwitch(
                  title: 'Enable Tedium',
                  keyName: 'doTedium',
                  preferencesBuilder: preferencesBuilder,
                ),
                SettingSlider(
                  title: 'Default Tedium Duration',
                  min: 30,
                  max: 120,
                  divisions: 10,
                  keyName: 'defaultTediumDuration',
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
