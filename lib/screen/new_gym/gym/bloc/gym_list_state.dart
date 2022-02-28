part of 'gym_list_bloc.dart';

@immutable
abstract class GymListState {}

class GymListInitial extends GymListState {}

class GymListFetchedState extends GymListState {
  final GymModel gymModel;

  GymListFetchedState({this.gymModel});
}

class LoadingState  extends GymListState{
}

class ErrorState extends GymListState{
  final String errorMessage;
  ErrorState({this.errorMessage});
}
