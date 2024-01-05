import '../models/user_preferences_builder.dart';
import '../models/user_preferences.dart';

class ScheduleValidator {
  static const int minutesPerDay = 24 * 60;

  final UserPreferencesBuilder userPreferencesBuilder;

  ScheduleValidator(this.userPreferencesBuilder);

  UserPreferences get preferences => userPreferencesBuilder.build();

  int get dailyDeepWorkTime =>
      preferences.dailyDeepWorkSessions * preferences.defaultDeepWorkDuration;
  int get dailyLearningTime =>
      preferences.dailyLearningSessions * preferences.defaultLearningDuration;
  int get dailyMeditationTime => preferences.doMeditation
      ? preferences.dailyMeditationSessions *
          preferences.defaultMeditationDuration
      : 0;
  int get dailyRestTime => preferences.defaultRestDuration;
  int get dailyTediumTime =>
      preferences.doTedium ? preferences.defaultTediumDuration : 0;
  int get dailyMealTime =>
      preferences.defaultMealDuration * (preferences.isFasting ? 1 : 2);
  int get dailyExerciseTime =>
      preferences.doExercise ? preferences.defaultExerciseDuration : 0;
  int get dailyOutdoorTime =>
      preferences.doOutdoor ? preferences.defaultOutdoorDuration : 0;
  int get dailyShallowWorkTime =>
      preferences.doShallowWork ? preferences.defaultShallowWorkDuration : 0;
  int get dailySocialTime =>
      preferences.doSocial ? preferences.defaultSocialDuration : 0;
  int get dailyFluxTime =>
      preferences.doFlux ? preferences.defaultFluxDuration : 0;
  int get dailyOtakuTime =>
      preferences.doOtaku ? preferences.defaultOtakuDuration : 0;

  bool isScheduleViable() {
    int totalWeeklyTime = calculateTotalWeeklyTime();
    return totalWeeklyTime <= minutesPerDay * 7;
  }

  bool isDayScheduleViable(String dayOfWeek) {
    int totalDailyTime = calculateTotalDailyTime(dayOfWeek);
    return totalDailyTime <= minutesPerDay;
  }

  int calculateTotalWeeklyTime() {
    return dailyDeepWorkTime * 7 +
        dailyLearningTime * 7 +
        dailyMeditationTime * 7 +
        dailyRestTime * 7 +
        dailyTediumTime * 7 +
        dailyMealTime * 7 +
        dailyExerciseTime * preferences.weeklyHighIntensityExerciseBlocks +
        dailyOutdoorTime * preferences.weeklyOutdoorBlocks +
        dailyShallowWorkTime * preferences.weeklyShallowWorkBlocks +
        dailySocialTime * preferences.weeklySocialBlocks +
        dailyFluxTime * preferences.weeklyFluxBlocks +
        dailyOtakuTime * preferences.weeklyOtakuBlocks;
  }

  int calculateTotalDailyTime(String dayOfWeek) {
    return dailyDeepWorkTime +
        dailyLearningTime +
        dailyMeditationTime +
        dailyRestTime +
        dailyTediumTime +
        dailyMealTime +
        dailyExerciseTime +
        dailyOutdoorTime +
        dailyShallowWorkTime +
        dailySocialTime +
        dailyFluxTime +
        dailyOtakuTime;
  }
}
