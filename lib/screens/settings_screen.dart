import 'package:flutter/material.dart';
import '../models/user_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserPreferences preferences = UserPreferences.defaultPreferences();

  static const double minSliderValue = 0;
  static const double maxSliderValue = 120;
  static const double maxNumberSliderValue = 20;
  static const int sliderDivisions = 10;

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
      body: ListView(
        children: <Widget>[
          _buildStartDayDropdown(),
          _buildSettingsGroup(
            title: 'Default Durations',
            settingsWidgets: _buildDurationPreferences(),
          ),
          _buildSettingsGroup(
            title: 'Weekly Numbers',
            settingsWidgets: _buildWeeklyNumberPreferences(),
          ),
          _buildSettingsGroup(
            title: 'General Preferences',
            settingsWidgets: _buildBooleanPreferences(),
          ),
          ElevatedButton(
            onPressed: _resetToDefaultPreferences,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Reset to Default Settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildStartDayDropdown() {
    return ListTile(
      title: const Text('Start Day'),
      trailing: DropdownButton<int>(
        value: preferences.startDay,
        items: const [
          DropdownMenuItem(value: 1, child: Text('Monday')),
          DropdownMenuItem(value: 2, child: Text('Tuesday')),
          DropdownMenuItem(value: 3, child: Text('Wednesday')),
          DropdownMenuItem(value: 4, child: Text('Thursday')),
          DropdownMenuItem(value: 5, child: Text('Friday')),
          DropdownMenuItem(value: 6, child: Text('Saturday')),
          DropdownMenuItem(value: 7, child: Text('Sunday')),
        ],
        onChanged: (int? value) {
          if (value != null) {
            _updatePreference(() => preferences.startDay = value);
          }
        },
      ),
    );
  }

  Widget _buildSliderSetting(String title, double value, double min, double max,
      int divisions, Function(double) onChanged) {
    return ListTile(
      title: Text('$title (${value.toInt()})'),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.66,
        child: Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: '${value.toInt()}',
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<Widget> settingsWidgets,
  }) {
    return ExpansionTile(
      title: Text(title),
      children: settingsWidgets,
    );
  }

  List<Widget> _buildBooleanPreferences() {
    return [
      _buildBooleanPreference(
        title: 'Enable High Intensity Exercise',
        value: preferences.enableHighIntensityExercise,
        onChanged: (value) => _updatePreference(
            () => preferences.enableHighIntensityExercise = value),
      ),
      _buildBooleanPreference(
        title: 'Do Outdoor',
        value: preferences.doOutdoor,
        onChanged: (value) =>
            _updatePreference(() => preferences.doOutdoor = value),
      ),
      _buildBooleanPreference(
        title: 'Do Meditation',
        value: preferences.doMeditation,
        onChanged: (value) =>
            _updatePreference(() => preferences.doMeditation = value),
      ),
    ];
  }

  List<Widget> _buildDurationPreferences() {
    return [
      _buildSliderSetting(
        'Default Deep Work Duration',
        preferences.defaultDeepWorkDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultDeepWorkDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Learning Duration',
        preferences.defaultLearningDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultLearningDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Social Duration',
        preferences.defaultSocialDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultSocialDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Flux Duration',
        preferences.defaultFluxDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultFluxDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Shallow Work Duration',
        preferences.defaultShallowWorkDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultShallowWorkDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Meditation Duration',
        preferences.defaultMeditationDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultMeditationDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Outdoor Duration',
        preferences.defaultOutdoorDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultOutdoorDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Otaku Duration',
        preferences.defaultOtakuDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultOtakuDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Exercise Duration',
        preferences.defaultExerciseDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultExerciseDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Meal Duration',
        preferences.defaultMealDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultMealDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Tedium Duration',
        preferences.defaultTediumDuration.toDouble(),
        minSliderValue,
        maxSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.defaultTediumDuration = value.toInt()),
      ),
      _buildSliderSetting(
        'Default Rest Duration',
        preferences.defaultRestDuration.toDouble(),
        minSliderValue,
        800,
        60,
        (value) => _updatePreference(
            () => preferences.defaultRestDuration = value.toInt()),
      ),
    ];
  }

  List<Widget> _buildWeeklyNumberPreferences() {
    return [
      _buildSliderSetting(
        'Weekly Social Blocks',
        preferences.weeklySocialBlocks.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.weeklySocialBlocks = value.toInt()),
      ),
      _buildSliderSetting(
        'Weekly Flux Blocks',
        preferences.weeklyFluxBlocks.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.weeklyFluxBlocks = value.toInt()),
      ),
      _buildSliderSetting(
        'Weekly Otaku Blocks',
        preferences.weeklyOtakuBlocks.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.weeklyOtakuBlocks = value.toInt()),
      ),
      _buildSliderSetting(
        'Weekly Shallow Work Blocks',
        preferences.weeklyShallowWorkBlocks.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.weeklyShallowWorkBlocks = value.toInt()),
      ),
      _buildSliderSetting(
        'Weekly Outdoor Blocks',
        preferences.weeklyOutdoorBlocks.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.weeklyOutdoorBlocks = value.toInt()),
      ),
      _buildSliderSetting(
        'Weekly High Intensity Exercise Blocks',
        preferences.weeklyHighIntensityExerciseBlocks.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(() =>
            preferences.weeklyHighIntensityExerciseBlocks = value.toInt()),
      ),
      _buildSliderSetting(
        'Daily Meditation Sessions',
        preferences.dailyMeditationSessions.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.dailyMeditationSessions = value.toInt()),
      ),
      _buildSliderSetting(
        'Daily Learning Sessions',
        preferences.dailyLearningSessions.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.dailyLearningSessions = value.toInt()),
      ),
      _buildSliderSetting(
        'Daily Deep Work Sessions',
        preferences.dailyDeepWorkSessions.toDouble(),
        minSliderValue,
        maxNumberSliderValue,
        sliderDivisions,
        (value) => _updatePreference(
            () => preferences.dailyDeepWorkSessions = value.toInt()),
      ),
    ];
  }

  Widget _buildBooleanPreference({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text("$title ($value)"),
      value: value,
      onChanged: onChanged,
    );
  }

  void _updatePreference(Function updateFunction) {
    setState(() {
      updateFunction();
      preferences.savePreferences();
    });
  }

  void _resetToDefaultPreferences() {
    setState(() {
      preferences = UserPreferences.defaultPreferences();
      preferences.savePreferences();
    });
  }
}
