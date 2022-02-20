part of 'change_diet_bloc.dart';

abstract class ChangeDietEvent {}

class _FetchAllDietEvent extends ChangeDietEvent {
  String dietType;

  _FetchAllDietEvent({this.dietType});
}

class _FetchedDietDataEvent extends ChangeDietEvent {
  List<CategoryDietModel> data;

  _FetchedDietDataEvent({@required this.data});
}

class _ErrorEvent extends ChangeDietEvent {
  String errorMessage;

  _ErrorEvent({this.errorMessage});
}

class _AddDietChangeLogEvent extends ChangeDietEvent {}
