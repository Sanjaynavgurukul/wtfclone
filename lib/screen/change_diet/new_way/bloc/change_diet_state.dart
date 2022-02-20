part of 'change_diet_bloc.dart';

abstract class ChangeDietState {}

class ChangeDietInitial extends ChangeDietState {}

class _AddDietChangeLogState extends ChangeDietState {}

class _LoadingState extends ChangeDietState {
}

class _ErrorState extends ChangeDietState {
  String errorMessage;

  _ErrorState({this.errorMessage});
}

class _FetchedDietDataState extends ChangeDietState {
  List<CategoryDietModel> data;

  _FetchedDietDataState({@required this.data});
}
