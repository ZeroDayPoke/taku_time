import 'block.dart';
import 'schedule.dart';

class ScheduleBuilder {
  int id;
  String? name;
  List<Block> blocks = [];
  DateTime? startDate;
  bool isActive = false;

  ScheduleBuilder({this.id = -1, this.name, this.startDate});

  /// Sets the name of the schedule.
  void setName(String name) {
    this.name = name;
  }

  /// Sets the start date of the schedule.
  void setStartDate(DateTime startDate) {
    this.startDate = startDate;
  }

  /// Adds a block to the schedule after checking constraints.
  void addBlock(Block block) {
    if (!canAddBlock(block) || !isTimeSlotAvailable(block)) {
      throw Exception("Block cannot be added due to constraints.");
    }
    blocks.add(block.clone());
  }

  /// Removes a block from the schedule.
  void removeBlock(Block block) {
    blocks.remove(block);
  }

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

  /// Builds and returns a Schedule object.
  Schedule build() {
    return Schedule(
      id: id,
      name: name ?? "New Schedule",
      blocks: blocks,
      startDate: startDate ?? DateTime.now(),
      isActive: isActive,
    );
  }

  /// Resets the builder to a new blank state or loads the current active schedule.
  void reset(Schedule? currentActiveSchedule) {
    if (currentActiveSchedule != null) {
      id = currentActiveSchedule.id;
      name = currentActiveSchedule.name;
      blocks = currentActiveSchedule.blocks.map((b) => b.clone()).toList();
      startDate = currentActiveSchedule.startDate;
      isActive = currentActiveSchedule.isActive;
    } else {
      id = -1;
      name = null;
      blocks = [];
      startDate = DateTime.now();
      isActive = false;
    }
  }
}
