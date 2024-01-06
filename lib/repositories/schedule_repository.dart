import 'package:flutter/material.dart';
import 'package:taku_time/database/my_database.dart';
import 'package:taku_time/models/schedule.dart' as model;
import 'package:taku_time/models/block.dart' as model;

class ScheduleRepository {
  final MyDatabase _db = MyDatabase.instance;

  Future<model.Schedule?> getCurrentActiveSchedule() async {
    try {
      var scheduleData = await _db.getActiveScheduleData();
      if (scheduleData != null) {
        var blocksData = await _db.getBlocksForSchedule(scheduleData.id);
        List<model.Block> blocks = blocksData
            .map((blockData) => model.Block(
                  id: blockData.id,
                  type: model.BlockType.values.firstWhere(
                      (e) => e.toString() == 'BlockType.${blockData.type}'),
                  duration: blockData.duration,
                  minuteOfWeek: blockData.minuteOfWeek,
                  isScheduled: blockData.isScheduled,
                  origin: model.BlockOrigin.values.firstWhere(
                      (e) => e.toString() == 'BlockOrigin.${blockData.origin}'),
                  note: blockData.note,
                  isRecurring: blockData.isRecurring,
                ))
            .toList();
        return model.Schedule(
          id: scheduleData.id,
          name: scheduleData.name,
          blocks: blocks,
          startDate: DateTime.parse(scheduleData.startDate),
          isActive: scheduleData.isActive,
        );
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Schedule>> getSchedules() async {
    return _db.getAllSchedules();
  }

  Future<void> insertSchedule(model.Schedule schedule) async {
    final insertableSchedule = SchedulesCompanion.insert(
      name: schedule.name,
      startDate: schedule.startDate.toIso8601String(),
      isActive: schedule.isActive,
      generatedOn: schedule.generatedOn.toIso8601String(),
    );
    return _db.insertSchedule(insertableSchedule);
  }

  Future<void> updateSchedule(model.Schedule schedule) async {
    final insertableSchedule = SchedulesCompanion.insert(
      name: schedule.name,
      startDate: schedule.startDate.toIso8601String(),
      isActive: schedule.isActive,
      generatedOn: schedule.generatedOn.toIso8601String(),
    );
    return _db.updateSchedule(insertableSchedule);
  }

  Future<void> deleteSchedule(int id) async {
    return _db.deleteSchedule(id);
  }

  Future<void> setActiveSchedule(int scheduleId) async {
    await _db.setActiveSchedule(scheduleId);
  }
}
