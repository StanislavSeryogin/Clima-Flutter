import 'package:clima/model/weather_model.dart';
import 'package:clima/repositotys/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:mockito/annotations.dart';

import 'weather_bloc_test.mocks.dart';


@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository weatherRepository;

  setUp(() {
    weatherRepository = MockWeatherRepository();
  });
  group('weather repositoty test', () {
    final weatherData = WeatherModel(
      city: 'San Francisco',
      country: 'US',
      description: 'overcast clouds',
      icon: '04n',
      main: 'Clouds',
      temperature: 12.76,
    );
    test('fetchWeatherData returns weather model', () async {
      when(weatherRepository.fetchWeatherData(any, any))
          .thenAnswer((_) => Future.value(weatherData));
      final result = await weatherRepository.fetchWeatherData(0.0, 0.0);
      expect(result, equals(weatherData));
    });
    test('fetchWeatherByCityName returns weather model', () async {
      when(weatherRepository.fetchWeatherByCityName(any))
          .thenAnswer((_) => Future.value(weatherData));
      final result = await weatherRepository.fetchWeatherByCityName('');
      expect(result, equals(weatherData));
    });
  });
}
