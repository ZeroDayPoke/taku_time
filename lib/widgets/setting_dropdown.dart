import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';

class SettingDropdown<T> extends StatelessWidget {
  final String title;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final String keyName;

  const SettingDropdown({
    Key? key,
    required this.title,
    required this.value,
    required this.items,
    required this.keyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<T>(
        value: value,
        items: items,
        onChanged: (newValue) {
          BlocProvider.of<UserPreferencesBuilderBloc>(context).add(
            UpdateUserPreference(key: keyName, value: newValue),
          );
        },
      ),
    );
  }
}
