import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String city;
  final String country;
  final String main;
  final String description;
  final String icon;
  final double temperature;

  WeatherModel({
    required this.city,
    required this.country,
    required this.main,
    required this.description,
    required this.icon,
    required this.temperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return WeatherModel(
      city: json['name'],
      country: json['sys']['country'],
      main: weather['main'],
      description: weather['description'],
      icon: weather['icon'],
      temperature: json['main']['temp'].toDouble(),
    );
  }

  double get tempInCelsius => temperature - 273.15;

  @override
  List<Object?> get props => [city, country, main, description, icon, temperature];
}
