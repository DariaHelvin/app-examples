import 'package:flutter/material.dart';

class AccountDropdown extends StatelessWidget {
  final String selected;
  final void Function(String?) onChanged;

  const AccountDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selected,
      items: ['Abbott', 'Dexcom'].map((name) {
        return DropdownMenuItem(value: name, child: Text(name));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
