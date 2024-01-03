import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserPreferences {
  // Declare all the preferences
  bool enableHighIntensityExercise;
  int weeklyHighIntensityExerciseBlocks;
  int defaultDeepWorkDuration;
  int defaultLearningDuration;
  int defaultSocialDuration;
  int defaultFluxDuration;
  int defaultShallowWorkDuration;
  int defaultMeditationDuration;
  int defaultOutdoorDuration;
  int defaultOtakuDuration;
  int defaultExerciseDuration;
  int defaultMealDuration;
  int defaultRestDuration;
  int defaultTediumDuration;
  bool doOutdoor;
  int weeklyOutdoorBlocks;
  bool doMeditation;
  int dailyMeditationSessions;
  int dailyLearningSessions;
  int dailyDeepWorkSessions;
  int weeklyShallowWorkBlocks;
  int weeklySocialBlocks;
  int weeklyFluxBlocks;
  int weeklyOtakuBlocks;
  bool isFasting;
  int startDay;

  // Constructor with default values
  UserPreferences({
    this.enableHighIntensityExercise = true,
    this.weeklyHighIntensityExerciseBlocks = 3,
    this.defaultDeepWorkDuration = 90,
    this.defaultLearningDuration = 90,
    this.defaultSocialDuration = 60,
    this.defaultFluxDuration = 20,
    this.defaultShallowWorkDuration = 30,
    this.defaultMeditationDuration = 15,
    this.defaultOutdoorDuration = 15,
    this.defaultOtakuDuration = 60,
    this.defaultExerciseDuration = 30,
    this.defaultMealDuration = 30,
    this.defaultRestDuration = 480,
    this.defaultTediumDuration = 30,
    this.doOutdoor = true,
    this.weeklyOutdoorBlocks = 2,
    this.doMeditation = true,
    this.dailyMeditationSessions = 1,
    this.dailyLearningSessions = 2,
    this.dailyDeepWorkSessions = 4,
    this.weeklyShallowWorkBlocks = 7,
    this.weeklySocialBlocks = 1,
    this.weeklyFluxBlocks = 3,
    this.weeklyOtakuBlocks = 10,
    this.isFasting = true,
    this.startDay = 1,
  });

  // Convert to Map for saving
  Map<String, dynamic> toMap() => {
        'enableHighIntensityExercise': enableHighIntensityExercise,
        'weeklyHighIntensityExerciseBlocks': weeklyHighIntensityExerciseBlocks,
        'defaultDeepWorkDuration': defaultDeepWorkDuration,
        'defaultLearningDuration': defaultLearningDuration,
        'defaultSocialDuration': defaultSocialDuration,
        'defaultFluxDuration': defaultFluxDuration,
        'defaultShallowWorkDuration': defaultShallowWorkDuration,
        'defaultMeditationDuration': defaultMeditationDuration,
        'defaultOutdoorDuration': defaultOutdoorDuration,
        'defaultOtakuDuration': defaultOtakuDuration,
        'defaultExerciseDuration': defaultExerciseDuration,
        'defaultMealDuration': defaultMealDuration,
        'defaultRestDuration': defaultRestDuration,
        'defaultTediumDuration': defaultTediumDuration,
        'doOutdoor': doOutdoor,
        'weeklyOutdoorBlocks': weeklyOutdoorBlocks,
        'doMeditation': doMeditation,
        'dailyMeditationSessions': dailyMeditationSessions,
        'dailyLearningSessions': dailyLearningSessions,
        'dailyDeepWorkSessions': dailyDeepWorkSessions,
        'weeklyShallowWorkBlocks': weeklyShallowWorkBlocks,
        'weeklySocialBlocks': weeklySocialBlocks,
        'weeklyFluxBlocks': weeklyFluxBlocks,
        'weeklyOtakuBlocks': weeklyOtakuBlocks,
        'isFasting': isFasting,
        'startDay': startDay,
      };

  // Create from Map
  factory UserPreferences.fromMap(Map<String, dynamic> map) => UserPreferences(
        enableHighIntensityExercise: map['enableHighIntensityExercise'] ?? true,
        weeklyHighIntensityExerciseBlocks:
            map['weeklyHighIntensityExerciseBlocks'] ?? 3,
        defaultDeepWorkDuration: map['defaultDeepWorkDuration'] ?? 90,
        defaultLearningDuration: map['defaultLearningDuration'] ?? 90,
        defaultSocialDuration: map['defaultSocialDuration'] ?? 60,
        defaultFluxDuration: map['defaultFluxDuration'] ?? 20,
        defaultShallowWorkDuration: map['defaultShallowWorkDuration'] ?? 30,
        defaultMeditationDuration: map['defaultMeditationDuration'] ?? 15,
        defaultOutdoorDuration: map['defaultOutdoorDuration'] ?? 15,
        defaultOtakuDuration: map['defaultOtakuDuration'] ?? 60,
        defaultExerciseDuration: map['defaultExerciseDuration'] ?? 30,
        defaultMealDuration: map['defaultMealDuration'] ?? 30,
        defaultRestDuration: map['defaultRestDuration'] ?? 480,
        defaultTediumDuration: map['defaultTediumDuration'] ?? 30,
        doOutdoor: map['doOutdoor'] ?? true,
        weeklyOutdoorBlocks: map['weeklyOutdoorBlocks'] ?? 2,
        doMeditation: map['doMeditation'] ?? true,
        dailyMeditationSessions: map['dailyMeditationSessions'] ?? 1,
        dailyLearningSessions: map['dailyLearningSessions'] ?? 2,
        dailyDeepWorkSessions: map['dailyDeepWorkSessions'] ?? 4,
        weeklyShallowWorkBlocks: map['weeklyShallowWorkBlocks'] ?? 7,
        weeklySocialBlocks: map['weeklySocialBlocks'] ?? 1,
        weeklyFluxBlocks: map['weeklyFluxBlocks'] ?? 3,
        weeklyOtakuBlocks: map['weeklyOtakuBlocks'] ?? 10,
        isFasting: map['isFasting'] ?? true,
        startDay: map['startDay'] ?? 1,
      );

  // Load preferences
  static Future<UserPreferences> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? userPrefsString = prefs.getString('userPreferences');
    return userPrefsString != null
        ? UserPreferences.fromMap(json.decode(userPrefsString))
        : UserPreferences();
  }

  // Save preferences
  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userPreferences', json.encode(toMap()));
  }

  // Generic method to update a preference
  void updatePreference(String key, dynamic value) {
    Map<String, dynamic> prefMap = toMap();
    prefMap[key] = value;
    UserPreferences.fromMap(prefMap).savePreferences();
  }

  static UserPreferences defaultPreferences() {
    return UserPreferences(
      enableHighIntensityExercise: true,
      weeklyHighIntensityExerciseBlocks: 3,
      defaultDeepWorkDuration: 90,
      defaultLearningDuration: 90,
      defaultSocialDuration: 60,
      defaultFluxDuration: 20,
      defaultShallowWorkDuration: 30,
      defaultMeditationDuration: 15,
      defaultOutdoorDuration: 15,
      defaultOtakuDuration: 60,
      defaultExerciseDuration: 30,
      defaultMealDuration: 30,
      defaultRestDuration: 480,
      defaultTediumDuration: 30,
      doOutdoor: true,
      weeklyOutdoorBlocks: 2,
      doMeditation: true,
      dailyMeditationSessions: 1,
      dailyLearningSessions: 2,
      dailyDeepWorkSessions: 4,
      weeklyShallowWorkBlocks: 7,
      weeklySocialBlocks: 1,
      weeklyFluxBlocks: 3,
      weeklyOtakuBlocks: 10,
      isFasting: true,
    );
  }
}
