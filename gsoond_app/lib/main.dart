import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'providers/glucose_provider.dart';

import 'screens/profile_screen.dart';
import 'screens/sensor_setup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/abbott_login_screen.dart';
import 'screens/dexcom_login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GlucoseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/sensor',
      routes: {
        '/sensor': (context) => const SensorSetupScreen(),
        '/home': (context) => const HomeScreen(),
        '/abbott_login_screen': (context) => const AbbottLoginScreen(),
        '/dexcom_login_screen': (context) => const DexcomLoginScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
