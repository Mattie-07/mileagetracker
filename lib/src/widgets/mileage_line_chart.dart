import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MileageLineChart extends StatelessWidget {
  final Map<DateTime, double> milesPerDay;

  MileageLineChart({required this.milesPerDay});

  @override
  Widget build(BuildContext context) {
    if (milesPerDay.isEmpty) {
      return Center(
        child: Text('No data available to display'),
      );
    }

    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString()); // Left (y-axis) shows miles
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final date = milesPerDay.keys.elementAt(value.toInt());
                return Text('${date.month}/${date.day}'); // Bottom (x-axis) shows dates
              },
            ),
          ),
        ),
        minX: 0,
        maxX: (milesPerDay.length - 1).toDouble(),
        minY: 0,
        maxY: getMaxMiles() + 10,  // Max Y with some padding
        lineBarsData: [
          LineChartBarData(
            spots: _buildSpots(),  // Points for the line graph
            isCurved: true,        // Makes the line curved
            dotData: FlDotData(show: true),  // Show dots at data points
            belowBarData: BarAreaData(show: true),  // Optional: Shade below the line
            color: Colors.blue,  // Line color
          ),
        ],
      ),
    );
  }

  // Helper function to create data points for the line graph
  List<FlSpot> _buildSpots() {
    final List<FlSpot> spots = [];

    for (int i = 0; i < milesPerDay.keys.length; i++) {
      spots.add(FlSpot(i.toDouble(), milesPerDay.values.elementAt(i)));
    }

    return spots;
  }

  // Helper function to get the max miles for setting the Y axis limit
  double getMaxMiles() {
    if (milesPerDay.isEmpty) {
      return 0.0;
    }
    return milesPerDay.values.reduce((a, b) => a > b ? a : b);
  }
}
