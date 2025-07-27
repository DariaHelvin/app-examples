import 'package:flutter/material.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 16, left: 24.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Glucose',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          Text(
            ' Today',
            style: TextStyle(
              fontSize: 30,
              height: 1.0,
              fontWeight: FontWeight.w900,
              color: Colors.grey,
                          ),
          ),
        ],
      ),
    );
  }
}
