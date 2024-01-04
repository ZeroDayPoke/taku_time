import 'package:flutter_test/flutter_test.dart';
import 'package:taku_time/models/block.dart';
import 'package:taku_time/services/schedule_service.dart';
import 'package:taku_time/models/user_preferences.dart';

void main() {
  group('Schedule Service Tests', () {
    late ScheduleService service;
    late UserPreferences preferences;
    late Map<String, List<Block>> schedule;
    late List<Block> blocks;

    setUp(() {
      preferences = UserPreferences(
          // test defaults
          );
      blocks = [];
      service = ScheduleService(preferences);
      schedule = service.generateWeeklyPlan(preferences, blocks);
    });

    test('Generates Correct Number of Deep Work Blocks', () {
      int deepWorkCount = countBlocksOfType(schedule, BlockType.deepWork);
      expect(deepWorkCount, 28);
    });

    test('Generates Correct Number of Learning Blocks', () {
      int learningCount = countBlocksOfType(schedule, BlockType.learning);
      expect(learningCount, 14);
    });

    test('Generates Correct Number of Meal Blocks', () {
      int mealCount = countBlocksOfType(schedule, BlockType.meal);
      expect(mealCount, 10);
    });

    test('Generates Correct Number of Social Blocks', () {
      int socialCount = countBlocksOfType(schedule, BlockType.social);
      expect(socialCount, preferences.weeklySocialBlocks);
    });

    test('Generates Correct Number of Flux Blocks', () {
      int fluxCount = countBlocksOfType(schedule, BlockType.flux);
      expect(fluxCount, preferences.weeklyFluxBlocks);
    });

    test('Generates Correct Number of Shallow Work Blocks', () {
      int shallowWorkCount = countBlocksOfType(schedule, BlockType.shallowWork);
      expect(shallowWorkCount, preferences.weeklyShallowWorkBlocks);
    });

    test('Generates Correct Number of Meditation Blocks', () {
      int meditationCount = countBlocksOfType(schedule, BlockType.meditation);
      expect(meditationCount, preferences.dailyMeditationSessions * 7);
    });

    test('Generates Correct Number of Outdoor Blocks', () {
      int outdoorCount = countBlocksOfType(schedule, BlockType.outdoor);
      expect(outdoorCount, preferences.weeklyOutdoorBlocks);
    });

    test('Generates Correct Number of Otaku Blocks', () {
      int otakuCount = countBlocksOfType(schedule, BlockType.otaku);
      expect(otakuCount, preferences.weeklyOtakuBlocks);
    });

    test('Generates Correct Number of Exercise Blocks', () {
      int exerciseCount =
          countBlocksOfType(schedule, BlockType.lowIntensityExercise) +
              countBlocksOfType(schedule, BlockType.highIntensityExercise);
      expect(exerciseCount,
          preferences.enableHighIntensityExercise ? 7 * 3 : 7 * 2);
    });

    test('Generates Correct Number of Rest Blocks', () {
      int restCount = countBlocksOfType(schedule, BlockType.rest);
      expect(restCount, 7);
    });

    test('Generates Correct Number of Tedium Blocks', () {
      int tediumCount = countBlocksOfType(schedule, BlockType.tedium);
      expect(tediumCount, 7);
    });

    test('Weekly Plan Covers All Days of the Week', () {
      expect(
          schedule.keys.toSet(),
          equals({
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday'
          }));
    });
  });
}

int countBlocksOfType(Map<String, List<Block>> schedule, BlockType type) {
  return schedule.values
      .expand((blocks) => blocks)
      .where((block) => block.type == type)
      .length;
}
