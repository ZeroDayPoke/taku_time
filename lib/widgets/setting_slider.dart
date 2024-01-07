import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../models/user_preferences_builder.dart';

class SettingSlider extends StatelessWidget {
  final String title;
  final double min;
  final double max;
  final int divisions;
  final String keyName;
  final UserPreferencesBuilder preferencesBuilder;

  const SettingSlider({
    Key? key,
    required this.title,
    required this.min,
    required this.max,
    required this.divisions,
    required this.keyName,
    required this.preferencesBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = preferencesBuilder.getValueForKey(keyName).toDouble();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('$title (${value.toInt()})'),
          ),
          Expanded(
            flex: 7,
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: '${value.toInt()}',
              onChanged: (newValue) {
                debugPrint(
                    'Slider Value Changed: $keyName to ${newValue.toInt()}');
                BlocProvider.of<UserPreferencesBuilderBloc>(context).add(
                  UpdateUserPreference(key: keyName, value: newValue.toInt()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
