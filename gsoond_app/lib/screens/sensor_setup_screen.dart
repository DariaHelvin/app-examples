import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class SensorSetupScreen extends StatefulWidget {
  const SensorSetupScreen({super.key});

  @override
  State<SensorSetupScreen> createState() => _SensorSetupScreenState();
}

class _SensorSetupScreenState extends State<SensorSetupScreen> {
  String? selectedSensor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sensor',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Setup',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 100),
              Row(
                children: [
                  SensorCard(
                    title: 'Abbott',
                    subtitle: 'Libre 3',
                    imagePath: 'assets/images/libre.png',
                    isSelected: selectedSensor == 'Libre 3',
                    onTap: () {
                      setState(() => selectedSensor = 'Libre 3');
                      Provider.of<UserProvider>(context, listen: false).setSensor("Abbott");
                      Provider.of<UserProvider>(context, listen: false).setConnected(true);
                    },
                  ),
                  const SizedBox(width: 16),
                  SensorCard(
                    title: 'Dexcom',
                    subtitle: 'G7',
                    imagePath: 'assets/images/dexcom.png',
                    isSelected: selectedSensor == 'G7',
                    onTap: () {
                      setState(() => selectedSensor = 'G7');
                      Provider.of<UserProvider>(context, listen: false).setSensor("Dexcom");
                      Provider.of<UserProvider>(context, listen: false).setConnected(true);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() => selectedSensor = 'none');
                  Provider.of<UserProvider>(context, listen: false).setSensor("");
                  Provider.of<UserProvider>(context, listen: false).setConnected(false);
                  Provider.of<UserProvider>(context, listen: false).setEmail("");
                },
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: selectedSensor == 'none' ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'just curious',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'no Sensor',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    switch (selectedSensor) {
                      case 'Libre 3':
                        Navigator.pushNamed(context, '/abbott_login_screen');
                        break;
                      case 'G7':
                        Navigator.pushNamed(context, '/dexcom_login_screen');
                        break;
                      case 'none':
                        Navigator.pushNamed(context, '/home');
                        break;
                      default:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a sensor!')),
                        );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5C00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SensorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final String imagePath;

  const SensorCard({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),
                Image.asset(
                  imagePath,
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}