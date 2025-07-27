import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Vertikal zentrieren
        children: [
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Damit die Column nicht die ganze Höhe einnimmt
            children: const [
              Text('Abbott', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          // Weißer Container als Hintergrund mit Padding für mehr "Rand"
          Container(
            padding: const EdgeInsets.all(8), // Abstand rundherum
            decoration: BoxDecoration(
              color: Colors.white, // weißer Hintergrund
              shape: BoxShape.circle, // rund
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/libre.png'),
              backgroundColor: Colors.transparent, // transparent damit Container sichtbar bleibt
            ),
          ),
        ],
      ),
    );
  }
}
