import 'package:flutter/material.dart';

class ConnectionMessageBox extends StatelessWidget {
  final bool isConnected;
  final bool showError;

  const ConnectionMessageBox({
    super.key,
    required this.isConnected,
    required this.showError,
  });

  @override
  Widget build(BuildContext context) {
    if (!isConnected && !showError) return const SizedBox.shrink();

    final color = isConnected ? Colors.green : Colors.red;
    final title = "Message";
    final message = isConnected
        ? "Dexcom Account successfully connected."
        : "Couldn't connect to your Account.\nPlease check Email and Password and try again.";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, color: color, size: 12),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
