/// This file defines the visual glucose curve using fl_chart.
/// It includes the main orange curve, target range (70–140) shading,
/// and Y-axis/X-axis labeling. Currently uses static mock data.
/// Replace `dataSpots` with dynamic values coming from a provider or service.


import 'package:flutter/material.dart';
import 'package:gsoond_app/providers/glucose_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class GlucoseLineChart extends StatelessWidget {
  const GlucoseLineChart({super.key});

  double calculateNiceInterval(double range) {
    // Wählt ein "schönes" Intervall basierend auf der Datenbreite
    if (range <= 3) return 1;
    if (range <= 6) return 2;
    if (range <= 12) return 3;
    if (range <= 24) return 6;
    if (range <= 36) return 12;
    return 24;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GlucoseProvider>();
    final dataSpots = provider.dataPoints;
    final filterHours = provider.filterHours;

    if (dataSpots.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final maxX = dataSpots.last.x;
    final minX = max(0.0, maxX - filterHours);
    final range = maxX - minX;
    final xInterval = calculateNiceInterval(range);

    final lowerBound = dataSpots.map((e) => FlSpot(e.x, 70)).toList();
    final upperBound = dataSpots.map((e) => FlSpot(e.x, 140)).toList();

    return LineChart(
      LineChartData(
        minY: 50,
        maxY: 200,
        minX: minX,
        maxX: maxX,
        lineBarsData: [
          LineChartBarData(
            spots: dataSpots,
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3.5,
                  color: Colors.orange,
                  strokeWidth: 1.5,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
          LineChartBarData(
            spots: lowerBound,
            isCurved: false,
            color: Colors.transparent,
            barWidth: 0,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: upperBound,
            isCurved: false,
            color: Colors.transparent,
            barWidth: 0,
            dotData: FlDotData(show: false),
          ),
        ],
        betweenBarsData: [
          BetweenBarsData(
            fromIndex: 1,
            toIndex: 2,
            color: const Color(0xFFB7EACF).withOpacity(0.5),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: xInterval,
              reservedSize: 30,
              getTitlesWidget: (value, _) {
                if (filterHours == 12) {
                  final minLabel = maxX - filterHours;
                  if ((value - minLabel).abs() < 0.01) {
                    return const SizedBox.shrink();
                  }
                }
                final hour = (value.round()) % 24;
                return Text(
                  '${hour.toString().padLeft(2, '0')}:00',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 10,
              getTitlesWidget: (value, _) {
                if ([50, 70, 100, 140, 200].contains(value.toInt())) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
      ),
    );
  }
}

