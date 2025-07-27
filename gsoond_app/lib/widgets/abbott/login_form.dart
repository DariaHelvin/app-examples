import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onConnect;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Account + Abbott in einer Zeile
          Row(
            children: const [
              Text(
                "Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20, // 👈 größer gemacht
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Abbott",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18, // 👈 optional mitangepasst
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Email Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 100,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    filled: true,
                    fillColor: const Color(0xFFF1F1F1)
                    ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

    Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    const SizedBox(
    width: 100,
    child: Text(
    "Password",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    ),
    ),
              Expanded(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    filled: true,
                    fillColor: const Color(0xFFF1F1F1)
                    ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

    Align(
    alignment: Alignment.centerRight,
    child: SizedBox(
    width: screenWidth * 0.4,
    height: 45,
    child: ElevatedButton(
    onPressed: onConnect,
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFF4B00),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    child: const Text(
    "Connect",
    style: TextStyle(color: Colors.white),
    ),




    ),
            ),
          ),
        ],
      ),
    );
  }
}
