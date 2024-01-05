import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../bloc/user_preferences_builder_state.dart';

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
        if (state is UserPreferencesBuilderLoaded) {
          final value = state.preferencesBuilder.getValueForKey(keyName);
          return SwitchListTile(
            title: Text(title),
            value: value ?? false,
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
