import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/block_bloc.dart';
import '../bloc/block_event.dart';
import '../bloc/block_state.dart';
import '../bloc/schedule_builder_bloc.dart';
import '../bloc/schedule_builder_event.dart';
import '../screens/settings_screen.dart';
import '../screens/block_screen.dart';
import '../models/block.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadActiveScheduleAndInitializeBlocks();
  }

  Future<void> _loadActiveScheduleAndInitializeBlocks() async {
    context.read<ScheduleBuilderBloc>().add(StartScheduleBuilding());
    context.read<BlockBloc>().add(LoadCustomBlocks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlockScreen()),
          );
        },
      ),
      body: BlocBuilder<BlockBloc, BlockState>(
        builder: (context, state) {
          if (state is BlockLoadSuccess) {
            if (state.blocks.isEmpty) {
              return _buildNoBlocksView();
            }
            return _buildBlocksListView(state.blocks);
          } else if (state is BlockLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Failed to load blocks.'));
          }
        },
      ),
    );
  }

  Widget _buildNoBlocksView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('No blocks available.'),
          ElevatedButton(
            child: const Text('Create a Block'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BlockScreen()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('Create a Schedule'),
            onPressed: () {
              // TODO: Navigate to schedule builder screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlocksListView(List<Block> blocks) {
    return ListView.builder(
      itemCount: blocks.length,
      itemBuilder: (context, index) {
        final block = blocks[index];
        return ListTile(
          title: Text(block.type.toString()),
          subtitle: Text('Duration: ${block.duration} mins'),
        );
      },
    );
  }
}
