import 'package:flutter/material.dart';

class TextBlockTodayActivities extends StatelessWidget {
  final String title;
  final String description;

  const TextBlockTodayActivities({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Displaying title: $title");
    debugPrint("Displaying description: $description");

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'AbrilFatface',
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.043,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          width: double.infinity,
          child: Center(
            child: Text(
              description,
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.044,
                fontFamily: 'Abhaya Libre',
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}
