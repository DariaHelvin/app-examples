import 'package:flutter/material.dart';

class MapIconButton extends StatelessWidget {
  final double latitude;
  final double longitude;
  final Function(double, double) launchMapsUrl;

  const MapIconButton({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.launchMapsUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Image.asset(
          'assets/icons/map_icon.png',
          width: 35,
          height: 35,
        ),
        onPressed: () {
          launchMapsUrl(latitude, longitude);
        },
      ),
    );
  }
}
