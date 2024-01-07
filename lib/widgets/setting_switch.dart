import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../bloc/user_preferences_builder_state.dart';
import '../models/user_preferences_builder.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final String keyName;

  const SettingSwitch({
    Key? key,
    required this.title,
    required this.keyName,
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
          final value = preferencesBuilder.getValueForKey(keyName);
          return SwitchListTile(
            title: Text(title),
            value: value,
            onChanged: (newValue) {
              BlocProvider.of<UserPreferencesBuilderBloc>(context).add(
                UpdateUserPreference(key: keyName, value: newValue),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
