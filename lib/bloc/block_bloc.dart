import 'package:flutter_bloc/flutter_bloc.dart';
import 'block_event.dart';
import 'block_state.dart';
import '../database/database_helper.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final DatabaseHelper _databaseHelper;

  BlockBloc(this._databaseHelper) : super(BlockInitial()) {
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
      final blocks = await _databaseHelper.getBlocks();
      emit(BlockLoadSuccess(blocks));
    } catch (_) {
      emit(BlockLoadFailure());
    }
  }

  Future<void> _onAddBlock(
    AddBlock event,
    Emitter<BlockState> emit,
  ) async {
    await _databaseHelper.insertBlock(event.block);
    add(LoadBlocks());
  }

  Future<void> _onUpdateBlock(
    UpdateBlock event,
    Emitter<BlockState> emit,
  ) async {
    await _databaseHelper.updateBlock(event.updatedBlock);
    add(LoadBlocks());
  }

  Future<void> _onDeleteBlock(
    DeleteBlock event,
    Emitter<BlockState> emit,
  ) async {
    await _databaseHelper.deleteBlock(event.id);
    add(LoadBlocks());
  }
}
