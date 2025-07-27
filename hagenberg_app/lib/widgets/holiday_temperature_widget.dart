import 'package:flutter/material.dart';
import 'package:hagenberg_app/data/holiday_data.dart';
import 'package:hagenberg_app/services/weather_service.dart';
import 'package:intl/intl.dart';

class HolidayTemperatureWidget extends StatefulWidget {
  const HolidayTemperatureWidget({Key? key}) : super(key: key);

  @override
  _HolidayTemperatureWidgetState createState() =>
      _HolidayTemperatureWidgetState();
}

class _HolidayTemperatureWidgetState extends State<HolidayTemperatureWidget> {
  String? holiday;
  String? formattedDate;
  int? temperature;

  @override
  void initState() {
    super.initState();
    fetchHoliday();
    fetchTemperature();
  }

  void fetchHoliday() {
    final now = DateTime.now().toLocal();
    final date = DateFormat('yyyy-MM-dd').format(now);
    formattedDate = DateFormat('MMMM dd, yyyy').format(now);

    print('Current local date: $date');

    for (var item in holidays) {
      if (item.date == date) {
        setState(() {
          holiday = item.name;
        });
        return;
      }
    }

    setState(() {
      holiday = null;
    });
  }

  void fetchTemperature() async {
    try {
      WeatherService weatherService = WeatherService();
      double tempCelsius = await weatherService.fetchTemperature();
      setState(() {
        temperature = tempCelsius.round();
      });
    } catch (e) {
      print('Error fetching temperature: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final responsivePaddingTop = screenHeight * 0.05;
    final responsivePaddingLeft = screenWidth * 0.02;

    final textStyle = TextStyle(
      fontFamily: 'AbrilFatface',
      fontSize: 17,
      color: Colors.black,
      height: 1.2,
    );

    return Padding(
      padding: EdgeInsets.only(
        top: responsivePaddingTop,
        left: responsivePaddingLeft,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/hgb_logo.png',
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.008),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: formattedDate != null ? '$formattedDate ' : '',
                        style: textStyle,
                      ),
                      if (temperature != null)
                        TextSpan(
                          text: ' | ${temperature.toString()}°C',
                          style: textStyle,
                        ),
                      TextSpan(
                        text: holiday != null
                            ? ' \nToday is $holiday!'
                            : ' \nWelcome to Hagenberg!',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
