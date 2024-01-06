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

class Block {
  int id;
  BlockType type;
  int duration;
  int minuteOfWeek;
  bool isScheduled;
  BlockOrigin origin;
  String? note;
  bool isRecurring;

  Block({
    this.id = -1,
    required this.type,
    required this.duration,
    this.minuteOfWeek = -1,
    this.isScheduled = false,
    this.origin = BlockOrigin.generated,
    this.note = '',
    this.isRecurring = false,
  });

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

  int get priority => _determinePriority(type);

  /// Converts the minute of the week to a more human-readable format.
  /// Example: 1500 -> "Tuesday, 1:00 AM"
  String getFormattedTime() {
    if (minuteOfWeek == -1) {
      return "Unscheduled";
    }

    final daysOfWeek = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];

    int dayIndex = minuteOfWeek ~/ (24 * 60);
    int hour = (minuteOfWeek % (24 * 60)) ~/ 60;
    int minute = minuteOfWeek % 60;

    String period = hour >= 12 ? "PM" : "AM";
    hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return "${daysOfWeek[dayIndex]}, ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
  }

  /// Converts the block to a map for storage or transmission.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'duration': duration,
      'minuteOfWeek': minuteOfWeek,
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
      minuteOfWeek: map['minuteOfWeek'],
      isScheduled: map['isScheduled'] == 1,
      origin: BlockOrigin.values
          .firstWhere((e) => e.toString().split('.').last == map['origin']),
      note: map['note'],
      isRecurring: map['isRecurring'] == 1,
    );
  }

  Block clone() {
    return Block(
      id: id,
      type: type,
      duration: duration,
      minuteOfWeek: minuteOfWeek,
      isScheduled: isScheduled,
      origin: origin,
      note: note,
      isRecurring: isRecurring,
    );
  }

  int get endTime => minuteOfWeek + duration;
}

class ExerciseBlock extends Block {
  bool isHighIntensity;

  ExerciseBlock({
    required BlockType type,
    required int duration,
    required int minuteOfWeek,
    required this.isHighIntensity,
    int priority = 3,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: type,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
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
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.meal,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class RestBlock extends Block {
  RestBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.rest,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class MeditationBlock extends Block {
  MeditationBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.meditation,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class FluxBlock extends Block {
  FluxBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.flux,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class TediumBlock extends Block {
  TediumBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.tedium,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class ShallowWorkBlock extends Block {
  ShallowWorkBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.shallowWork,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class SocialBlock extends Block {
  SocialBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.social,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class OutdoorBlock extends Block {
  OutdoorBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.outdoor,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class LearningBlock extends Block {
  LearningBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.learning,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class DeepWorkBlock extends Block {
  DeepWorkBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.deepWork,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}

class OtakuBlock extends Block {
  OtakuBlock({
    required int duration,
    required int minuteOfWeek,
    bool isScheduled = false,
    BlockOrigin origin = BlockOrigin.generated,
    String? note,
    bool isRecurring = false,
  }) : super(
          type: BlockType.otaku,
          duration: duration,
          minuteOfWeek: minuteOfWeek,
          isScheduled: isScheduled,
          origin: origin,
          note: note ?? '',
          isRecurring: isRecurring,
        );
}
