import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  var temperature;
  var weatherIcon;
  var cityName;
  late String weatherMassage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherDate) {
   setState(() {
     if(weatherDate == null) {
       temperature = 0;
       weatherIcon = 'Error';
       weatherMassage = 'Unable to get weather date';
       cityName = '';
       return;
     }
     double temp = weatherDate['main']['temp'];
     temperature = temp.toInt();
     var condition = weatherDate['weather'][0]['id'];
     weatherIcon = weather.getWeatherIcon(condition);
     weatherMassage = weather.getMessage(temperature);
     cityName = weatherDate['name'];
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async{
                      var weatherDate = await weather.getLocationWeather();
                      updateUI(weatherDate);
                    },
                    icon: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
                    onPressed: () async{
                      var typedName = await Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typedName != null) {
                        var weatherDate = await weather.getCityWeather(typedName);
                        updateUI(weatherDate);
                      }
                    },
                    icon: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMassage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
