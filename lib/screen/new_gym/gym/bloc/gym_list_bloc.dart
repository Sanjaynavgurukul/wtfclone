import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wtf/db/db_helper/response_helper.dart';
import 'package:wtf/db/db_provider.dart';
import 'package:wtf/model/gym_model.dart';

part 'gym_list_event.dart';

part 'gym_list_state.dart';

class GymListBloc extends Bloc<GymListEvent, GymListState> {
  //Local Variables :D
  DBRepository _repository = DBRepository();

  GymListBloc() : super(GymListInitial()) {
    on<GymListEvent>((event, emit) {
      // FetchGymListEvent
      if (event is FetchGymListEvent) {
        _repository.getNearByGym(latitude: event.latitude,
            longitude: event.longitude,
            gymType: event.gymType).then((value) => _convertResponse(value));
      }

      // catching Error event
      if (event is ErrorEvent) {
        emit(ErrorState(errorMessage: event.errorMessage));
      }

      if(event is GymListFetchedEvent){
        emit(GymListFetchedState(gymModel: event.gymModel));
      }
    });
  }

  void _convertResponse(ResponseHelper responseHelper) {
    //checking network error :D
    if (responseHelper.dbResponse == DbResponse.RESPONSE_NETWORK_ERROR) {
      add(ErrorEvent(errorMessage: 'Please check your internet connection'));
    } else {
      GymModel model = responseHelper.finalData != null
          ? GymModel.fromJson(responseHelper.finalData)
          : GymModel(
        data: [],
        status: false,
      );
      //add fetched event
      add(GymListFetchedEvent(gymModel: model));
    }
  }

}
