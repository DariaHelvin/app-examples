import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String apiKey = '8a4514929c701f21748a48602c4683dd';

  Future<double> fetchTemperature() async {
    double latitude = 48.3676;
    double longitude = 14.5461;
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        double temperature = jsonResponse['main']['temp'];
        return temperature;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
}
