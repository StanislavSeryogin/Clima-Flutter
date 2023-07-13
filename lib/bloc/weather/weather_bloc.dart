import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:clima/blocs/weather/weather_bloc.dart';
import 'package:clima/model/weather_model.dart';
import 'package:clima/utilities/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_fetchWeather);
    on<SearchWeather>(_searchWeather);
  }

  Future<void> _fetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final weather = await _fetchWeatherData(
        position.latitude,
        position.longitude,
      );
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      emit(WeatherError());
    }
  }

  Future<void> _searchWeather(
    SearchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await _fetchWeatherByCityName(event.cityName);
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      emit(WeatherError());
    }
  }

  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        final weather = await _fetchWeatherData(
          position.latitude,
          position.longitude,
        );
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        yield WeatherError();
      }
    } else if (event is SearchWeather) {
      yield WeatherLoading();
      try {
        final weather = await _fetchWeatherByCityName(event.cityName);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        yield WeatherError();
      }
    }
  }

  Future<WeatherModel> _fetchWeatherData(
      double latitude, double longitude) async {
    final url =
        '$kOpenWeatherMapURL?lat=$latitude&lon=$longitude&appid=$kApiKey';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    final weather = WeatherModel.fromJson(jsonData);
    return weather;
  }

  Future<WeatherModel> _fetchWeatherByCityName(String cityName) async {
    final url = '$kOpenWeatherMapURL?q=$cityName&appid=$kApiKey';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    final weather = WeatherModel.fromJson(jsonData);
    return weather;
  }
}
