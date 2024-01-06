// file: tables/schedule_table.dart
import 'package:drift/drift.dart';

@DataClassName('Schedule')
class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get startDate => text()();
  BoolColumn get isActive => boolean()();
  TextColumn get generatedOn => text()();
}
