import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wtf/model/diet_model.dart';
import 'package:wtf/screen/change_diet/new_way/db/db_repository.dart';

part 'change_diet_event.dart';

part 'change_diet_state.dart';

class ChangeDietBloc extends Bloc<ChangeDietEvent, ChangeDietState> {
  final DBRepository _repository = new DBRepository();

  ChangeDietBloc() : super(ChangeDietInitial()) {
    on<ChangeDietEvent>((event, emit) {
      if (event is _FetchAllDietEvent) {
        emit(_LoadingState());
        _repository
            .getAllDiet()
            .then((value) => sortList(value, event.dietType));
      }

      if (event is _FetchedDietDataEvent) {
        emit(_FetchedDietDataState(data: event.data));
      }

      if (event is _ErrorEvent) {
        emit(_ErrorState(errorMessage: event.errorMessage));
      }
    });
  }

  void sortList(List<DietModel> value, String dietType) {
    List<String> productId = ['Lean', 'Gain', 'Maintain'];
    List<CategoryDietModel> data = productId
        .map((category) => CategoryDietModel(
            categoryLabel: category,
            products: value
                .where((product) =>
                    product.type1_name == category &&
                    product.type2_name == dietType)
                .toList()))
        .toList();
    add(_FetchedDietDataEvent(data: data));
  }
}
