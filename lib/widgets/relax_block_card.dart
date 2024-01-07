import 'package:flutter/material.dart';
import 'setting_slider.dart';
import 'setting_switch.dart';

class RelaxBlockCard extends StatelessWidget {
  final String activityName;
  final String durationKeyName;
  final String enableKeyName;

  const RelaxBlockCard({
    Key? key,
    required this.activityName,
    required this.durationKeyName,
    required this.enableKeyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('$activityName Duration'),
          ),
          SettingSlider(
            title: '$activityName Duration',
            min: 0,
            max: 120,
            divisions: 12,
            keyName: durationKeyName,
          ),
          SettingSwitch(
            title: 'Enable $activityName',
            keyName: enableKeyName,
          ),
        ],
      ),
    );
  }
}
