// settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/settings_list_view.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SettingsListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<UserPreferencesBuilderBloc>(context)
            .add(ResetUserPreferences()),
        backgroundColor: Colors.red,
        child: const Icon(Icons.restore),
      ),
    );
  }
}
