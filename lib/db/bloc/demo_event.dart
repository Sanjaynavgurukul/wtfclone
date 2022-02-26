part of 'demo_bloc.dart';

@immutable
abstract class DemoEvent {}

class FetchDataEvent extends DemoEvent{}

class DataFetchedEvent extends DemoEvent{}

