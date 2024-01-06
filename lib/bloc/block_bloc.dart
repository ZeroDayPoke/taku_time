import 'package:flutter_bloc/flutter_bloc.dart';
import 'block_event.dart';
import 'block_state.dart';
import '../services/block_allocators.dart';
import '../services/block_service.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final BlockService blockService;

  BlockBloc(this.blockService) : super(BlockInitial()) {
    on<LoadBlocks>(_onLoadBlocks);
    on<AddBlock>(_onAddBlock);
    on<UpdateBlock>(_onUpdateBlock);
    on<DeleteBlock>(_onDeleteBlock);
  }

  Future<void> _onLoadBlocks(
    LoadBlocks event,
    Emitter<BlockState> emit,
  ) async {
    emit(BlockLoadInProgress());
    try {
      final blocks = await blockService.getBlocks();
      emit(BlockLoadSuccess(blocks));
    } catch (_) {
      emit(BlockLoadFailure());
    }
  }

  Future<void> _onAddBlock(
    AddBlock event,
    Emitter<BlockState> emit,
  ) async {
    await blockService.insertBlock(event.block);
    add(LoadBlocks());
  }

  Future<void> _onUpdateBlock(
    UpdateBlock event,
    Emitter<BlockState> emit,
  ) async {
    await blockService.updateBlock(event.updatedBlock);
    add(LoadBlocks());
  }

  Future<void> _onDeleteBlock(
    DeleteBlock event,
    Emitter<BlockState> emit,
  ) async {
    await blockService.deleteBlock(event.id);
    add(LoadBlocks());
  }
}
