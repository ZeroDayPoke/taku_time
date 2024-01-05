class UserPreferences {
  // Default Block Durations
  final int defaultDeepWorkDuration;
  final int defaultLearningDuration;
  final int defaultSocialDuration;
  final int defaultFluxDuration;
  final int defaultShallowWorkDuration;
  final int defaultMeditationDuration;
  final int defaultOutdoorDuration;
  final int defaultOtakuDuration;
  final int defaultExerciseDuration;
  final int defaultMealDuration;
  final int defaultRestDuration;
  final int defaultTediumDuration;

  // Inevitable Recurring Events
  final DateTime mealTime;
  final DateTime sleepTime;

  // Rest Block Inclusions
  final bool doOutdoor;
  final int weeklyOutdoorBlocks;
  final bool doMeditation;
  final int dailyMeditationSessions;
  final bool doOtaku;
  final int weeklyOtakuBlocks;
  final bool doExercise;
  final bool enableHighIntensityExercise;
  final int weeklyHighIntensityExerciseBlocks;
  final bool doTedium;
  final bool doFlux;
  final int weeklyFluxBlocks;
  final bool doShallowWork;
  final int weeklyShallowWorkBlocks;
  final bool doSocial;
  final int weeklySocialBlocks;

  // Stress Blocks
  final int dailyLearningSessions;
  final int dailyDeepWorkSessions;

  // Extra
  final bool isFasting;
  final int startDay;
  final int mealTimeHour;
  final int mealTimeMinute;
  final int sleepTimeHour;
  final int sleepTimeMinute;

  UserPreferences({
    // Include All Modules by Default
    this.doExercise = true,
    this.enableHighIntensityExercise = true,
    this.isFasting = true,
    this.doMeditation = true,
    this.doOutdoor = true,
    this.doOtaku = true,
    this.doTedium = true,
    this.doFlux = true,
    this.doShallowWork = true,
    this.doSocial = true,

    // Times
    DateTime? mealTime,
    DateTime? sleepTime,
    this.mealTimeHour = 20,
    this.mealTimeMinute = 0,
    this.sleepTimeHour = 0,
    this.sleepTimeMinute = 0,

    // Default Values
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
    this.weeklyOutdoorBlocks = 2,
    this.dailyMeditationSessions = 1,
    this.dailyLearningSessions = 2,
    this.dailyDeepWorkSessions = 4,
    this.weeklyShallowWorkBlocks = 7,
    this.weeklySocialBlocks = 1,
    this.weeklyFluxBlocks = 3,
    this.weeklyOtakuBlocks = 10,
    this.startDay = 1,
  })  : mealTime = mealTime ?? DateTime(2024, 0, 0, 20, 0),
        sleepTime = sleepTime ?? DateTime(2024, 0, 0, 0, 0);

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
        'doOtaku': doOtaku,
        'doExercise': doExercise,
        'doTedium': doTedium,
        'doFlux': doFlux,
        'doShallowWork': doShallowWork,
        'doSocial': doSocial,
        'mealTimeHour': mealTime.hour,
        'mealTimeMinute': mealTime.minute,
        'sleepTimeHour': sleepTime.hour,
        'sleepTimeMinute': sleepTime.minute,
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
        doOtaku: map['doOtaku'] ?? true,
        doExercise: map['doExercise'] ?? true,
        doTedium: map['doTedium'] ?? true,
        doFlux: map['doFlux'] ?? true,
        doShallowWork: map['doShallowWork'] ?? true,
        doSocial: map['doSocial'] ?? true,
        mealTimeHour: map['mealTimeHour'] ?? 20,
        mealTimeMinute: map['mealTimeMinute'] ?? 0,
        sleepTimeHour: map['sleepTimeHour'] ?? 0,
        sleepTimeMinute: map['sleepTimeMinute'] ?? 0,
        mealTime: DateTime(
            2024, 0, 0, map['mealTimeHour'] ?? 20, map['mealTimeMinute'] ?? 0),
        sleepTime: DateTime(
            2024, 0, 0, map['sleepTimeHour'] ?? 0, map['sleepTimeMinute'] ?? 0),
      );

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
      startDay: 1,
      doOtaku: true,
      doExercise: true,
      doTedium: true,
      doFlux: true,
      doShallowWork: true,
      doSocial: true,
      mealTime: DateTime(2024, 0, 0, 20, 0),
      sleepTime: DateTime(2024, 0, 0, 0, 0),
      mealTimeHour: 20,
      mealTimeMinute: 0,
      sleepTimeHour: 0,
      sleepTimeMinute: 0,
    );
  }
}
