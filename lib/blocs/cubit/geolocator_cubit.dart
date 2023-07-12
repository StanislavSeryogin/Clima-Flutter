import 'package:bloc/bloc.dart';
import 'package:clima/model/weather_model.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'geolocator_state.dart';

class WeatherCubit extends Cubit<WeatherModel> {
  WeatherCubit() : super(WeatherModel(condition: 0, weatherIcon: '', message: ''));

  void fetchWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final url =
        '$kOpenWeatherMapURL?lat=${position.latitude}&lon=${position.longitude}&appid=$kApiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      final weather = WeatherModel.fromJson(weatherData);
      emit(weather);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
