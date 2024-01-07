import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../models/user_preferences_builder.dart';

class SettingNumberPicker extends StatelessWidget {
  final String title;
  final String keyName;
  final UserPreferencesBuilder preferencesBuilder;

  const SettingNumberPicker({
    Key? key,
    required this.title,
    required this.keyName,
    required this.preferencesBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHour = keyName.endsWith("Hour");
    final int maxValue = isHour ? 23 : 59;
    const int minValue = 0;
    final int currentValue = preferencesBuilder.getValueForKey(keyName) as int;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(
            height: 150,
            child: NumberPicker(
              value: currentValue,
              minValue: minValue,
              maxValue: maxValue,
              onChanged: (newValue) {
                BlocProvider.of<UserPreferencesBuilderBloc>(context).add(
                  UpdateUserPreference(key: keyName, value: newValue),
                );
              },
              selectedTextStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textStyle: const TextStyle(
                fontSize: 16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
