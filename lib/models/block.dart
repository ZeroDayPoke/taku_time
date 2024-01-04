enum BlockType {
  deepWork,
  learning,
  social,
  flux,
  shallowWork,
  meditation,
  outdoor,
  otaku,
  lowIntensityExercise,
  highIntensityExercise,
  meal,
  rest,
  tedium
}

enum BlockCategory { stress, relax, inevitable }

extension BlockTypeExtension on BlockType {
  BlockCategory get category {
    switch (this) {
      case BlockType.deepWork:
      case BlockType.learning:
        return BlockCategory.stress;
      case BlockType.social:
      case BlockType.flux:
      case BlockType.shallowWork:
      case BlockType.meditation:
      case BlockType.outdoor:
      case BlockType.otaku:
      case BlockType.lowIntensityExercise:
      case BlockType.highIntensityExercise:
        return BlockCategory.relax;
      case BlockType.meal:
      case BlockType.rest:
      case BlockType.tedium:
        return BlockCategory.inevitable;
    }
  }
}

/// An enum to specify the origin of a block.
enum BlockOrigin { generated, custom }

/// Class representing a block in the schedule.
class Block {
  int? id;
  BlockType type;
  int duration;
  DateTime startTime;
  bool isScheduled;
  BlockOrigin origin;
  int priority;
  String? note;
  bool isRecurring;

  /// Constructs a [Block] with the given parameters.
  ///
  /// [id] is an optional identifier for the block.
  /// [type] specifies the type of the block.
  /// [duration] specifies the duration of the block in minutes.
  /// [startTime] is the start time of the block.
  /// [isScheduled] indicates if the block is scheduled (default: false).
  /// [origin] specifies the origin of the block (default: generated).
  /// [priority] indicates the priority level of the block (default depends on type).
  /// [note] is an optional field for user notes.
  /// [isRecurring] indicates if the block is recurring (default: false).
  Block({
    this.id,
    required this.type,
    required this.duration,
    required this.startTime,
    this.isScheduled = false,
    this.origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  })  : priority = _determinePriority(type),
        note = note ?? '',
        isRecurring = isRecurring ?? false;

  /// Determines the priority level based on the block type.
  static int _determinePriority(BlockType type) {
    switch (type.category) {
      case BlockCategory.stress:
        return 1;
      case BlockCategory.relax:
        return 2;
      case BlockCategory.inevitable:
      default:
        return 0;
    }
  }

  /// Converts the block to a map for storage or transmission.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'duration': duration,
      'startTime': startTime.toIso8601String(),
      'category': type.category.toString().split('.').last,
      'isScheduled': isScheduled ? 1 : 0,
      'origin': origin.toString().split('.').last,
      'priority': priority,
      'note': note,
      'isRecurring': isRecurring ? 1 : 0
    };
  }

  /// Constructs a [Block] from a map.
  static Block fromMap(Map<String, dynamic> map) {
    return Block(
      id: map['id'],
      type: BlockType.values
          .firstWhere((e) => e.toString().split('.').last == map['type']),
      duration: map['duration'],
      startTime: DateTime.parse(map['startTime']),
      isScheduled: map['isScheduled'] == 1,
      origin: BlockOrigin.values
          .firstWhere((e) => e.toString().split('.').last == map['origin']),
      note: map['note'],
      isRecurring: map['isRecurring'] == 1,
    );
  }

  DateTime get endTime => startTime.add(Duration(minutes: duration));
}

class ExerciseBlock extends Block {
  bool isHighIntensity;

  ExerciseBlock({
    required BlockType type,
    required int duration,
    required DateTime startTime,
    required this.isHighIntensity,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: type,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class MealBlock extends Block {
  bool isFastingDay;

  MealBlock({
    required this.isFastingDay,
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.meal,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class RestBlock extends Block {
  RestBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.rest,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class MeditationBlock extends Block {
  MeditationBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.meditation,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class FluxBlock extends Block {
  FluxBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.flux,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class TediumBlock extends Block {
  TediumBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.tedium,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class ShallowWorkBlock extends Block {
  ShallowWorkBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.shallowWork,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class SocialBlock extends Block {
  SocialBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.social,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class OutdoorBlock extends Block {
  OutdoorBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.outdoor,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class LearningBlock extends Block {
  LearningBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.learning,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class DeepWorkBlock extends Block {
  DeepWorkBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.deepWork,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class OtakuBlock extends Block {
  OtakuBlock({
    required int duration,
    required DateTime startTime,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.otaku,
          duration: duration,
          startTime: startTime,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}
