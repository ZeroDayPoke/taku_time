import '../models/user_preferences.dart';
import '../models/block.dart';

class ScheduleService {
  final UserPreferences userPreferences;

  ScheduleService(this.userPreferences);

  Map<String, List<Block>> generateWeeklyPlan() {
    Map<String, List<Block>> weeklyPlan = {};

    DateTime today = DateTime.now();

    for (var day in daysOfWeek) {
      weeklyPlan[day] = [];
    }

    _mergeBlockLists(weeklyPlan, allocateNecessityBlocks());
    _mergeBlockLists(weeklyPlan, allocateStressBlocks());
    _mergeBlockLists(weeklyPlan, allocateExerciseBlocks());
    _mergeBlockLists(
        weeklyPlan,
        _allocateGenericBlocks(
            BlockType.outdoor,
            userPreferences.weeklyOutdoorBlocks,
            userPreferences.defaultOutdoorDuration));
    _mergeBlockLists(
        weeklyPlan,
        _allocateGenericBlocks(
            BlockType.social,
            userPreferences.weeklySocialBlocks,
            userPreferences.defaultSocialDuration));
    _mergeBlockLists(
        weeklyPlan,
        _allocateGenericBlocks(
            BlockType.meditation,
            userPreferences.dailyMeditationSessions * 7,
            userPreferences.defaultMeditationDuration));
    _mergeBlockLists(
        weeklyPlan,
        _allocateGenericBlocks(BlockType.flux, userPreferences.weeklyFluxBlocks,
            userPreferences.defaultFluxDuration));
    _mergeBlockLists(
        weeklyPlan,
        _allocateGenericBlocks(
            BlockType.shallowWork,
            userPreferences.weeklyShallowWorkBlocks,
            userPreferences.defaultShallowWorkDuration));
    _mergeBlockLists(
        weeklyPlan,
        _allocateGenericBlocks(
            BlockType.otaku,
            userPreferences.weeklyOtakuBlocks,
            userPreferences.defaultOtakuDuration));

    for (var day in daysOfWeek) {
      DateTime dayDate = today
          .add(Duration(days: daysOfWeek.indexOf(day) - today.weekday + 1));
      weeklyPlan[day] = _arrangeDailyBlocks(weeklyPlan[day]!, dayDate);
    }

    return weeklyPlan;
  }

  List<Block> _arrangeDailyBlocks(List<Block> blocks, DateTime dayDate) {
    DateTime startTime = DateTime(dayDate.year, dayDate.month, dayDate.day)
        .add(const Duration(days: 1));

    List<Block> stressBlocks =
        blocks.where((b) => b.category == BlockCategory.stress).toList();
    List<Block> relaxBlocks =
        blocks.where((b) => b.category == BlockCategory.relax).toList();
    List<Block> arrangedBlocks = [];
    List<Block> necessityBlocks =
        blocks.where((b) => b.category == BlockCategory.inevitable).toList();

    arrangedBlocks.addAll(necessityBlocks);

    while (stressBlocks.isNotEmpty || relaxBlocks.isNotEmpty) {
      if (stressBlocks.isNotEmpty) {
        Block nextStressBlock = stressBlocks.removeAt(0);
        nextStressBlock.startTime = _findNextAvailableTime(
            arrangedBlocks, nextStressBlock.duration, startTime);
        arrangedBlocks.add(nextStressBlock);
        startTime = nextStressBlock.endTime;
      }

      if (relaxBlocks.isNotEmpty) {
        Block nextRelaxBlock = relaxBlocks.removeAt(0);
        nextRelaxBlock.startTime = _findNextAvailableTime(
            arrangedBlocks, nextRelaxBlock.duration, startTime);
        arrangedBlocks.add(nextRelaxBlock);
        startTime = nextRelaxBlock.endTime;
      }
    }

    arrangedBlocks.sort((a, b) => a.startTime.compareTo(b.startTime));

    return arrangedBlocks;
  }

  DateTime _findNextAvailableTime(
      List<Block> blocks, int duration, DateTime proposedStartTime) {
    DateTime nextAvailableTime = proposedStartTime;

    for (var block in blocks) {
      if (nextAvailableTime.isBefore(block.startTime) &&
          block.startTime.difference(nextAvailableTime).inMinutes >= duration) {
        return nextAvailableTime;
      }

      if (!nextAvailableTime.isBefore(block.startTime) &&
          !nextAvailableTime.isAfter(block.endTime)) {
        nextAvailableTime = block.endTime;
      }
    }

    return nextAvailableTime;
  }

  void _mergeBlockLists(
      Map<String, List<Block>> mainMap, Map<String, List<Block>> toMerge) {
    toMerge.forEach((day, blocks) {
      mainMap[day]?.addAll(blocks);
    });
  }

  Map<String, List<Block>> allocateNecessityBlocks() {
    Map<String, List<Block>> necessityPlan = {};
    bool isFastingDay = userPreferences.isFasting;
    DateTime today = DateTime.now();

    for (int i = 0; i < daysOfWeek.length; i++) {
      DateTime dayDate = today
          .add(Duration(days: i - today.weekday + 1))
          .add(const Duration(days: 1));
      DateTime endOfDay =
          DateTime(dayDate.year, dayDate.month, dayDate.day, 23, 59);
      DateTime startOfDay =
          DateTime(dayDate.year, dayDate.month, dayDate.day, 0, 0);

      necessityPlan[daysOfWeek[i]] = [
        RestBlock(
            duration: userPreferences.defaultRestDuration,
            startTime: startOfDay),
        TediumBlock(
            duration: userPreferences.defaultTediumDuration,
            startTime: startOfDay
                .add(Duration(minutes: userPreferences.defaultRestDuration))),
      ];

      DateTime lastMealTime = endOfDay.subtract(const Duration(minutes: 29));

      if (!isFastingDay) {
        DateTime mealTime = lastMealTime.subtract(const Duration(hours: 4));
        necessityPlan[daysOfWeek[i]]?.add(MealBlock(
            duration: userPreferences.defaultMealDuration,
            isFastingDay: false,
            startTime: mealTime));
      }

      necessityPlan[daysOfWeek[i]]?.add(MealBlock(
          duration: userPreferences.defaultMealDuration,
          isFastingDay: isFastingDay,
          startTime: lastMealTime));

      if (userPreferences.isFasting) {
        isFastingDay = !isFastingDay;
      }
    }

    return necessityPlan;
  }

  Map<String, List<Block>> allocateExerciseBlocks() {
    Map<String, List<Block>> exercisePlan = {};
    int highIntensityCount = userPreferences.weeklyHighIntensityExerciseBlocks;
    int interval = highIntensityCount > 0
        ? max(1, daysOfWeek.length ~/ highIntensityCount)
        : 0;
    int highIntensityDayIndex = 0;
    DateTime startTime = DateTime.now();

    for (var day in daysOfWeek) {
      List<Block> dayBlocks = [];

      dayBlocks.addAll(List.generate(
        3,
        (_) => ExerciseBlock(
            type: BlockType.lowIntensityExercise,
            duration: userPreferences.defaultExerciseDuration,
            isHighIntensity: false,
            startTime: startTime),
      ));

      if (highIntensityDayIndex % interval == 0 && highIntensityCount > 0) {
        dayBlocks[dayBlocks.length - 1] = ExerciseBlock(
            type: BlockType.highIntensityExercise,
            duration: userPreferences.defaultExerciseDuration,
            isHighIntensity: true,
            startTime: startTime);
        highIntensityCount--;
      }

      highIntensityDayIndex++;
      exercisePlan[day] = dayBlocks;
    }
    return exercisePlan;
  }

  Map<String, List<Block>> allocateStressBlocks() {
    Map<String, List<Block>> stressPlan = {};
    DateTime startTime = DateTime.now();

    for (var day in daysOfWeek) {
      List<Block> dayStressBlocks = [];

      dayStressBlocks.addAll(List.generate(
        userPreferences.dailyDeepWorkSessions,
        (_) => DeepWorkBlock(
            duration: userPreferences.defaultDeepWorkDuration,
            startTime: startTime),
      ));

      dayStressBlocks.addAll(List.generate(
        userPreferences.dailyLearningSessions,
        (_) => LearningBlock(
            duration: userPreferences.defaultLearningDuration,
            startTime: startTime),
      ));

      stressPlan[day] = dayStressBlocks;
    }
    return stressPlan;
  }

  Map<String, List<Block>> _allocateGenericBlocks(
      BlockType type, int totalBlocks, int defaultDuration) {
    Map<String, List<Block>> plan = {};
    int blocksPerDay = totalBlocks ~/ daysOfWeek.length;
    int extraBlocks = totalBlocks % daysOfWeek.length;
    DateTime startTime = DateTime.now();

    for (var day in daysOfWeek) {
      List<Block> dayBlocks = List.generate(
        blocksPerDay,
        (_) => _createBlockOfType(type, defaultDuration, startTime),
      );
      plan[day] = dayBlocks;
    }

    List<String> shuffledDays = [...daysOfWeek]..shuffle();
    for (int i = 0; i < extraBlocks; i++) {
      String day = shuffledDays[i % daysOfWeek.length];
      plan[day]?.add(_createBlockOfType(type, defaultDuration, startTime));
    }

    return plan;
  }

  Block _createBlockOfType(BlockType type, int duration, DateTime startTime) {
    switch (type) {
      case BlockType.deepWork:
        return DeepWorkBlock(duration: duration, startTime: startTime);
      case BlockType.learning:
        return LearningBlock(duration: duration, startTime: startTime);
      case BlockType.social:
        return SocialBlock(duration: duration, startTime: startTime);
      case BlockType.flux:
        return FluxBlock(duration: duration, startTime: startTime);
      case BlockType.shallowWork:
        return ShallowWorkBlock(duration: duration, startTime: startTime);
      case BlockType.meditation:
        return MeditationBlock(duration: duration, startTime: startTime);
      case BlockType.outdoor:
        return OutdoorBlock(duration: duration, startTime: startTime);
      case BlockType.otaku:
        return OtakuBlock(duration: duration, startTime: startTime);
      default:
        return Block(type: type, duration: duration, startTime: startTime);
    }
  }

  List<String> get daysOfWeek => [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
}

int max(int a, int b) => (a > b) ? a : b;
