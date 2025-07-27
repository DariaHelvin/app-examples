import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ NEU!
import '../screens/home_screen.dart';
import '../screens/sensor_setup_screen.dart';
import '../../widgets/dexcom/dexcom_login_header.dart';
import '../../widgets/dexcom/dexcom_login_form.dart';
import '../../widgets/abbott/connection_status_box.dart';
import '../../widgets/abbott/connection_message_box.dart';
import '../providers/user_provider.dart'; // ✅ NEU!

class DexcomLoginScreen extends StatefulWidget {
  const DexcomLoginScreen({super.key});

  @override
  State<DexcomLoginScreen> createState() => _DexcomLoginScreenState();
}

class _DexcomLoginScreenState extends State<DexcomLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isConnected = false;
  bool showError = false;

  void connect() async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
      isConnected = false;
      showError = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email == 'mia.gsoond@gmail.com' && password == 'dex123') {
      // ✅ Update UserProvider mit allen Infos
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.setConnected(true);
      await userProvider.setEmail(email);
      await userProvider.setPassword(password);
      await userProvider.setSensor("Dexcom");

      setState(() {
        isConnected = true;
        isLoading = false;
      });

      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } else {
      setState(() {
        showError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SensorSetupScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Dexcom Login UI
            const DexcomLoginHeader(),

            DexcomLoginForm(
              emailController: emailController,
              passwordController: passwordController,
              onConnect: connect,
            ),
            const SizedBox(height: 20),
            ConnectionStatusBox(
              isLoading: isLoading,
              isConnected: isConnected,
              showError: showError,
            ),
            ConnectionMessageBox(
              isConnected: isConnected,
              showError: showError,
            ),
          ],
        ),
      ),
    );
  }
}
