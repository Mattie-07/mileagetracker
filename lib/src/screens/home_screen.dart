import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mileage_service.dart';
import '../widgets/mileage_bar_chart.dart';  // Import the chart widget
import './add_miles_screen.dart';  // Import the Add Miles screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mileageService = Provider.of<MileageService>(context);
    final milesPerDay = mileageService.getMilesPerDay();

    return Scaffold(
      appBar: AppBar(
        title: Text('Total Miles'),
      ),
      body: Column(
        children: [
          Text(
            'Total Miles Driven:',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            '${mileageService.getTotalAccumulatedMiles()} miles',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          // Use the new MileageBarChart widget
Container(
  height: 300,
  padding: const EdgeInsets.all(16.0),
  child: MileageLineChart(milesPerDay: milesPerDay),
),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddMilesScreen(),
                ),
              );
            },
            child: Text('Add Miles'),
          ),
        ],
      ),
    );
  }
}
