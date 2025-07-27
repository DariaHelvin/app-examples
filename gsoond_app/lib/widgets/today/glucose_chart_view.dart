/// This widget renders the core of the glucose chart block.
/// Currently, it includes only the chart itself, but it may be extended
/// to include buttons for time range switching (6h / 12h / 24h).
import 'package:flutter/material.dart';
import 'glucose_line_chart.dart';
import 'package:provider/provider.dart';
import 'package:gsoond_app/providers/glucose_provider.dart';

class GlucoseChartView extends StatefulWidget {
  const GlucoseChartView({super.key});

  @override
  State<GlucoseChartView> createState() => _GlucoseChartViewState();
}

class _GlucoseChartViewState extends State<GlucoseChartView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // HealthKit-Aufruf deaktiviert
      // context.read<GlucoseProvider>().fetchGlucoseData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.5,
      child: GlucoseLineChart(),
    );
  }
}
