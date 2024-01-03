import 'package:flutter/material.dart';
import '../models/user_preferences.dart';
import '../widgets/settings_list_view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserPreferences preferences = UserPreferences.defaultPreferences();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    var loadedPreferences = await UserPreferences.loadPreferences();
    setState(() {
      preferences = loadedPreferences;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (preferences == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsListView(
        preferences: preferences,
        onUpdate: (Function updateFunction) {
          setState(() {
            updateFunction();
            preferences.savePreferences();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetToDefaultPreferences,
        backgroundColor: Colors.red,
        child: const Icon(Icons.restore),
      ),
    );
  }

  void _resetToDefaultPreferences() {
    setState(() {
      preferences = UserPreferences.defaultPreferences();
      preferences.savePreferences();
    });
  }
}
