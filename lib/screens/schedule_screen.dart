import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/schedule_bloc.dart';
import '../bloc/schedule_state.dart';
import '../models/block.dart';
import '../widgets/block_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, scheduleState) {
          if (scheduleState is ScheduleLoadSuccess) {
            return _buildScheduleContent(scheduleState.weeklySchedule);
          } else if (scheduleState is ScheduleLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Failed to load schedule'));
          }
        },
      ),
    );
  }

  Widget _buildScheduleContent(Map<String, List<Block>> weeklySchedule) {
    return Column(
      children: [
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
}
