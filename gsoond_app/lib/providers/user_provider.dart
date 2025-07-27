import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  bool _isConnected = false;
  String _email = "";
  String? _sensor;
  String _password = "";

  bool get isConnected => _isConnected;
  String get email => _email;
  String? get sensor => _sensor;
  String get password => _password;

  UserProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _isConnected = prefs.getBool('isConnected') ?? false;
    _email = prefs.getString('email') ?? "";
    _sensor = prefs.getString('sensor');
    _password = prefs.getString('password') ?? "";
    notifyListeners();
  }

  Future<void> setConnected(bool value) async {
    _isConnected = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isConnected', value);
    notifyListeners();
  }

  Future<void> setEmail(String value) async {
    _email = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', value);
    notifyListeners();
  }

  Future<void> setSensor(String? value) async {
    _sensor = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sensor', value ?? '');
    notifyListeners();
  }

  Future<void> setPassword(String value) async {
    _password = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', value);
    notifyListeners();
  }

  Future<void> logout() async {
    _isConnected = false;
    _email = "";
    _sensor = null;
    _password = "";
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
