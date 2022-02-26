import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wtf/db/db_provider.dart';

part 'demo_event.dart';
part 'demo_state.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  //Local variable :D
  final DBRepository _dbRepository = new DBRepository();
  final StreamController _streamController = StreamController();

  DemoBloc() : super(DemoInitial()) {
    on<DemoEvent>((event, emit) {
      if(event is FetchDataEvent){
        final d = Stream.periodic(Duration(seconds: 5)).asyncMap((_) async {

        });

        _streamController.sink.add(d);
      }

      if(event is DataFetchedEvent){
        emit(FetchDataState());
      }
    });
  }

  void dataBinding(){
    add(DataFetchedEvent());
  }
}
