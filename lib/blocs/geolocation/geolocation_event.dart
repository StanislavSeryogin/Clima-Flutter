// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object> get props => [];
}

class LoadGeolocation extends GeolocationEvent {}

class UpdateGeolocation extends GeolocationEvent {
  final Position position;
  UpdateGeolocation({
    required this.position,
  });
  @override
  List<Object> get props => [position];
}
