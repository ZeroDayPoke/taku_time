import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../bloc/user_preferences_builder_state.dart';

class SettingSlider extends StatelessWidget {
  final String title;
  final double min;
  final double max;
  final int divisions;
  final String keyName;

  const SettingSlider({
    Key? key,
    required this.title,
    required this.min,
    required this.max,
    required this.divisions,
    required this.keyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreferencesBuilderBloc, UserPreferencesBuilderState>(
      builder: (context, state) {
        if (state is UserPreferencesBuilderLoaded) {
          final value = state.preferencesBuilder.getValueForKey(keyName);
          return ListTile(
            title: Text('$title (${value.toInt()})'),
            trailing: SizedBox(
              width: MediaQuery.of(context).size.width * 0.66,
              child: Slider(
                value: value.toDouble(),
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
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
