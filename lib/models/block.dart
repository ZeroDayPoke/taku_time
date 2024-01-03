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

class Block {
  BlockType type;
  BlockCategory category;
  int duration;
  DateTime startTime;
  DateTime get endTime => startTime.add(Duration(minutes: duration));

  Block({
    required this.type,
    required this.duration,
    required this.startTime,
  }) : category = type.category;
}

class ExerciseBlock extends Block {
  bool isHighIntensity;

  ExerciseBlock({
    required BlockType type,
    required int duration,
    required DateTime startTime,
    required this.isHighIntensity,
  }) : super(type: type, duration: duration, startTime: startTime);
}

class MealBlock extends Block {
  bool isFastingDay;

  MealBlock({
    required int duration,
    required this.isFastingDay,
    required DateTime startTime,
  }) : super(type: BlockType.meal, duration: duration, startTime: startTime);
}

class RestBlock extends Block {
  RestBlock({
    required int duration,
    required DateTime startTime,
  }) : super(type: BlockType.rest, duration: duration, startTime: startTime);
}

class MeditationBlock extends Block {
  MeditationBlock({
    required int duration,
    required DateTime startTime,
  }) : super(
            type: BlockType.meditation,
            duration: duration,
            startTime: startTime);
}

class FluxBlock extends Block {
  FluxBlock({
    required int duration,
    required DateTime startTime,
  }) : super(type: BlockType.flux, duration: duration, startTime: startTime);
}

class TediumBlock extends Block {
  TediumBlock({
    required int duration,
    required DateTime startTime,
  }) : super(type: BlockType.tedium, duration: duration, startTime: startTime);
}

class ShallowWorkBlock extends Block {
  ShallowWorkBlock({
    required int duration,
    required DateTime startTime,
  }) : super(
            type: BlockType.shallowWork,
            duration: duration,
            startTime: startTime);
}

class SocialBlock extends Block {
  SocialBlock({
    required int duration,
    required DateTime startTime,
  }) : super(type: BlockType.social, duration: duration, startTime: startTime);
}

class OutdoorBlock extends Block {
  OutdoorBlock({
    required int duration,
    required DateTime startTime,
  }) : super(type: BlockType.outdoor, duration: duration, startTime: startTime);
}

class LearningBlock extends Block {
  LearningBlock({
    required int duration,
    required DateTime startTime,
  }) : super(
            type: BlockType.learning, duration: duration, startTime: startTime);
}

class DeepWorkBlock extends Block {
  DeepWorkBlock({
    required int duration,
    required DateTime startTime,
  }) : super(
            type: BlockType.deepWork, duration: duration, startTime: startTime);
}

class OtakuBlock extends Block {
  OtakuBlock({
    required int duration,
    required DateTime startTime,
  }) : super(type: BlockType.otaku, duration: duration, startTime: startTime);
}
