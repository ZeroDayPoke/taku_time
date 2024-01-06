// file: tables/block_table.dart
import 'package:drift/drift.dart';
import 'schedule_table.dart';

@DataClassName('Block')
class Blocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text().withLength(min: 1)();
  IntColumn get duration => integer()();
  IntColumn get minuteOfWeek => integer()();
  BoolColumn get isScheduled => boolean()();
  TextColumn get origin => text()();
  IntColumn get priority => integer()();
  TextColumn get note => text().nullable()();
  BoolColumn get isRecurring => boolean()();
  IntColumn get scheduleId =>
      integer().nullable().customConstraint('NULL REFERENCES Schedules(id)')();
}
