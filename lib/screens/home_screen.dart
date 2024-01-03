import 'package:flutter/material.dart';
import '../services/schedule_service.dart';
import '../models/user_preferences.dart';
import '../models/block.dart';
import '../widgets/block_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Map<String, List<Block>> weeklySchedule;
  late int totalWeeklyDuration;
  late Map<String, int> dailyBufferTime;

  @override
  void initState() {
    super.initState();
    generateSchedule();
    calculateMetrics();
  }

  void generateSchedule() {
    UserPreferences defaultPreferences = UserPreferences.defaultPreferences();
    ScheduleService scheduleService = ScheduleService(defaultPreferences);
    weeklySchedule = scheduleService.generateWeeklyPlan();
  }

  void calculateMetrics() {
    totalWeeklyDuration = 0;
    dailyBufferTime = {};
    int dailyAvailableHours = 24;

    weeklySchedule.forEach((day, blocks) {
      int dailyDuration = blocks.fold(0, (sum, block) => sum + block.duration);
      totalWeeklyDuration += dailyDuration;
      dailyBufferTime[day] = (dailyAvailableHours * 60) - dailyDuration;
    });
  }

  String get weeklyTimeAllocationPercentage {
    int totalWeeklyAvailableTime = 7 * 24 * 60;
    double percentage = totalWeeklyDuration / totalWeeklyAvailableTime * 100;
    return "${percentage.toStringAsFixed(2)}%";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Schedule'),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Weekly Time Allocated: $weeklyTimeAllocationPercentage',
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: weeklySchedule.keys.length,
              itemBuilder: (context, index) {
                String day = weeklySchedule.keys.elementAt(index);
                List<Block> dayBlocks = weeklySchedule[day]!;
                int bufferTime = dailyBufferTime[day] ?? 0;

                return ExpansionTile(
                  backgroundColor: Colors.grey[850],
                  title: Text(
                    '$day (Buffer Time: $bufferTime min)',
                    style: const TextStyle(color: Colors.white),
                  ),
                  children: dayBlocks
                      .map((block) => BlockCard(block: block))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
