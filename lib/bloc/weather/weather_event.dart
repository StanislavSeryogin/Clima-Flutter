part of 'weather_bloc.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeather extends WeatherEvent {}

class SearchWeather extends WeatherEvent {
  final String cityName;

  SearchWeather({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}