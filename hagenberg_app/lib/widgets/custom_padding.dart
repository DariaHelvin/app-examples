import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  final Widget child;

  const CustomPadding({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivePadding = screenWidth * 0.06;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsivePadding,
      ),
      child: child,
    );
  }
}
