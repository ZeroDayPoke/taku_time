import 'package:flutter/material.dart';

class SettingSlider extends StatelessWidget {
  final String title;
  final int value;
  final double min;
  final double max;
  final int divisions;
  final Function(double) onChanged;

  const SettingSlider({
    Key? key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$title (${value.toInt()})'),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.66,
        child: Slider(
          value: value.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          label: '${value.toInt()}',
          onChanged: onChanged,
        ),
      ),
    );
  }
}
