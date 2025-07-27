import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de_DE', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number lottery',
      theme: ThemeData.dark(),
      home: const ClockScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  late Timer _apiTimer;
  late DateTime _now;
  int? _lastRandomNumber;
  DateTime? _lastPrimeTime;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });

    _loadLastPrimeTime();

    _apiTimer = Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      int? randomNumber = await fetchRandomNumber();

      if (!mounted) return;

      setState(() {
        _lastRandomNumber = randomNumber;
      });

      if (randomNumber != null && isPrime(randomNumber) && !_isDialogShown) {
        _isDialogShown = true;

        final now = DateTime.now();
        Duration elapsed = _lastPrimeTime == null
            ? Duration.zero
            : now.difference(_lastPrimeTime!);
        _lastPrimeTime = now;
        await _saveLastPrimeTime(now);

        if (!mounted) return;
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PrimeFoundScreen(
              primeNumber: randomNumber,
              elapsed: elapsed,
            ),
          ),
        );

        _isDialogShown = false;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _apiTimer.cancel();
    super.dispose();
  }

  Future<int?> fetchRandomNumber() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.randomnumberapi.com/api/v1.0/random'))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.first as int;
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while requesting number: $e');
    }
    return null;
  }

  bool isPrime(int n) {
    if (n <= 1) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;
    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) return false;
    }
    return true;
  }

  Future<void> _saveLastPrimeTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPrimeTime', time.millisecondsSinceEpoch);
  }

  Future<void> _loadLastPrimeTime() async {
    final prefs = await SharedPreferences.getInstance();
    final ms = prefs.getInt('lastPrimeTime');
    if (ms != null) {
      if (mounted) {
        setState(() {
          _lastPrimeTime = DateTime.fromMillisecondsSinceEpoch(ms);
        });
      }
    }
  }

  String get formattedTime => DateFormat('HH:mm').format(_now);

  String get formattedDate => DateFormat('EEE d. MMM', 'de_DE').format(_now);

  int getIsoWeekNumber(DateTime date) {
    final firstThursday = DateTime(date.year, 1, 1).add(Duration(
        days: (DateTime.thursday - DateTime(date.year, 1, 1).weekday + 7) % 7));
    final weekNumber = ((date.difference(firstThursday).inDays) / 7).ceil() + 1;
    return weekNumber;
  }

  String get weekOfYear {
    int week = getIsoWeekNumber(_now);
    return "KW $week";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedTime,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  weekOfYear,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            if (_lastRandomNumber != null) ...[
              const SizedBox(height: 40),
              Text(
                "Letzte Zahl: $_lastRandomNumber",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PrimeFoundScreen extends StatelessWidget {
  final int primeNumber;
  final Duration elapsed;

  const PrimeFoundScreen({
    super.key,
    required this.primeNumber,
    required this.elapsed,
  });

  @override
  Widget build(BuildContext context) {
    String elapsedStr = "${elapsed.inMinutes} min ${elapsed.inSeconds % 60} sec";

    return Scaffold(
      backgroundColor: const Color(0xFF161B1E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 36),
              const Text(
                "Congrats!",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "You obtained a prime number, it was: $primeNumber",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Time since last prime number: $elapsedStr",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Close",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
