import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './services/mileage_service.dart'; // Import the MileageService
import './screens/home_screen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsService = SettingsService();
  final settingsController = SettingsController(settingsService);

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}

class MyApp extends StatelessWidget {
  final SettingsController settingsController;

  MyApp({required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MileageService(),  // This should now recognize MileageService
      child: MaterialApp(
        title: "Tracking Miles",
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: settingsController.themeMode,
        home: HomeScreen(),
      ),
    );
  }
}
