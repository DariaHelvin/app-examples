import 'package:flutter/material.dart';

class TextBlockDescriptionPage extends StatelessWidget {
  final String name;
  final String schedule;
  final String fullDescription;
  final String address;

  const TextBlockDescriptionPage({
    Key? key,
    required this.name,
    required this.schedule,
    required this.fullDescription,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'AbrilFatface',
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.001),
        Container(
          width: double.infinity,
          child: Text(
            schedule,
            style: TextStyle(
              fontFamily: 'AbhayaLibre',
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.047,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.002),
        Container(
          child: Text(
            fullDescription,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.041,
              fontFamily: 'Abhaya Libre',
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          width: double.infinity,
          child: Text(
            address,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.038,
              fontWeight: FontWeight.bold,
              fontFamily: 'Abhaya Libre',
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
