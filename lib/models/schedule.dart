import '../models/block.dart';

class Schedule {
  int id;
  String name;
  List<Block> blocks;
  DateTime generatedOn;
  DateTime startDate;
  bool isActive;

  Schedule({
    this.id = -1,
    required this.name,
    required this.blocks,
    required this.startDate,
    this.isActive = false,
  }) : generatedOn = DateTime.now();

  /// Checks if a new block can fit into the schedule without exceeding the weekly limit.
  bool canAddBlock(Block block) {
    int totalScheduledTime = blocks.fold(0, (sum, b) => sum + b.duration);
    return (totalScheduledTime + block.duration) <= 10080;
  }

  /// Checks if the proposed block's time slot overlaps with any existing block.
  bool isTimeSlotAvailable(Block newBlock) {
    for (Block existingBlock in blocks) {
      int existingStart = existingBlock.minuteOfWeek;
      int existingEnd = existingStart + existingBlock.duration;

      int newBlockStart = newBlock.minuteOfWeek;
      int newBlockEnd = newBlockStart + newBlock.duration;

      if ((newBlockStart < existingEnd && newBlockStart >= existingStart) ||
          (newBlockEnd > existingStart && newBlockEnd <= existingEnd)) {
        return false;
      }
    }
    return true;
  }

  /// Adds a block to the schedule after checking for time slot availability and weekly limit.
  void addBlock(Block block) {
    if (!canAddBlock(block)) {
      throw Exception(
          "Adding this block exceeds the weekly limit of 10080 minutes.");
    }

    if (!isTimeSlotAvailable(block)) {
      throw Exception("The time slot for this block is already occupied.");
    }

    Block clonedBlock = block.clone();
    clonedBlock.isScheduled = true;
    blocks.add(clonedBlock);
  }

  /// Method to remove a block from the schedule
  void removeBlock(Block block) {
    blocks.remove(block);
  }

  /// Convert schedule to map for storage or transmission
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'blocks': blocks.map((block) => block.toMap()).toList(),
      'startDate': startDate,
      'generatedOn': generatedOn,
      'isActive': isActive,
    };
  }

  /// Construct a Schedule from a map
  static Schedule fromMap(Map<String, dynamic> map) {
    var blocksList = (map['blocks'] as List)
        .map((blockMap) => Block.fromMap(blockMap as Map<String, dynamic>))
        .toList();

    return Schedule(
      id: map['id'],
      name: map['name'],
      blocks: blocksList,
      startDate: DateTime.parse(map['startDate']),
      isActive: map['isActive'],
    );
  }
}
