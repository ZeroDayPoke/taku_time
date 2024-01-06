// import '../models/block.dart';
// import 'dart:math' as math;
// import '../models/user_preferences.dart';

// abstract class BlockAllocator {
//   List<Block> allocateBlocks(UserPreferences preferences, DateTime startTime);
// }

// class NecessityBlockAllocator extends BlockAllocator {
//   @override
//   List<Block> allocateBlocks(UserPreferences preferences, DateTime startTime) {
//     List<Block> necessityBlocks = [];

//     // Rest and Tedium Blocks
//     necessityBlocks.add(RestBlock(
//         duration: preferences.defaultRestDuration,
//         startTime: startTime.add(Duration(
//             hours: preferences.sleepTimeHour,
//             minutes: preferences.sleepTimeMinute)),
//         origin: BlockOrigin.generated,
//         isScheduled: true,
//         note: 'Rest Time',
//         isRecurring: true));
//     necessityBlocks.add(TediumBlock(
//         duration: preferences.defaultTediumDuration,
//         startTime: startTime.add(Duration(
//             hours: preferences.sleepTimeHour,
//             minutes:
//                 preferences.defaultRestDuration + preferences.sleepTimeMinute)),
//         origin: BlockOrigin.generated,
//         isScheduled: true,
//         note: 'Tedium Time',
//         isRecurring: true));

//     // Meal Blocks
//     if (!preferences.isFasting) {
//       necessityBlocks.add(MealBlock(
//           duration: preferences.defaultMealDuration,
//           isFastingDay: false,
//           startTime: startTime.add(Duration(
//               hours: preferences.mealTimeHour + 3,
//               minutes: preferences.mealTimeMinute + 30)),
//           origin: BlockOrigin.generated,
//           isScheduled: true,
//           note: 'Meal Time',
//           isRecurring: true));
//     }
//     necessityBlocks.add(MealBlock(
//         duration: preferences.defaultMealDuration,
//         isFastingDay: preferences.isFasting,
//         startTime: startTime.add(Duration(
//             hours: preferences.mealTimeHour,
//             minutes: preferences.mealTimeMinute)),
//         origin: BlockOrigin.generated,
//         isScheduled: true,
//         note: 'Meal Time',
//         isRecurring: true));

//     return necessityBlocks;
//   }
// }

// class ExerciseBlockAllocator extends BlockAllocator {
//   @override
//   List<Block> allocateBlocks(UserPreferences preferences, DateTime startTime) {
//     List<Block> exerciseBlocks = [];
//     int highIntensityCount = preferences.weeklyHighIntensityExerciseBlocks;
//     int interval = highIntensityCount > 0
//         ? math.max(1, daysOfWeek.length ~/ highIntensityCount)
//         : 0;
//     int highIntensityDayIndex = 0;

//     for (int i = 0; i < daysOfWeek.length; i++) {
//       if (preferences.doExercise) {
//         exerciseBlocks.addAll(List.generate(
//           3,
//           (_) => ExerciseBlock(
//               type: (highIntensityDayIndex % interval == 0 &&
//                       highIntensityCount > 0)
//                   ? BlockType.highIntensityExercise
//                   : BlockType.lowIntensityExercise,
//               duration: preferences.defaultExerciseDuration,
//               isHighIntensity: highIntensityDayIndex % interval == 0 &&
//                   highIntensityCount > 0,
//               startTime: startTime,
//               origin: BlockOrigin.generated,
//               isScheduled: true,
//               note: 'Exercise Time',
//               isRecurring: true),
//         ));

//         if (highIntensityDayIndex % interval == 0 && highIntensityCount > 0) {
//           highIntensityCount--;
//         }
//         highIntensityDayIndex++;
//       }
//     }

//     return exerciseBlocks;
//   }
// }

// class StressBlockAllocator extends BlockAllocator {
//   @override
//   List<Block> allocateBlocks(UserPreferences preferences, DateTime startTime) {
//     List<Block> stressBlocks = [];

//     // Deep Work and Learning Blocks
//     for (int i = 0; i < preferences.dailyDeepWorkSessions; i++) {
//       stressBlocks.add(DeepWorkBlock(
//           duration: preferences.defaultDeepWorkDuration,
//           startTime: startTime,
//           origin: BlockOrigin.generated,
//           isScheduled: true,
//           note: 'Deep Work Session',
//           isRecurring: true));
//     }
//     for (int i = 0; i < preferences.dailyLearningSessions; i++) {
//       stressBlocks.add(LearningBlock(
//           duration: preferences.defaultLearningDuration,
//           startTime: startTime,
//           origin: BlockOrigin.generated,
//           isScheduled: true,
//           note: 'Learning Session',
//           isRecurring: true));
//     }

//     return stressBlocks;
//   }
// }

// class RelaxBlockAllocator extends BlockAllocator {
//   @override
//   List<Block> allocateBlocks(UserPreferences preferences, DateTime startTime) {
//     List<Block> relaxBlocks = [];

//     if (preferences.doMeditation) {
//       relaxBlocks.addAll(_allocateBlocksForType(
//           BlockType.meditation,
//           preferences.dailyMeditationSessions,
//           preferences.defaultMeditationDuration,
//           startTime));
//     }
//     if (preferences.doOutdoor) {
//       relaxBlocks.addAll(_allocateBlocksForType(
//           BlockType.outdoor,
//           preferences.weeklyOutdoorBlocks,
//           preferences.defaultOutdoorDuration,
//           startTime));
//     }
//     if (preferences.doOtaku) {
//       relaxBlocks.addAll(_allocateBlocksForType(
//           BlockType.otaku,
//           preferences.weeklyOtakuBlocks,
//           preferences.defaultOtakuDuration,
//           startTime));
//     }
//     if (preferences.doSocial) {
//       relaxBlocks.addAll(_allocateBlocksForType(
//           BlockType.social,
//           preferences.weeklySocialBlocks,
//           preferences.defaultSocialDuration,
//           startTime));
//     }
//     if (preferences.doFlux) {
//       relaxBlocks.addAll(_allocateBlocksForType(
//           BlockType.flux,
//           preferences.weeklyFluxBlocks,
//           preferences.defaultFluxDuration,
//           startTime));
//     }
//     if (preferences.doShallowWork) {
//       relaxBlocks.addAll(_allocateBlocksForType(
//           BlockType.shallowWork,
//           preferences.weeklyShallowWorkBlocks,
//           preferences.defaultShallowWorkDuration,
//           startTime));
//     }

//     return relaxBlocks;
//   }

//   List<Block> _allocateBlocksForType(
//       BlockType type, int frequency, int duration, DateTime startTime) {
//     return List.generate(
//       frequency,
//       (_) => Block(
//           type: type,
//           duration: duration,
//           origin: BlockOrigin.generated,
//           isScheduled: true,
//           note: '${type.toString().split('.').last} Time',
//           isRecurring: true),
//     );
//   }
// }

// // Util function
// int max(int a, int b) => math.max(a, b);

// // Define daysOfWeek
// List<String> get daysOfWeek => [
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday',
//       'Sunday'
//     ];
