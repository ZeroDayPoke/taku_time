import '../models/block.dart' as model;
import '../models/user_preferences.dart';
import '../repositories/block_repository.dart';

class BlockService {
  final BlockRepository _blockRepository;

  BlockService(this._blockRepository);

  Future<List<model.Block>> getBlocks() async {
    return _blockRepository.getBlocks();
  }

  Future<void> insertBlock(model.Block block) async {
    await _blockRepository.insertBlock(block);
  }

  Future<void> updateBlock(model.Block block) async {
    await _blockRepository.updateBlock(block);
  }

  Future<void> deleteBlock(int id) async {
    await _blockRepository.deleteBlock(id);
  }

  Future<List<model.Block>> getBlocksOfType(String type) async {
    return _blockRepository.getBlocksOfType(type);
  }
}
