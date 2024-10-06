import 'package:flutter/material.dart';
import '../models/mileage.dart';

class MileageService with ChangeNotifier {
  final List<Mileage> _mileages = [];

  List<Mileage> get mileages => _mileages;

  void addMileage(Mileage mileage) {
    _mileages.add(mileage);
    notifyListeners();
  }

  double getTotalMilesForWeek(DateTime weekStart) {
    return _mileages
        .where((mileage) =>
            mileage.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
            mileage.date.isBefore(weekStart.add(const Duration(days: 7))))
        .fold(0.0, (sum, mileage) => sum + mileage.miles);
  }

  // This method calculates total accumulated miles
  double getTotalAccumulatedMiles() {
    return _mileages.fold(0.0, (sum, mileage) => sum + mileage.miles);
  }

  // This method returns miles grouped by day
  Map<DateTime, double> getMilesPerDay() {
    Map<DateTime, double> milesPerDay = {};
    for (var mileage in _mileages) {
      final date = DateTime(mileage.date.year, mileage.date.month, mileage.date.day);  // Normalize the date
      if (milesPerDay.containsKey(date)) {
        milesPerDay[date] = milesPerDay[date]! + mileage.miles;
      } else {
        milesPerDay[date] = mileage.miles;
      }
    }
    return milesPerDay;
  }
}
