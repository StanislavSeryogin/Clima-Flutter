import 'package:clima/model/weather_model.dart';
import 'package:flutter/material.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDisplay({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${weather.city}, ${weather.country}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Temperature: ${weather.tempInCelsius.toStringAsFixed(1)}°C',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
        Text(
          weather.description,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
        Text(
          weather.main,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
        Image.network(
          'http://openweathermap.org/img/wn/${weather.icon}.png',
          width: 100,
          height: 100,
        ),
      ],
    );
  }
}
