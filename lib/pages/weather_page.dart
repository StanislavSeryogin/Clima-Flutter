
import 'package:clima/blocs/weather/weather_bloc.dart';
import 'package:clima/pages/weather_display.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(FetchWeather());

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'City Name',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final cityName = _textEditingController.text;
                    weatherBloc.add(SearchWeather(cityName: cityName));
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    return WeatherDisplay(weather: state.weather);
                  } else if (state is WeatherError) {
                    return Text('Failed to fetch weather data');
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}