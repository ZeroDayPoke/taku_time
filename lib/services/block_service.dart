import '../models/block.dart' as model;
import '../repositories/block_repository.dart';

class BlockService {
  final BlockRepository blockRepository;

  BlockService(this.blockRepository);

  Future<List<model.Block>> getBlocks() async {
    return blockRepository.getBlocks();
  }

  Future<void> insertBlock(model.Block block) async {
    await blockRepository.insertBlock(block);
  }

  Future<void> updateBlock(model.Block block) async {
    await blockRepository.updateBlock(block);
  }

  Future<void> deleteBlock(int id) async {
    await blockRepository.deleteBlock(id);
  }

  Future<List<model.Block>> getBlocksOfType(String type) async {
    return blockRepository.getBlocksOfType(type);
  }

  Future<List<model.Block>> getCustomBlocks() async {
    return blockRepository.getCustomBlocks();
  }
}
