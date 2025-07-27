import 'package:flutter/material.dart';

class ConnectionStatusBox extends StatelessWidget {
  final bool isLoading;
  final bool isConnected;
  final bool showError;

  const ConnectionStatusBox({
    super.key,
    required this.isLoading,
    required this.isConnected,
    required this.showError,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildStatusRow("connecting ...", const CircularProgressIndicator(strokeWidth: 2, color: Colors.blue));
    } else if (isConnected) {
      return _buildStatusRow("connected", const Icon(Icons.circle, color: Colors.green, size: 12));
    } else if (showError) {
      return _buildStatusRow("not connected", const Icon(Icons.circle, color: Colors.red, size: 12));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildStatusRow(String text, Widget icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          const SizedBox(width: 8),
          icon,
        ],
      ),
    );
  }
}
