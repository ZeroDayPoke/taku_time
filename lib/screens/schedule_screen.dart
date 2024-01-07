import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/block.dart';
import '../widgets/block_card.dart';
import '../bloc/schedule_builder_bloc.dart';
import '../bloc/schedule_builder_state.dart';
import '../bloc/schedule_builder_event.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      // body: BlocBuilder<ScheduleBuilderBloc, ScheduleBuilderState>(
      //   builder: (context, scheduleState) {
      //     if (scheduleState is ScheduleBuildingComplete) {
      //       return _buildScheduleContent(scheduleState.weeklySchedule);
      //     } else if (scheduleState is ScheduleBuildingInProgress) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else {
      //       return const Center(child: Text('Failed to load schedule'));
      //     }
      //   },
      // ),
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
