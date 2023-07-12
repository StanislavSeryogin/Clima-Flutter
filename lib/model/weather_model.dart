import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final int condition;
  final String weatherIcon;
  final String message;

  WeatherModel({
    required this.condition,
    required this.weatherIcon,
    required this.message,
  });

  @override
  List<Object?> get props => [condition, weatherIcon, message];

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      condition: json['weather'][0]['id'],
      weatherIcon: json['weather'][0]['icon'],
      message: json['weather'][0]['main'],
    );
  }

  @override
  bool get stringify => true;
}
