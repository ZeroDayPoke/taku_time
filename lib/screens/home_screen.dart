import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/schedule_bloc.dart';
import '../bloc/schedule_state.dart';
import '../bloc/user_preferences_event.dart';
import '../bloc/user_preferences_bloc.dart';
import '../models/block.dart';
import '../widgets/block_card.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Map<String, List<Block>> weeklySchedule = {};
  late Map<BlockType, int> weeklySummary = {};

  @override
  void initState() {
    super.initState();
    loadPreferencesAndGenerateSchedule();
  }

  void loadPreferencesAndGenerateSchedule() {
    // Dispatch LoadUserPreferences event
    BlocProvider.of<UserPreferencesBloc>(context).add(LoadUserPreferences());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ).then((_) => loadPreferencesAndGenerateSchedule());
            },
          ),
        ],
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoadSuccess) {
            weeklySchedule = state.weeklySchedule;
            calculateWeeklySummary();
            return _buildScheduleContent();
          } else if (state is ScheduleLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Handle failure or initial state
            return Center(
              child: Text(state is ScheduleLoadFailure
                  ? 'Failed to load schedule'
                  : 'Loading...'),
            );
          }
        },
      ),
    );
  }

  Widget _buildScheduleContent() {
    return Column(
      children: [
        _buildWeeklySummary(),
        Expanded(
          child: ListView.builder(
            itemCount: weeklySchedule.keys.length,
            itemBuilder: (context, index) {
              String day = weeklySchedule.keys.elementAt(index);
              List<Block> dayBlocks = weeklySchedule[day] ?? [];
              return ExpansionTile(
                title: Text(day),
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: dayBlocks
                          .map((block) => BlockCard(block: block))
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void calculateWeeklySummary() {
    weeklySummary = {};
    for (var blocks in weeklySchedule.values) {
      for (var block in blocks) {
        weeklySummary.update(
          block.type,
          (value) => value + block.duration,
          ifAbsent: () => block.duration,
        );
      }
    }
  }

  Widget _buildWeeklySummary() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Summary:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (BlockType type in weeklySummary.keys)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: BlockCard(
                      block: Block(
                        type: type,
                        duration: weeklySummary[type] ?? 0,
                        startTime: DateTime.now(),
                      ),
                      showStartTime: false,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
