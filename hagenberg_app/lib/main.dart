import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hagenberg_app/screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HagenbergApp());
}

class HagenbergApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hagenberg App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}
