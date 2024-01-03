class UserPreferences {
  final bool enableHighIntensityExercise;
  final int weeklyHighIntensityExerciseBlocks;

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

  final bool doOutdoor;
  final int weeklyOutdoorBlocks;

  final bool doMeditation;
  final int dailyMeditationSessions;

  final int dailyLearningSessions;
  final int dailyDeepWorkSessions;
  final int weeklyShallowWorkBlocks;

  final int weeklySocialBlocks;
  final int weeklyFluxBlocks;
  final int weeklyOtakuBlocks;

  final bool isFasting;

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
  });

  static UserPreferences defaultPreferences() {
    return UserPreferences();
  }
}
