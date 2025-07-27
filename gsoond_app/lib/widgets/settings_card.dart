import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final Widget child;
  final String? statusText;
  final Color? statusColor;

  const SettingsCard({
    super.key,
    required this.title,
    required this.child,
    this.statusText,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  child,
                ],
              ),
            ),
            if (statusText != null && statusColor != null)
              Row(
                children: [
                  Icon(Icons.circle, color: statusColor, size: 10),
                  const SizedBox(width: 5),
                  Text(statusText!, style: TextStyle(color: statusColor)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
