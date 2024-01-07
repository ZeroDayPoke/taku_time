import 'package:flutter/material.dart';
import 'exercise_block_card.dart';
import 'rest_block_card.dart';
import 'tedium_block_card.dart';
import 'meal_block_card.dart';
import 'relax_block_card.dart';
import 'stress_block_card.dart';

class SettingsListView extends StatelessWidget {
  const SettingsListView({Key? key}) : super(key: key);

  static const double minSliderValue = 0;
  static const double maxSliderValue = 120;
  static const double maxNumberSliderValue = 20;
  static const int sliderDivisions = 10;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth < 600 ? 1 : 3;

        return ListView(
          children: [
            _buildSectionTitle('Relax Blocks'),
            _buildCardGrid([
              const RelaxBlockCard(
                activityName: 'Otaku',
                durationKeyName: 'defaultOtakuDuration',
                weeklySessionsKeyName: 'weeklyOtakuBlocks',
                enableKeyName: 'doOtaku',
              ),
              const RelaxBlockCard(
                activityName: 'Meditation',
                durationKeyName: 'defaultMeditationDuration',
                enableKeyName: 'doMeditation',
                weeklySessionsKeyName: 'dailyMeditationSessions',
              ),
              const RelaxBlockCard(
                activityName: 'Outdoor',
                durationKeyName: 'defaultOutdoorDuration',
                enableKeyName: 'doOutdoor',
                weeklySessionsKeyName: 'weeklyOutdoorBlocks',
              ),
              const RelaxBlockCard(
                activityName: 'ShallowWork',
                durationKeyName: 'defaultShallowWorkDuration',
                enableKeyName: 'doShallowWork',
                weeklySessionsKeyName: 'weeklyShallowWorkBlocks',
              ),
              const RelaxBlockCard(
                activityName: 'Social',
                durationKeyName: 'defaultSocialDuration',
                enableKeyName: 'doSocial',
                weeklySessionsKeyName: 'weeklySocialBlocks',
              ),
              const RelaxBlockCard(
                activityName: 'Flux',
                durationKeyName: 'defaultFluxDuration',
                enableKeyName: 'doFlux',
                weeklySessionsKeyName: 'weeklyFluxBlocks',
              ),
            ], crossAxisCount),
            _buildSectionTitle('Stress Blocks'),
            _buildCardGrid([
              const StressBlockCard(
                activityName: 'Deep Work',
                durationKeyName: 'defaultDeepWorkDuration',
                sessionKeyName: 'dailyDeepWorkSessions',
              ),
              const StressBlockCard(
                activityName: 'Learning',
                durationKeyName: 'defaultLearningDuration',
                sessionKeyName: 'dailyLearningSessions',
              ),
            ], crossAxisCount),
            _buildSectionTitle('Inevitable Blocks'),
            _buildCardGrid([
              const TediumBlockCard(),
              const ExerciseBlockCard(),
              const MealBlockCard(),
              const RestBlockCard(),
            ], crossAxisCount),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCardGrid(List<Widget> cards, int crossAxisCount) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: 3 / 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: cards,
    );
  }
}
