import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/settings_list_view.dart';
import '../bloc/user_preferences_builder_bloc.dart';
import '../bloc/user_preferences_builder_event.dart';
import '../bloc/user_preferences_builder_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _showResetConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to Factory Defaults'),
        content: const Text(
            'Are you sure you want to reset all settings to their default values? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Reset'),
            onPressed: () {
              BlocProvider.of<UserPreferencesBuilderBloc>(context)
                  .add(ResetUserPreferences());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: () => _showResetConfirmation(context),
            tooltip: 'Reset to Factory Defaults',
          ),
        ],
      ),
      body: const SettingsListView(),
      floatingActionButton:
          BlocBuilder<UserPreferencesBuilderBloc, UserPreferencesBuilderState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Save Button
              if (state is UserPreferencesBuilderUpdated)
                FloatingActionButton(
                  onPressed: () =>
                      BlocProvider.of<UserPreferencesBuilderBloc>(context)
                          .add(SaveUserPreferences()),
                  backgroundColor: Colors.green,
                  heroTag: 'saveButton',
                  child: const Icon(Icons.save),
                ),
              const SizedBox(height: 10),
              // Reload Button
              if (state is UserPreferencesBuilderUpdated)
                FloatingActionButton(
                  onPressed: () =>
                      BlocProvider.of<UserPreferencesBuilderBloc>(context)
                          .add(ReloadUserPreferences()),
                  backgroundColor: Colors.blue,
                  heroTag: 'reloadButton',
                  child: const Icon(Icons.refresh),
                ),
            ],
          );
        },
      ),
    );
  }
}
