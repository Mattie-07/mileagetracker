import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mileage.dart';
import '../services/mileage_service.dart';

class AddMilesScreen extends StatefulWidget {
  @override
  _AddMilesScreenState createState() => _AddMilesScreenState();
}

class _AddMilesScreenState extends State<AddMilesScreen> {
  final _milesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _milesController.dispose();
    super.dispose();
  }

  void _submitMileage() {
    if (_milesController.text.isNotEmpty) {
      final mileage = Mileage(
        miles: double.parse(_milesController.text),
        date: _selectedDate,
      );
      Provider.of<MileageService>(context, listen: false).addMileage(mileage);
      Navigator.of(context).pop();  // Go back to home screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Miles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _milesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Miles Driven'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
                ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitMileage,
              child: Text('Save Mileage'),
            ),
          ],
        ),
      ),
    );
  }
}
