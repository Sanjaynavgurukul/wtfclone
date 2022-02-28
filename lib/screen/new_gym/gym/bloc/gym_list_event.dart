part of 'gym_list_bloc.dart';

@immutable
abstract class GymListEvent {}

class FetchGymListEvent extends GymListEvent {
  final String latitude;
  final String longitude;
  final String gymType;

  FetchGymListEvent({this.gymType, this.longitude, this.latitude});
}

class GymListFetchedEvent extends GymListEvent {
  final GymModel gymModel;

  GymListFetchedEvent({this.gymModel});
}

class LoadingEvent  extends GymListEvent{
}

class ErrorEvent extends GymListEvent{
  final String errorMessage;
  ErrorEvent({this.errorMessage});
}
