import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/glucose_provider.dart';

class GlucoseChartHeader extends StatelessWidget {
  const GlucoseChartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayOfWeek = DateFormat.EEEE().format(now);
    final dateFormatted = DateFormat('dd.MM.yyyy').format(now);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: "$dayOfWeek\n",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: dateFormatted,
              ),
            ],
          ),
        ),
        const _FilterSelector(),
      ],
    );
  }
}

class _FilterSelector extends StatelessWidget {
  const _FilterSelector();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlucoseProvider>(context);
    final selected = provider.filterHours;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [6, 12, 24].map((hours) {
          final isSelected = selected == hours;
          return GestureDetector(
            onTap: () => provider.setFilterHours(hours),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${hours}h',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
