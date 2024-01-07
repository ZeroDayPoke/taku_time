import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../models/user_preferences_builder.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final String keyName;
  final UserPreferencesBuilder preferencesBuilder;

  const SettingSwitch({
    Key? key,
    required this.title,
    required this.keyName,
    required this.preferencesBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = preferencesBuilder.getValueForKey(keyName) as bool;

    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) {
        BlocProvider.of<UserPreferencesBuilderBloc>(context).add(
          UpdateUserPreference(key: keyName, value: newValue),
        );
      },
    );
  }
}
