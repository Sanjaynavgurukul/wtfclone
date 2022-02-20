import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_diet_event.dart';
part 'change_diet_state.dart';

class ChangeDietBloc extends Bloc<ChangeDietEvent, ChangeDietState> {

  ChangeDietBloc() : super(ChangeDietInitial()) {
    on<ChangeDietEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
