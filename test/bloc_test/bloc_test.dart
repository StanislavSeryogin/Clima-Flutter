import 'package:clima/model/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clima/bloc/weather/weather_bloc.dart';

import '../repository_test/weather_bloc_test.mocks.dart';

void main() {
  late MockWeatherRepository weatherRepository;
  late WeatherBloc weatherBloc;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    weatherBloc = WeatherBloc(weatherRepository: weatherRepository);
  });

  test('SearchWeather event emits WeatherLoaded state', () {
    final weatherData = WeatherModel(
      city: 'San Francisco',
      country: 'US',
      description: 'overcast clouds',
      icon: '04n',
      main: 'Clouds',
      temperature: 12.76,
    );
    when(weatherRepository.fetchWeatherByCityName(''))
        .thenAnswer((_) => Future.value(weatherData));
    final expected = [
      WeatherLoading(),
      WeatherLoaded(weather: weatherData),
    ];
    expectLater(weatherBloc.stream, emitsInOrder(expected));
    weatherBloc.add(SearchWeather(cityName: ''));
  });

  tearDown(() {
    weatherBloc.close();
  });
}
