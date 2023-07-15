import 'package:bloc/bloc.dart';
import 'package:clima/model/weather_model.dart';
import 'package:clima/repositotys/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
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
      final weather = await weatherRepository.fetchWeatherData(
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
      final weather =
          await weatherRepository.fetchWeatherByCityName(event.cityName);
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      emit(WeatherError());
    }
  }

  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield* _mapFetchWeatherToState(event);
    } else if (event is SearchWeather) {
      yield* _mapSearchWeatherToState(event);
    }
  }

  Stream<WeatherState> _mapFetchWeatherToState(FetchWeather event) async* {
    yield WeatherLoading();
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final weather = await weatherRepository.fetchWeatherData(
        position.latitude,
        position.longitude,
      );
      yield WeatherLoaded(weather: weather);
    } catch (e) {
      yield WeatherError();
    }
  }

  Stream<WeatherState> _mapSearchWeatherToState(SearchWeather event) async* {
    yield WeatherLoading();
    try {
      final weather =
          await weatherRepository.fetchWeatherByCityName(event.cityName);
      yield WeatherLoaded(weather: weather);
    } catch (e) {
      yield WeatherError();
    }
  }
}
