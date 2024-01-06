// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_database.dart';

// ignore_for_file: type=lint
class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _generatedOnMeta =
      const VerificationMeta('generatedOn');
  @override
  late final GeneratedColumn<String> generatedOn = GeneratedColumn<String>(
      'generated_on', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, startDate, isActive, generatedOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(Insertable<Schedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('generated_on')) {
      context.handle(
          _generatedOnMeta,
          generatedOn.isAcceptableOrUnknown(
              data['generated_on']!, _generatedOnMeta));
    } else if (isInserting) {
      context.missing(_generatedOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      generatedOn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}generated_on'])!,
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final String name;
  final String startDate;
  final bool isActive;
  final String generatedOn;
  const Schedule(
      {required this.id,
      required this.name,
      required this.startDate,
      required this.isActive,
      required this.generatedOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<String>(startDate);
    map['is_active'] = Variable<bool>(isActive);
    map['generated_on'] = Variable<String>(generatedOn);
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      name: Value(name),
      startDate: Value(startDate),
      isActive: Value(isActive),
      generatedOn: Value(generatedOn),
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<String>(json['startDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      generatedOn: serializer.fromJson<String>(json['generatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<String>(startDate),
      'isActive': serializer.toJson<bool>(isActive),
      'generatedOn': serializer.toJson<String>(generatedOn),
    };
  }

  Schedule copyWith(
          {int? id,
          String? name,
          String? startDate,
          bool? isActive,
          String? generatedOn}) =>
      Schedule(
        id: id ?? this.id,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        isActive: isActive ?? this.isActive,
        generatedOn: generatedOn ?? this.generatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('isActive: $isActive, ')
          ..write('generatedOn: $generatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, startDate, isActive, generatedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.isActive == this.isActive &&
          other.generatedOn == this.generatedOn);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> startDate;
  final Value<bool> isActive;
  final Value<String> generatedOn;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.generatedOn = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String startDate,
    required bool isActive,
    required String generatedOn,
  })  : name = Value(name),
        startDate = Value(startDate),
        isActive = Value(isActive),
        generatedOn = Value(generatedOn);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? startDate,
    Expression<bool>? isActive,
    Expression<String>? generatedOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (isActive != null) 'is_active': isActive,
      if (generatedOn != null) 'generated_on': generatedOn,
    });
  }

  SchedulesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? startDate,
      Value<bool>? isActive,
      Value<String>? generatedOn}) {
    return SchedulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      isActive: isActive ?? this.isActive,
      generatedOn: generatedOn ?? this.generatedOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (generatedOn.present) {
      map['generated_on'] = Variable<String>(generatedOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('isActive: $isActive, ')
          ..write('generatedOn: $generatedOn')
          ..write(')'))
        .toString();
  }
}

class $BlocksTable extends Blocks with TableInfo<$BlocksTable, Block> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type =
      GeneratedColumn<String>('type', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minuteOfWeekMeta =
      const VerificationMeta('minuteOfWeek');
  @override
  late final GeneratedColumn<int> minuteOfWeek = GeneratedColumn<int>(
      'minute_of_week', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isScheduledMeta =
      const VerificationMeta('isScheduled');
  @override
  late final GeneratedColumn<bool> isScheduled = GeneratedColumn<bool>(
      'is_scheduled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_scheduled" IN (0, 1))'));
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isRecurringMeta =
      const VerificationMeta('isRecurring');
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
      'is_recurring', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_recurring" IN (0, 1))'));
  static const VerificationMeta _scheduleIdMeta =
      const VerificationMeta('scheduleId');
  @override
  late final GeneratedColumn<int> scheduleId = GeneratedColumn<int>(
      'schedule_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES Schedules(id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        duration,
        minuteOfWeek,
        isScheduled,
        origin,
        priority,
        note,
        isRecurring,
        scheduleId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blocks';
  @override
  VerificationContext validateIntegrity(Insertable<Block> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('minute_of_week')) {
      context.handle(
          _minuteOfWeekMeta,
          minuteOfWeek.isAcceptableOrUnknown(
              data['minute_of_week']!, _minuteOfWeekMeta));
    } else if (isInserting) {
      context.missing(_minuteOfWeekMeta);
    }
    if (data.containsKey('is_scheduled')) {
      context.handle(
          _isScheduledMeta,
          isScheduled.isAcceptableOrUnknown(
              data['is_scheduled']!, _isScheduledMeta));
    } else if (isInserting) {
      context.missing(_isScheduledMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
          _isRecurringMeta,
          isRecurring.isAcceptableOrUnknown(
              data['is_recurring']!, _isRecurringMeta));
    } else if (isInserting) {
      context.missing(_isRecurringMeta);
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
          _scheduleIdMeta,
          scheduleId.isAcceptableOrUnknown(
              data['schedule_id']!, _scheduleIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Block map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Block(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      minuteOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}minute_of_week'])!,
      isScheduled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_scheduled'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isRecurring: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_recurring'])!,
      scheduleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schedule_id']),
    );
  }

  @override
  $BlocksTable createAlias(String alias) {
    return $BlocksTable(attachedDatabase, alias);
  }
}

class Block extends DataClass implements Insertable<Block> {
  final int id;
  final String type;
  final int duration;
  final int minuteOfWeek;
  final bool isScheduled;
  final String origin;
  final int priority;
  final String? note;
  final bool isRecurring;
  final int? scheduleId;
  const Block(
      {required this.id,
      required this.type,
      required this.duration,
      required this.minuteOfWeek,
      required this.isScheduled,
      required this.origin,
      required this.priority,
      this.note,
      required this.isRecurring,
      this.scheduleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['duration'] = Variable<int>(duration);
    map['minute_of_week'] = Variable<int>(minuteOfWeek);
    map['is_scheduled'] = Variable<bool>(isScheduled);
    map['origin'] = Variable<String>(origin);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_recurring'] = Variable<bool>(isRecurring);
    if (!nullToAbsent || scheduleId != null) {
      map['schedule_id'] = Variable<int>(scheduleId);
    }
    return map;
  }

  BlocksCompanion toCompanion(bool nullToAbsent) {
    return BlocksCompanion(
      id: Value(id),
      type: Value(type),
      duration: Value(duration),
      minuteOfWeek: Value(minuteOfWeek),
      isScheduled: Value(isScheduled),
      origin: Value(origin),
      priority: Value(priority),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isRecurring: Value(isRecurring),
      scheduleId: scheduleId == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleId),
    );
  }

  factory Block.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Block(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      duration: serializer.fromJson<int>(json['duration']),
      minuteOfWeek: serializer.fromJson<int>(json['minuteOfWeek']),
      isScheduled: serializer.fromJson<bool>(json['isScheduled']),
      origin: serializer.fromJson<String>(json['origin']),
      priority: serializer.fromJson<int>(json['priority']),
      note: serializer.fromJson<String?>(json['note']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      scheduleId: serializer.fromJson<int?>(json['scheduleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'duration': serializer.toJson<int>(duration),
      'minuteOfWeek': serializer.toJson<int>(minuteOfWeek),
      'isScheduled': serializer.toJson<bool>(isScheduled),
      'origin': serializer.toJson<String>(origin),
      'priority': serializer.toJson<int>(priority),
      'note': serializer.toJson<String?>(note),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'scheduleId': serializer.toJson<int?>(scheduleId),
    };
  }

  Block copyWith(
          {int? id,
          String? type,
          int? duration,
          int? minuteOfWeek,
          bool? isScheduled,
          String? origin,
          int? priority,
          Value<String?> note = const Value.absent(),
          bool? isRecurring,
          Value<int?> scheduleId = const Value.absent()}) =>
      Block(
        id: id ?? this.id,
        type: type ?? this.type,
        duration: duration ?? this.duration,
        minuteOfWeek: minuteOfWeek ?? this.minuteOfWeek,
        isScheduled: isScheduled ?? this.isScheduled,
        origin: origin ?? this.origin,
        priority: priority ?? this.priority,
        note: note.present ? note.value : this.note,
        isRecurring: isRecurring ?? this.isRecurring,
        scheduleId: scheduleId.present ? scheduleId.value : this.scheduleId,
      );
  @override
  String toString() {
    return (StringBuffer('Block(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('duration: $duration, ')
          ..write('minuteOfWeek: $minuteOfWeek, ')
          ..write('isScheduled: $isScheduled, ')
          ..write('origin: $origin, ')
          ..write('priority: $priority, ')
          ..write('note: $note, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('scheduleId: $scheduleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, duration, minuteOfWeek, isScheduled,
      origin, priority, note, isRecurring, scheduleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Block &&
          other.id == this.id &&
          other.type == this.type &&
          other.duration == this.duration &&
          other.minuteOfWeek == this.minuteOfWeek &&
          other.isScheduled == this.isScheduled &&
          other.origin == this.origin &&
          other.priority == this.priority &&
          other.note == this.note &&
          other.isRecurring == this.isRecurring &&
          other.scheduleId == this.scheduleId);
}

class BlocksCompanion extends UpdateCompanion<Block> {
  final Value<int> id;
  final Value<String> type;
  final Value<int> duration;
  final Value<int> minuteOfWeek;
  final Value<bool> isScheduled;
  final Value<String> origin;
  final Value<int> priority;
  final Value<String?> note;
  final Value<bool> isRecurring;
  final Value<int?> scheduleId;
  const BlocksCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.duration = const Value.absent(),
    this.minuteOfWeek = const Value.absent(),
    this.isScheduled = const Value.absent(),
    this.origin = const Value.absent(),
    this.priority = const Value.absent(),
    this.note = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.scheduleId = const Value.absent(),
  });
  BlocksCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required int duration,
    required int minuteOfWeek,
    required bool isScheduled,
    required String origin,
    required int priority,
    this.note = const Value.absent(),
    required bool isRecurring,
    this.scheduleId = const Value.absent(),
  })  : type = Value(type),
        duration = Value(duration),
        minuteOfWeek = Value(minuteOfWeek),
        isScheduled = Value(isScheduled),
        origin = Value(origin),
        priority = Value(priority),
        isRecurring = Value(isRecurring);
  static Insertable<Block> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? duration,
    Expression<int>? minuteOfWeek,
    Expression<bool>? isScheduled,
    Expression<String>? origin,
    Expression<int>? priority,
    Expression<String>? note,
    Expression<bool>? isRecurring,
    Expression<int>? scheduleId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (duration != null) 'duration': duration,
      if (minuteOfWeek != null) 'minute_of_week': minuteOfWeek,
      if (isScheduled != null) 'is_scheduled': isScheduled,
      if (origin != null) 'origin': origin,
      if (priority != null) 'priority': priority,
      if (note != null) 'note': note,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (scheduleId != null) 'schedule_id': scheduleId,
    });
  }

  BlocksCompanion copyWith(
      {Value<int>? id,
      Value<String>? type,
      Value<int>? duration,
      Value<int>? minuteOfWeek,
      Value<bool>? isScheduled,
      Value<String>? origin,
      Value<int>? priority,
      Value<String?>? note,
      Value<bool>? isRecurring,
      Value<int?>? scheduleId}) {
    return BlocksCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      minuteOfWeek: minuteOfWeek ?? this.minuteOfWeek,
      isScheduled: isScheduled ?? this.isScheduled,
      origin: origin ?? this.origin,
      priority: priority ?? this.priority,
      note: note ?? this.note,
      isRecurring: isRecurring ?? this.isRecurring,
      scheduleId: scheduleId ?? this.scheduleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (minuteOfWeek.present) {
      map['minute_of_week'] = Variable<int>(minuteOfWeek.value);
    }
    if (isScheduled.present) {
      map['is_scheduled'] = Variable<bool>(isScheduled.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<int>(scheduleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlocksCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('duration: $duration, ')
          ..write('minuteOfWeek: $minuteOfWeek, ')
          ..write('isScheduled: $isScheduled, ')
          ..write('origin: $origin, ')
          ..write('priority: $priority, ')
          ..write('note: $note, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('scheduleId: $scheduleId')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  late final $BlocksTable blocks = $BlocksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [schedules, blocks];
}
