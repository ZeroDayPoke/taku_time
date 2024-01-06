import 'package:drift/drift.dart';
import 'package:taku_time/database/my_database.dart';
import 'package:taku_time/models/block.dart' as model;
import 'package:flutter/foundation.dart';

class BlockRepository {
  final MyDatabase _db = MyDatabase.instance;

  Future<List<model.Block>> getBlocks() async {
    try {
      var blockData = await _db.getAllBlocks();
      if (blockData.isNotEmpty) {
        return blockData.map((e) => _convertToBlockModel(e)).toList();
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  model.Block _convertToBlockModel(Block entity) {
    return model.Block(
      id: entity.id,
      type: model.BlockType.values
          .firstWhere((e) => e.toString() == 'BlockType.${entity.type}'),
      duration: entity.duration,
      minuteOfWeek: entity.minuteOfWeek,
      isScheduled: entity.isScheduled,
      origin: model.BlockOrigin.values
          .firstWhere((e) => e.toString() == 'BlockOrigin.${entity.origin}'),
      note: entity.note,
      isRecurring: entity.isRecurring,
    );
  }

  // Insert a new block into the database
  Future<void> insertBlock(model.Block block) async {
    await _db.insertBlock(BlocksCompanion.insert(
      type: block.type.toString().split('.').last,
      duration: block.duration,
      minuteOfWeek: block.minuteOfWeek,
      isScheduled: block.isScheduled,
      origin: block.origin.toString().split('.').last,
      priority: block.priority,
      note: Value(block.note),
      isRecurring: block.isRecurring,
    ));
  }

  // Update an existing block in the database
  Future<void> updateBlock(model.Block block) async {
    await _db.updateBlock(BlocksCompanion.insert(
      id: Value(block.id),
      type: block.type.toString().split('.').last,
      duration: block.duration,
      minuteOfWeek: block.minuteOfWeek,
      isScheduled: block.isScheduled,
      origin: block.origin.toString().split('.').last,
      priority: block.priority,
      note: Value(block.note),
      isRecurring: block.isRecurring,
    ));
  }

  Future<void> deleteBlock(int id) async {
    return _db.deleteBlock(id);
  }

  Future<List<model.Block>> getBlocksOfType(String type) async {
    try {
      var blockData = await _db.getBlocksOfType(type);
      if (blockData.isNotEmpty) {
        return blockData.map((e) => _convertToBlockModel(e)).toList();
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
