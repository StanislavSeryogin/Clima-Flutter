import 'package:clima/model/weather_model.dart';
import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherRepository {
  Future<WeatherModel> fetchWeatherData(double latitude, double longitude) async {
    final url = '$kOpenWeatherMapURL?lat=$latitude&lon=$longitude&appid=$kApiKey';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    final weather = WeatherModel.fromJson(jsonData);
    return weather;
  }

  Future<WeatherModel> fetchWeatherByCityName(String cityName) async {
    final url = '$kOpenWeatherMapURL?q=$cityName&appid=$kApiKey';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    final weather = WeatherModel.fromJson(jsonData);
    return weather;
  }
}