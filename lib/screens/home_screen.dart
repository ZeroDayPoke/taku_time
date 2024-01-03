import 'package:flutter/material.dart';
import '../services/schedule_service.dart';
import '../models/user_preferences.dart';
import '../models/block.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Map<String, List<Block>> weeklySchedule;

  @override
  void initState() {
    super.initState();
    generateSchedule();
  }

  void generateSchedule() {
    UserPreferences defaultPreferences = UserPreferences.defaultPreferences();
    ScheduleService scheduleService = ScheduleService(defaultPreferences);
    weeklySchedule = scheduleService.generateWeeklyPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Schedule'),
      ),
      body: ListView.builder(
        itemCount: weeklySchedule.keys.length,
        itemBuilder: (context, index) {
          String day = weeklySchedule.keys.elementAt(index);
          return ListTile(
            title: Text(day),
            subtitle: Text(weeklySchedule[day]!
                .map((block) => block.type.toString())
                .join(', ')),
          );
        },
      ),
    );
  }
}
