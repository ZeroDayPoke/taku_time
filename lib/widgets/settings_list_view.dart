// settings_list_view.dart
import 'package:flutter/material.dart';
import 'setting_slider.dart';
import 'setting_switch.dart';
import 'relax_block_card.dart';

class SettingsListView extends StatelessWidget {
  const SettingsListView({Key? key}) : super(key: key);

  static const double minSliderValue = 0;
  static const double maxSliderValue = 120;
  static const double maxNumberSliderValue = 20;
  static const int sliderDivisions = 10;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        RelaxBlockCard(
          activityName: 'Otaku',
          durationKeyName: 'defaultOtakuDuration',
          enableKeyName: 'doOtaku',
        ),
        // Default Durations
        SettingSlider(
          title: 'Default Learning Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultLearningDuration',
        ),
        SettingSlider(
          title: 'Default Deep Work Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultDeepWorkDuration',
        ),
        SettingSlider(
          title: 'Default Social Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultSocialDuration',
        ),
        SettingSlider(
          title: 'Default Flux Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultFluxDuration',
        ),
        SettingSlider(
          title: 'Default Shallow Work Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultShallowWorkDuration',
        ),
        SettingSlider(
          title: 'Default Meditation Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultMeditationDuration',
        ),
        SettingSlider(
          title: 'Default Outdoor Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultOutdoorDuration',
        ),
        // SettingSlider(
        //   title: 'Default Otaku Duration',
        //   min: minSliderValue,
        //   max: maxSliderValue,
        //   divisions: sliderDivisions,
        //   keyName: 'defaultOtakuDuration',
        // ),
        SettingSlider(
          title: 'Default Exercise Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultExerciseDuration',
        ),
        SettingSlider(
          title: 'Default Meal Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultMealDuration',
        ),
        SettingSlider(
          title: 'Default Tedium Duration',
          min: minSliderValue,
          max: maxSliderValue,
          divisions: sliderDivisions,
          keyName: 'defaultTediumDuration',
        ),
        SettingSlider(
          title: 'Default Rest Duration',
          min: minSliderValue,
          max: 800,
          divisions: 60,
          keyName: 'defaultRestDuration',
        ),

        // Include Activities
        SettingSwitch(
          title: 'Enable Outdoor',
          keyName: 'doOutdoor',
        ),
        SettingSwitch(
          title: 'Enable Meditation',
          keyName: 'doMeditation',
        ),
        // SettingSwitch(
        //   title: 'Enable Otaku Time',
        //   keyName: 'doOtaku',
        // ),
        SettingSwitch(
          title: 'Enable Exercise',
          keyName: 'doExercise',
        ),
        SettingSwitch(
          title: 'Enable High Intensity Exercise',
          keyName: 'enableHighIntensityExercise',
        ),
        SettingSwitch(
          title: 'Enable Tedium',
          keyName: 'doTedium',
        ),
        SettingSwitch(
          title: 'Enable Flux',
          keyName: 'doFlux',
        ),
        SettingSwitch(
          title: 'Enable Shallow Work',
          keyName: 'doShallowWork',
        ),
        SettingSwitch(
          title: 'Enable Social Time',
          keyName: 'doSocial',
        ),

        // Weekly Blocks
        SettingSlider(
          title: 'Weekly Social Blocks',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'weeklySocialBlocks',
        ),
        SettingSlider(
          title: 'Weekly Flux Blocks',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'weeklyFluxBlocks',
        ),
        SettingSlider(
          title: 'Weekly Otaku Blocks',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'weeklyOtakuBlocks',
        ),
        SettingSlider(
          title: 'Weekly Shallow Work Blocks',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'weeklyShallowWorkBlocks',
        ),
        SettingSlider(
          title: 'Weekly Outdoor Blocks',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'weeklyOutdoorBlocks',
        ),
        SettingSlider(
          title: 'Weekly High Intensity Exercise Blocks',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'weeklyHighIntensityExerciseBlocks',
        ),

        // Daily Sessions
        SettingSlider(
          title: 'Daily Meditation Sessions',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'dailyMeditationSessions',
        ),
        SettingSlider(
          title: 'Daily Learning Sessions',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'dailyLearningSessions',
        ),
        SettingSlider(
          title: 'Daily Deep Work Sessions',
          min: minSliderValue,
          max: maxNumberSliderValue,
          divisions: sliderDivisions,
          keyName: 'dailyDeepWorkSessions',
        ),

        // General Settings
        SettingSlider(
          title: 'Start Day',
          min: 0,
          max: 6,
          divisions: 6,
          keyName: 'startDay',
        ),
        SettingSlider(
          title: 'Meal Time Hour',
          min: 0,
          max: 23,
          divisions: 23,
          keyName: 'mealTimeHour',
        ),
        SettingSlider(
          title: 'Meal Time Minute',
          min: 0,
          max: 59,
          divisions: 59,
          keyName: 'mealTimeMinute',
        ),
        SettingSlider(
          title: 'Sleep Time Hour',
          min: 0,
          max: 23,
          divisions: 23,
          keyName: 'sleepTimeHour',
        ),
        SettingSlider(
          title: 'Sleep Time Minute',
          min: 0,
          max: 59,
          divisions: 59,
          keyName: 'sleepTimeMinute',
        ),
        SettingSwitch(
          title: 'Is Fasting',
          keyName: 'isFasting',
        ),
      ],
    );
  }
}
