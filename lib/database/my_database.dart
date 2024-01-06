// file: database/my_database.dart
import 'package:drift/drift.dart';
import 'tables/block_table.dart';
import 'tables/schedule_table.dart';
import 'dart:io';
import 'package:drift/native.dart';

part 'my_database.g.dart';

@DriftDatabase(tables: [Blocks, Schedules])
class MyDatabase extends _$MyDatabase {
  static final MyDatabase _instance = MyDatabase._internal();
  static MyDatabase get instance => _instance;

  MyDatabase._internal() : super(NativeDatabase(File('db.sqlite')));

  @override
  int get schemaVersion => 1;

  // CRUD operations for Blocks
  Future<List<Block>> getAllBlocks() => select(blocks).get();
  Future insertBlock(Insertable<Block> block) => into(blocks).insert(block);
  Future updateBlock(Insertable<Block> block) => update(blocks).replace(block);
  Future deleteBlock(int id) =>
      (delete(blocks)..where((tbl) => tbl.id.equals(id))).go();

  Future<List<Block>> getBlocksOfType(String type) {
    return (select(blocks)..where((tbl) => tbl.type.equals(type))).get();
  }

  // CRUD operations for Schedules
  Future<List<Schedule>> getAllSchedules() => select(schedules).get();
  Future insertSchedule(Insertable<Schedule> schedule) =>
      into(schedules).insert(schedule);
  Future updateSchedule(Insertable<Schedule> schedule) =>
      update(schedules).replace(schedule);
  Future deleteSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> setActiveSchedule(int scheduleId) async {
    await (update(schedules)..where((tbl) => tbl.id.equals(scheduleId).not()))
        .write(const SchedulesCompanion(isActive: Value(false)));
    await (update(schedules)..where((tbl) => tbl.id.equals(scheduleId)))
        .write(const SchedulesCompanion(isActive: Value(true)));
  }

  Future<Schedule?> getActiveScheduleData() async {
    var scheduleQuery = select(schedules)
      ..where((tbl) => tbl.isActive.equals(true));
    return await scheduleQuery.getSingleOrNull();
  }

  Future<List<Block>> getBlocksForSchedule(int scheduleId) async {
    var blocksQuery = select(blocks)
      ..where((tbl) => tbl.scheduleId.equals(scheduleId));
    return await blocksQuery.get();
  }
}
