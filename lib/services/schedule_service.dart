import 'package:taku_time/models/user_preferences.dart';
import 'package:taku_time/models/block.dart';
import 'package:taku_time/services/block_allocators.dart';
import 'package:taku_time/utils/schedule_validator.dart';

class ScheduleService {
  final UserPreferences userPreferences;
  final ScheduleValidator scheduleValidator;

  ScheduleService(this.userPreferences)
      : scheduleValidator = ScheduleValidator(userPreferences);

  Map<String, List<Block>> generateWeeklyPlan(
      UserPreferences userPreferences, List<Block> blocks) {
    if (!scheduleValidator.isScheduleViable()) {
      throw Exception('User preferences lead to a non-viable weekly schedule.');
    }

    Map<String, List<Block>> weeklyPlan = {};
    DateTime today = DateTime.now();

    // Instantiate allocators
    var necessityAllocator = NecessityBlockAllocator();
    var stressAllocator = StressBlockAllocator();
    var exerciseAllocator = ExerciseBlockAllocator();
    var relaxAllocator = RelaxBlockAllocator();

    for (var day in daysOfWeek) {
      weeklyPlan[day] = [];
      DateTime dayDate = today
          .add(Duration(days: daysOfWeek.indexOf(day) - today.weekday + 1));

      weeklyPlan[day]
          ?.addAll(necessityAllocator.allocateBlocks(userPreferences, dayDate));
      weeklyPlan[day]
          ?.addAll(stressAllocator.allocateBlocks(userPreferences, dayDate));
      weeklyPlan[day]
          ?.addAll(exerciseAllocator.allocateBlocks(userPreferences, dayDate));
      weeklyPlan[day]
          ?.addAll(relaxAllocator.allocateBlocks(userPreferences, dayDate));

      // Check if the daily schedule is viable
      if (!scheduleValidator.isDayScheduleViable(day)) {
        throw Exception('Schedule for $day is not viable.');
      }
      weeklyPlan[day] = _arrangeDailyBlocks(weeklyPlan[day]!, dayDate);
    }

    return weeklyPlan;
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

  List<Block> _arrangeDailyBlocks(List<Block> blocks, DateTime dayDate) {
    DateTime startTime = DateTime(dayDate.year, dayDate.month, dayDate.day)
        .add(const Duration(days: 1));

    List<Block> stressBlocks =
        blocks.where((b) => b.type.category == BlockCategory.stress).toList();
    List<Block> relaxBlocks =
        blocks.where((b) => b.type.category == BlockCategory.relax).toList();
    List<Block> necessityBlocks = blocks
        .where((b) => b.type.category == BlockCategory.inevitable)
        .toList();
    List<Block> arrangedBlocks = [];

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
