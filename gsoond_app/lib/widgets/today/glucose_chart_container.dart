/// This widget serves as the visual container for the glucose chart.
/// It combines the header, the glucose chart view, and the events section.
/// This file should not contain logic — only layout and composition.


import 'package:flutter/material.dart';
import 'glucose_chart_header.dart';
import 'glucose_chart_view.dart';
import 'glucose_chart_events.dart';
class GlucoseChartContainer extends StatelessWidget {
  const GlucoseChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(45),
      ),
      child: Column(
        children: const [
          GlucoseChartHeader(),
          SizedBox(height: 16),
          GlucoseChartView(),
          SizedBox(height: 16),
          GlucoseChartEvents(),

        ],
      ),
    );
  }
}
