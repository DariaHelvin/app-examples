/// Placeholder service for fetching glucose data.
/// This file should contain platform-specific data fetching logic in the future,
/// for example, using `health` plugin to retrieve HealthKit CGM data on iOS.
/// For now, it's unused.

import 'package:health/health.dart';

class HealthService {
  final _health = Health();

  Future<List<double>> getGlucoseValues() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    final types = [HealthDataType.BLOOD_GLUCOSE];
    final permissions = [HealthDataAccess.READ];

    final authorized = await _health.requestAuthorization(types, permissions: permissions);
    if (!authorized) return [];

    final data = await _health.getHealthDataFromTypes(
      startTime: yesterday,
      endTime: now,
      types: types,
    );

    final values = data.map((e) => double.tryParse(e.value.toString()) ?? 0.0).toList();

    return values;
  }
}
