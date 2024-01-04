import '../models/block.dart';

abstract class BlockState {}

class BlockInitial extends BlockState {}

class BlockLoadInProgress extends BlockState {}

class BlockLoadSuccess extends BlockState {
  final List<Block> blocks;

  BlockLoadSuccess(this.blocks);
}

class BlockLoadFailure extends BlockState {}
