// file: database_helper.dart
import 'my_database.dart';
import '../models/block.dart' as block_model;
import '../models/schedule.dart' as schedule_model;
import 'package:drift/drift.dart';

class DatabaseHelper {
  final MyDatabase _db = MyDatabase.instance;

  Future<List<Block>> getBlocks() async {
    return _db.getAllBlocks();
  }

  Future<void> insertBlock(block_model.Block block) async {
    return _db.insertBlock(BlocksCompanion.insert(
      type: block.type.toString(),
      duration: block.duration,
      minuteOfWeek: block.minuteOfWeek,
      isScheduled: block.isScheduled,
      origin: block.origin.toString(),
      priority: block.priority,
      note: Value(block.note),
      isRecurring: block.isRecurring,
    ));
  }

  Future<void> updateBlock(block_model.Block block) async {
    return _db.updateBlock(BlocksCompanion.insert(
      id: Value(block.id),
      type: block.type.toString(),
      duration: block.duration,
      minuteOfWeek: block.minuteOfWeek,
      isScheduled: block.isScheduled,
      origin: block.origin.toString(),
      priority: block.priority,
      note: Value(block.note),
      isRecurring: block.isRecurring,
    ));
  }

  Future<void> deleteBlock(int id) async {
    return _db.deleteBlock(id);
  }

  Future<List<Block>> getBlocksOfType(String type) async {
    return _db.getBlocksOfType(type);
  }

  Future<List<Schedule>> getSchedules() async {
    return _db.getAllSchedules();
  }

  Future<void> insertSchedule(schedule_model.Schedule schedule) async {
    final insertableSchedule = SchedulesCompanion.insert(
      name: schedule.name,
      startDate: schedule.startDate.toIso8601String(),
      isActive: schedule.isActive,
      generatedOn: schedule.generatedOn.toIso8601String(),
    );
    return _db.insertSchedule(insertableSchedule);
  }

  Future<void> updateSchedule(schedule_model.Schedule schedule) async {
    final insertableSchedule = SchedulesCompanion.insert(
      id: Value(schedule.id),
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
    await _db.customSetActiveSchedule(scheduleId);
  }

  Future<Schedule?> getActiveSchedule() async {
    return _db.getActiveSchedule();
  }
}
