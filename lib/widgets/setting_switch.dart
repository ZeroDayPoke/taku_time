import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const SettingSwitch({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
