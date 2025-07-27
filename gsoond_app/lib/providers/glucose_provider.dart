/// ChangeNotifier that manages glucose values and the latest reading.
/// Currently provides mock data through `fetchGlucose()`.
/// Later, replace this logic to fetch from HealthKit (iOS) or xDrip API (Android).

import 'package:flutter/material.dart';
// import 'package:health/health.dart'; // Für spätere Integration
import 'package:fl_chart/fl_chart.dart';

class GlucoseProvider with ChangeNotifier {
  // final Health _health = Health(); // HealthKit deaktiviert

  // Für spätere Verwendung mit HealthKit
  List<dynamic> _glucoseData = [];
  List<dynamic> get glucoseData => _glucoseData;

  List<FlSpot> _allDataPoints = []; // alle Datenpunkte (ungefiltert)
  List<FlSpot> _filteredDataPoints = []; // nur für ausgewählten Zeitraum

  List<FlSpot> get dataPoints => _filteredDataPoints;

  int get filterHours => _filterHours;

  int _filterHours = 12; // standardmäßig 12h anzeigen

  double? get currentValue =>
      _filteredDataPoints.isNotEmpty ? _filteredDataPoints.last.y : null;

  double? get maxValue =>
      _filteredDataPoints.isNotEmpty
          ? _filteredDataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b)
          : null;

  double? get averageValue =>
      _filteredDataPoints.isNotEmpty
          ? _filteredDataPoints.map((e) => e.y).reduce((a, b) => a + b) / _filteredDataPoints.length
          : null;

  /// Wechselt den Zeitraumfilter und aktualisiert die Datenanzeige
  void setFilterHours(int hours) {
    _filterHours = hours;
    _applyFilter();
    notifyListeners();
  }
  /// Dummy-Daten
  Future<void> fetchGlucose() async {
    final dummyData = [
      FlSpot(0, 65),   // Mitternacht, niedrig
      FlSpot(1, 70),
      FlSpot(2, 75),
      FlSpot(3, 80),
      FlSpot(4, 85),
      FlSpot(5, 90),
      FlSpot(6, 95),
      FlSpot(7, 100),
      FlSpot(8, 110),
      FlSpot(9, 150),  // Hoch
      FlSpot(10, 130),
      FlSpot(11, 120),
      FlSpot(12, 160), // Sehr hoch
      FlSpot(13, 140),
      FlSpot(14, 100),
      FlSpot(15, 55),  // Sehr niedrig
      FlSpot(16, 70),
      FlSpot(17, 85),
      FlSpot(18, 90),
      FlSpot(19, 95),
      FlSpot(20, 110),
      FlSpot(21, 115),
      FlSpot(22, 125),
      FlSpot(23, 135),
    ];

    _allDataPoints = dummyData;
    _applyFilter();
    notifyListeners();
  }


  /// Filtert die Daten basierend auf `_filterHours`
  void _applyFilter() {
    if (_allDataPoints.isEmpty) return;

    final end = _allDataPoints.last.x;
    final start = end - _filterHours;

    _filteredDataPoints = _allDataPoints.where((spot) => spot.x >= start).toList();
  }

/*
  // Für spätere HealthKit-Integration aktivieren
  Future<void> fetchGlucoseData() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));
    final types = <HealthDataType>[HealthDataType.BLOOD_GLUCOSE];

    final authorized = await _health.requestAuthorization(types);
    if (!authorized) {
      debugPrint('Authorization not granted');
      return;
    }

    try {
      final data = await _health.getHealthDataFromTypes(
        types: types,
        startTime: yesterday,
        endTime: now,
      );

      _glucoseData = data;

      final spots = data.map((entry) {
        final time = entry.dateFrom;
        final hour = time.hour + time.minute / 60.0;
        return FlSpot(hour, (entry.value as num).toDouble());
      }).toList();

      spots.sort((a, b) => a.x.compareTo(b.x));
      _dataPoints = spots;

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching glucose data: $e');
    }
  }

  Future<void> fetchGlucose() => fetchGlucoseData();
  */
}
