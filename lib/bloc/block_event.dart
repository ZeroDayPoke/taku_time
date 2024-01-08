import '../models/block.dart';

abstract class BlockEvent {}

class LoadBlocks extends BlockEvent {}

class LoadCustomBlocks extends BlockEvent {}

class InitializeBlocks extends BlockEvent {
  final List<Block> blocks;
  InitializeBlocks(this.blocks);
}

class AddBlock extends BlockEvent {
  final Block block;

  AddBlock(this.block);
}

class UpdateBlock extends BlockEvent {
  final Block updatedBlock;

  UpdateBlock(this.updatedBlock);
}

class DeleteBlock extends BlockEvent {
  final int id;

  DeleteBlock(this.id);
}
