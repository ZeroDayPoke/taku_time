import 'user_preferences.dart';
import 'package:flutter/foundation.dart';

class UserPreferencesBuilder {
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
  bool doOtaku;
  int weeklyOtakuBlocks;
  bool doExercise;
  bool enableHighIntensityExercise;
  int weeklyHighIntensityExerciseBlocks;
  bool doTedium;
  bool doFlux;
  int weeklyFluxBlocks;
  bool doShallowWork;
  int weeklyShallowWorkBlocks;
  bool doSocial;
  int weeklySocialBlocks;
  int dailyLearningSessions;
  int dailyDeepWorkSessions;
  bool isFasting;
  int startDay;
  int mealTimeHour;
  int mealTimeMinute;
  int sleepTimeHour;
  int sleepTimeMinute;

  UserPreferencesBuilder({
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
    this.doOtaku = true,
    this.weeklyOtakuBlocks = 10,
    this.doExercise = true,
    this.enableHighIntensityExercise = true,
    this.weeklyHighIntensityExerciseBlocks = 3,
    this.doTedium = true,
    this.doFlux = true,
    this.weeklyFluxBlocks = 3,
    this.doShallowWork = true,
    this.weeklyShallowWorkBlocks = 7,
    this.doSocial = true,
    this.weeklySocialBlocks = 1,
    this.dailyLearningSessions = 2,
    this.dailyDeepWorkSessions = 4,
    this.isFasting = true,
    this.startDay = 1,
    this.mealTimeHour = 20,
    this.mealTimeMinute = 0,
    this.sleepTimeHour = 0,
    this.sleepTimeMinute = 0,
  });

  factory UserPreferencesBuilder.fromUserPreferences(UserPreferences prefs) {
    return UserPreferencesBuilder(
      defaultDeepWorkDuration: prefs.defaultDeepWorkDuration,
      defaultLearningDuration: prefs.defaultLearningDuration,
      defaultSocialDuration: prefs.defaultSocialDuration,
      defaultFluxDuration: prefs.defaultFluxDuration,
      defaultShallowWorkDuration: prefs.defaultShallowWorkDuration,
      defaultMeditationDuration: prefs.defaultMeditationDuration,
      defaultOutdoorDuration: prefs.defaultOutdoorDuration,
      defaultOtakuDuration: prefs.defaultOtakuDuration,
      defaultExerciseDuration: prefs.defaultExerciseDuration,
      defaultMealDuration: prefs.defaultMealDuration,
      defaultRestDuration: prefs.defaultRestDuration,
      defaultTediumDuration: prefs.defaultTediumDuration,
      doOutdoor: prefs.doOutdoor,
      weeklyOutdoorBlocks: prefs.weeklyOutdoorBlocks,
      doMeditation: prefs.doMeditation,
      dailyMeditationSessions: prefs.dailyMeditationSessions,
      doOtaku: prefs.doOtaku,
      weeklyOtakuBlocks: prefs.weeklyOtakuBlocks,
      doExercise: prefs.doExercise,
      enableHighIntensityExercise: prefs.enableHighIntensityExercise,
      weeklyHighIntensityExerciseBlocks:
          prefs.weeklyHighIntensityExerciseBlocks,
      doTedium: prefs.doTedium,
      doFlux: prefs.doFlux,
      weeklyFluxBlocks: prefs.weeklyFluxBlocks,
      doShallowWork: prefs.doShallowWork,
      weeklyShallowWorkBlocks: prefs.weeklyShallowWorkBlocks,
      doSocial: prefs.doSocial,
      weeklySocialBlocks: prefs.weeklySocialBlocks,
      dailyLearningSessions: prefs.dailyLearningSessions,
      dailyDeepWorkSessions: prefs.dailyDeepWorkSessions,
      isFasting: prefs.isFasting,
      startDay: prefs.startDay,
      mealTimeHour: prefs.mealTimeHour,
      mealTimeMinute: prefs.mealTimeMinute,
      sleepTimeHour: prefs.sleepTimeHour,
      sleepTimeMinute: prefs.sleepTimeMinute,
    );
  }

  UserPreferencesBuilder updatePreference<T>(String key, T value) {
    var updatedBuilder = UserPreferencesBuilder(
      defaultDeepWorkDuration: defaultDeepWorkDuration,
      defaultLearningDuration: defaultLearningDuration,
      defaultSocialDuration: defaultSocialDuration,
      defaultFluxDuration: defaultFluxDuration,
      defaultShallowWorkDuration: defaultShallowWorkDuration,
      defaultMeditationDuration: defaultMeditationDuration,
      defaultOutdoorDuration: defaultOutdoorDuration,
      defaultOtakuDuration: defaultOtakuDuration,
      defaultExerciseDuration: defaultExerciseDuration,
      defaultMealDuration: defaultMealDuration,
      defaultRestDuration: defaultRestDuration,
      defaultTediumDuration: defaultTediumDuration,
      doOutdoor: doOutdoor,
      weeklyOutdoorBlocks: weeklyOutdoorBlocks,
      doMeditation: doMeditation,
      dailyMeditationSessions: dailyMeditationSessions,
      doOtaku: doOtaku,
      weeklyOtakuBlocks: weeklyOtakuBlocks,
      doExercise: doExercise,
      enableHighIntensityExercise: enableHighIntensityExercise,
      weeklyHighIntensityExerciseBlocks: weeklyHighIntensityExerciseBlocks,
      doTedium: doTedium,
      doFlux: doFlux,
      weeklyFluxBlocks: weeklyFluxBlocks,
      doShallowWork: doShallowWork,
      weeklyShallowWorkBlocks: weeklyShallowWorkBlocks,
      doSocial: doSocial,
      weeklySocialBlocks: weeklySocialBlocks,
      dailyLearningSessions: dailyLearningSessions,
      dailyDeepWorkSessions: dailyDeepWorkSessions,
      isFasting: isFasting,
      startDay: startDay,
      mealTimeHour: mealTimeHour,
      mealTimeMinute: mealTimeMinute,
      sleepTimeHour: sleepTimeHour,
      sleepTimeMinute: sleepTimeMinute,
    );

    switch (key) {
      case 'defaultDeepWorkDuration':
        if (value is int) defaultDeepWorkDuration = value;
        break;
      case 'defaultLearningDuration':
        if (value is int) defaultLearningDuration = value;
        break;
      case 'defaultSocialDuration':
        if (value is int) defaultSocialDuration = value;
        break;
      case 'defaultFluxDuration':
        if (value is int) defaultFluxDuration = value;
        break;
      case 'defaultShallowWorkDuration':
        if (value is int) defaultShallowWorkDuration = value;
        break;
      case 'defaultMeditationDuration':
        if (value is int) defaultMeditationDuration = value;
        break;
      case 'defaultOutdoorDuration':
        if (value is int) defaultOutdoorDuration = value;
        break;
      case 'defaultOtakuDuration':
        if (value is int) defaultOtakuDuration = value;
        break;
      case 'defaultExerciseDuration':
        if (value is int) defaultExerciseDuration = value;
        break;
      case 'defaultMealDuration':
        if (value is int) defaultMealDuration = value;
        break;
      case 'defaultRestDuration':
        if (value is int) defaultRestDuration = value;
        break;
      case 'defaultTediumDuration':
        if (value is int) defaultTediumDuration = value;
        break;
      case 'doOutdoor':
        if (value is bool) doOutdoor = value;
        break;
      case 'weeklyOutdoorBlocks':
        if (value is int) weeklyOutdoorBlocks = value;
        break;
      case 'doMeditation':
        if (value is bool) doMeditation = value;
        break;
      case 'dailyMeditationSessions':
        if (value is int) dailyMeditationSessions = value;
        break;
      case 'doOtaku':
        if (value is bool) doOtaku = value;
        break;
      case 'weeklyOtakuBlocks':
        if (value is int) weeklyOtakuBlocks = value;
        break;
      case 'doExercise':
        if (value is bool) doExercise = value;
        break;
      case 'enableHighIntensityExercise':
        if (value is bool) enableHighIntensityExercise = value;
        break;
      case 'weeklyHighIntensityExerciseBlocks':
        if (value is int) weeklyHighIntensityExerciseBlocks = value;
        break;
      case 'doTedium':
        if (value is bool) doTedium = value;
        break;
      case 'doFlux':
        if (value is bool) doFlux = value;
        break;
      case 'weeklyFluxBlocks':
        if (value is int) weeklyFluxBlocks = value;
        break;
      case 'doShallowWork':
        if (value is bool) doShallowWork = value;
        break;
      case 'weeklyShallowWorkBlocks':
        if (value is int) weeklyShallowWorkBlocks = value;
        break;
      case 'doSocial':
        if (value is bool) doSocial = value;
        break;
      case 'weeklySocialBlocks':
        if (value is int) weeklySocialBlocks = value;
        break;
      case 'dailyLearningSessions':
        if (value is int) dailyLearningSessions = value;
        break;
      case 'dailyDeepWorkSessions':
        if (value is int) dailyDeepWorkSessions = value;
        break;
      case 'isFasting':
        if (value is bool) isFasting = value;
        break;
      case 'startDay':
        if (value is int) startDay = value;
        break;
      case 'mealTimeHour':
        if (value is int) mealTimeHour = value;
        break;
      case 'mealTimeMinute':
        if (value is int) mealTimeMinute = value;
        break;
      case 'sleepTimeHour':
        if (value is int) sleepTimeHour = value;
        break;
      case 'sleepTimeMinute':
        if (value is int) sleepTimeMinute = value;
        break;
    }

    return updatedBuilder;
  }

  UserPreferences build() {
    return UserPreferences(
      defaultDeepWorkDuration: defaultDeepWorkDuration,
      defaultLearningDuration: defaultLearningDuration,
      defaultSocialDuration: defaultSocialDuration,
      defaultFluxDuration: defaultFluxDuration,
      defaultShallowWorkDuration: defaultShallowWorkDuration,
      defaultMeditationDuration: defaultMeditationDuration,
      defaultOutdoorDuration: defaultOutdoorDuration,
      defaultOtakuDuration: defaultOtakuDuration,
      defaultExerciseDuration: defaultExerciseDuration,
      defaultMealDuration: defaultMealDuration,
      defaultRestDuration: defaultRestDuration,
      defaultTediumDuration: defaultTediumDuration,
      doOutdoor: doOutdoor,
      weeklyOutdoorBlocks: weeklyOutdoorBlocks,
      doMeditation: doMeditation,
      dailyMeditationSessions: dailyMeditationSessions,
      doOtaku: doOtaku,
      weeklyOtakuBlocks: weeklyOtakuBlocks,
      doExercise: doExercise,
      enableHighIntensityExercise: enableHighIntensityExercise,
      weeklyHighIntensityExerciseBlocks: weeklyHighIntensityExerciseBlocks,
      doTedium: doTedium,
      doFlux: doFlux,
      weeklyFluxBlocks: weeklyFluxBlocks,
      doShallowWork: doShallowWork,
      weeklyShallowWorkBlocks: weeklyShallowWorkBlocks,
      doSocial: doSocial,
      weeklySocialBlocks: weeklySocialBlocks,
      dailyLearningSessions: dailyLearningSessions,
      dailyDeepWorkSessions: dailyDeepWorkSessions,
      isFasting: isFasting,
      startDay: startDay,
      mealTimeHour: mealTimeHour,
      mealTimeMinute: mealTimeMinute,
      sleepTimeHour: sleepTimeHour,
      sleepTimeMinute: sleepTimeMinute,
    );
  }

  Map<String, dynamic> getAllPreferences() {
    return {
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
      'doOtaku': doOtaku,
      'doExercise': doExercise,
      'doTedium': doTedium,
      'doFlux': doFlux,
      'doShallowWork': doShallowWork,
      'doSocial': doSocial,
      'mealTimeHour': mealTimeHour,
      'mealTimeMinute': mealTimeMinute,
      'sleepTimeHour': sleepTimeHour,
      'sleepTimeMinute': sleepTimeMinute,
    };
  }

  dynamic getValueForKey(String key) {
    switch (key) {
      case 'defaultDeepWorkDuration':
        return defaultDeepWorkDuration;
      case 'defaultLearningDuration':
        return defaultLearningDuration;
      case 'defaultSocialDuration':
        return defaultSocialDuration;
      case 'defaultFluxDuration':
        return defaultFluxDuration;
      case 'defaultShallowWorkDuration':
        return defaultShallowWorkDuration;
      case 'defaultMeditationDuration':
        return defaultMeditationDuration;
      case 'defaultOutdoorDuration':
        return defaultOutdoorDuration;
      case 'defaultOtakuDuration':
        return defaultOtakuDuration;
      case 'defaultExerciseDuration':
        return defaultExerciseDuration;
      case 'defaultMealDuration':
        return defaultMealDuration;
      case 'defaultRestDuration':
        return defaultRestDuration;
      case 'defaultTediumDuration':
        return defaultTediumDuration;
      case 'doOutdoor':
        return doOutdoor;
      case 'weeklyOutdoorBlocks':
        return weeklyOutdoorBlocks;
      case 'doMeditation':
        return doMeditation;
      case 'dailyMeditationSessions':
        return dailyMeditationSessions;
      case 'doOtaku':
        return doOtaku;
      case 'weeklyOtakuBlocks':
        return weeklyOtakuBlocks;
      case 'doExercise':
        return doExercise;
      case 'enableHighIntensityExercise':
        return enableHighIntensityExercise;
      case 'weeklyHighIntensityExerciseBlocks':
        return weeklyHighIntensityExerciseBlocks;
      case 'doTedium':
        return doTedium;
      case 'doFlux':
        return doFlux;
      case 'weeklyFluxBlocks':
        return weeklyFluxBlocks;
      case 'doShallowWork':
        return doShallowWork;
      case 'weeklyShallowWorkBlocks':
        return weeklyShallowWorkBlocks;
      case 'doSocial':
        return doSocial;
      case 'weeklySocialBlocks':
        return weeklySocialBlocks;
      case 'dailyLearningSessions':
        return dailyLearningSessions;
      case 'dailyDeepWorkSessions':
        return dailyDeepWorkSessions;
      case 'isFasting':
        return isFasting;
      case 'startDay':
        return startDay;
      case 'mealTimeHour':
        return mealTimeHour;
      case 'mealTimeMinute':
        return mealTimeMinute;
      case 'sleepTimeHour':
        return sleepTimeHour;
      case 'sleepTimeMinute':
        return sleepTimeMinute;
      default:
        debugPrint('Invalid key: $key');
        return null;
    }
  }

  static UserPreferencesBuilder defaultBuilder() {
    return UserPreferencesBuilder();
  }
}
