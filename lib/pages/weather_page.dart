import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clima/bloc/weather/weather_bloc.dart';
import 'package:clima/pages/weather_display.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isTextFieldVisible = false;

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: !isTextFieldVisible,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isTextFieldVisible = true;
                      });
                    },
                    child: Icon(Icons.search),
                  ),
                ),
                Visibility(
                  visible: isTextFieldVisible,
                  child: Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: kTextFieldInputDecoration,
                      onSubmitted: (value) {
                        setState(() {
                          isTextFieldVisible = false;
                        });
                        final cityName = _textEditingController.text;
                        weatherBloc.add(SearchWeather(cityName: cityName));
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
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
