import 'package:flutter/material.dart';
import '../models/user_preferences.dart';
import 'setting_slider.dart';
import 'setting_switch.dart';
import 'setting_dropdown.dart';

class SettingsListView extends StatelessWidget {
  final UserPreferences preferences;
  final Function(Function) onUpdate;
  static const double minSliderValue = 0;
  static const double maxSliderValue = 120;
  static const double maxNumberSliderValue = 20;
  static const int sliderDivisions = 10;

  const SettingsListView({
    Key? key,
    required this.preferences,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SettingDropdown<int>(
          title: 'Start Day',
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
              onUpdate(() => preferences.startDay = value);
            }
          },
        ),
        SettingSlider(
          title: 'Default Deep Work Duration',
          value: preferences.defaultDeepWorkDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.defaultDeepWorkDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Learning Duration',
          value: preferences.defaultLearningDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.defaultLearningDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Social Duration',
          value: preferences.defaultSocialDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.defaultSocialDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Flux Duration',
          value: preferences.defaultFluxDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.defaultFluxDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Shallow Work Duration',
          value: preferences.defaultShallowWorkDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.defaultShallowWorkDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Meditation Duration',
          value: preferences.defaultMeditationDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.defaultMeditationDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Outdoor Duration',
          value: preferences.defaultOutdoorDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.defaultOutdoorDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Otaku Duration',
          value: preferences.defaultOtakuDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.defaultOtakuDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Exercise Duration',
          value: preferences.defaultExerciseDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.defaultExerciseDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Meal Duration',
          value: preferences.defaultMealDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.defaultMealDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Tedium Duration',
          value: preferences.defaultTediumDuration,
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.defaultTediumDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Default Rest Duration',
          value: preferences.defaultRestDuration,
          min: minSliderValue,
          max: 800,
          divisions: 60,
          onChanged: (value) =>
              onUpdate(() => preferences.defaultRestDuration = value.toInt()),
        ),
        SettingSlider(
          title: 'Weekly Social Blocks',
          value: preferences.weeklySocialBlocks,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.weeklySocialBlocks = value.toInt()),
        ),
        SettingSlider(
          title: 'Weekly Flux Blocks',
          value: preferences.weeklyFluxBlocks,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.weeklyFluxBlocks = value.toInt()),
        ),
        SettingSlider(
          title: 'Weekly Otaku Blocks',
          value: preferences.weeklyOtakuBlocks,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.weeklyOtakuBlocks = value.toInt()),
        ),
        SettingSlider(
          title: 'Weekly Shallow Work Blocks',
          value: preferences.weeklyShallowWorkBlocks,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.weeklyShallowWorkBlocks = value.toInt()),
        ),
        SettingSlider(
          title: 'Weekly Outdoor Blocks',
          value: preferences.weeklyOutdoorBlocks,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.weeklyOutdoorBlocks = value.toInt()),
        ),
        SettingSlider(
          title: 'Weekly High Intensity Exercise Blocks',
          value: preferences.weeklyHighIntensityExerciseBlocks,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(() =>
              preferences.weeklyHighIntensityExerciseBlocks = value.toInt()),
        ),
        SettingSlider(
          title: 'Daily Meditation Sessions',
          value: preferences.dailyMeditationSessions,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) => onUpdate(
              () => preferences.dailyMeditationSessions = value.toInt()),
        ),
        SettingSlider(
          title: 'Daily Learning Sessions',
          value: preferences.dailyLearningSessions,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.dailyLearningSessions = value.toInt()),
        ),
        SettingSlider(
          title: 'Daily Deep Work Sessions',
          value: preferences.dailyDeepWorkSessions,
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          onChanged: (value) =>
              onUpdate(() => preferences.dailyDeepWorkSessions = value.toInt()),
        ),
        SettingSwitch(
          title: 'Enable High Intensity Exercise',
          value: preferences.enableHighIntensityExercise,
          onChanged: (value) =>
              onUpdate(() => preferences.enableHighIntensityExercise = value),
        ),
        SettingSwitch(
          title: 'Enable Outdoor Time... I suppose',
          value: preferences.doOutdoor,
          onChanged: (value) => onUpdate(() => preferences.doOutdoor = value),
        ),
        SettingSwitch(
          title: 'Enable Meditation',
          value: preferences.doMeditation,
          onChanged: (value) =>
              onUpdate(() => preferences.doMeditation = value),
        ),
      ],
    );
  }
}
