import 'package:flutter/material.dart';
import '../models/block.dart';

class BlockCard extends StatelessWidget {
  final Block block;

  const BlockCard({Key? key, required this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: _getBlockColor(block.type),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.type.toString().split('.').last,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Duration: ${block.duration} min',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Color _getBlockColor(BlockType type) {
    switch (type) {
      case BlockType.deepWork:
        return Colors.blue;
      case BlockType.learning:
        return Colors.green;
      case BlockType.flux:
        return Colors.red;
      case BlockType.meditation:
        return Colors.purple;
      case BlockType.outdoor:
        return Colors.orange;
      case BlockType.shallowWork:
        return Colors.yellow;
      case BlockType.social:
        return Colors.pink;
      case BlockType.tedium:
        return Colors.teal;
      case BlockType.meal:
        return Colors.brown;
      case BlockType.rest:
        return Colors.grey;
      case BlockType.highIntensityExercise:
        return Colors.red;
      case BlockType.lowIntensityExercise:
        return Colors.green;
      case BlockType.otaku:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
