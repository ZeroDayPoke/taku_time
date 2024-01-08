import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/block.dart' as model;
import '../bloc/block_bloc.dart';
import '../bloc/block_event.dart';
import '../bloc/block_state.dart';

class BlockScreen extends StatefulWidget {
  @override
  _BlockScreenState createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  model.BlockType? selectedType;
  int? duration;
  String? note;
  model.Block? editingBlock;

  @override
  void initState() {
    super.initState();
    context.read<BlockBloc>().add(LoadCustomBlocks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButton<model.BlockType>(
              value: selectedType,
              hint: const Text("Select Block Type"),
              onChanged: (model.BlockType? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: model.BlockType.values
                  .map<DropdownMenuItem<model.BlockType>>(
                      (model.BlockType value) {
                return DropdownMenuItem<model.BlockType>(
                  value: value,
                  child: Text(value.toString().split('.').last),
                );
              }).toList(),
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => duration = int.tryParse(value),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Note'),
              onChanged: (value) => note = value,
            ),
            ElevatedButton(
              onPressed: _createOrUpdateBlock,
              child: const Text('Save Block'),
            ),
            Expanded(
              child: BlocBuilder<BlockBloc, BlockState>(
                builder: (context, state) {
                  if (state is BlockLoadSuccess) {
                    return ListView(
                      children: state.blocks
                          .map((block) => ListTile(
                                title: Text(block.type.toString()),
                                subtitle:
                                    Text('Duration: ${block.duration} mins'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => _editBlock(block),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _deleteBlock(block.id),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    );
                  } else if (state is BlockLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text('No custom blocks found.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editBlock(model.Block block) {
    setState(() {
      editingBlock = block;
      selectedType = block.type;
      duration = block.duration;
      note = block.note;
    });
  }

  void _deleteBlock(int id) {
    context.read<BlockBloc>().add(DeleteBlock(id));
  }

  void _createOrUpdateBlock() {
    if (selectedType != null && duration != null) {
      final block = model.Block(
        id: editingBlock?.id ?? -1,
        type: selectedType!,
        duration: duration!,
        note: note,
        origin: model.BlockOrigin.custom,
        isRecurring: false,
        isScheduled: false,
        minuteOfWeek: -1,
      );

      if (editingBlock != null) {
        context.read<BlockBloc>().add(UpdateBlock(block));
      } else {
        context.read<BlockBloc>().add(AddBlock(block));
      }

      setState(() {
        editingBlock = null;
        selectedType = null;
        duration = null;
        note = null;
      });
    } else {
      // TODO: Show error message
    }
  }
}
