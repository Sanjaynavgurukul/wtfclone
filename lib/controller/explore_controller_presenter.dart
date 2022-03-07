import 'package:wtf/controller/webservice.dart';
import 'package:wtf/model/common_model.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/model/gym_plan_model.dart';
import 'package:wtf/model/gym_search_model.dart';
import 'package:wtf/model/gym_slot_model.dart';

abstract class ExploreContract {
  void onGetGymSuccess(GymModel model);
  void onGetGymDetailsSuccess(GymDetailsModel model);
  void onsearchGymSuccess(GymSearchModel model);
  void onGymPlansSuccess(GymPlanModel model);
  void onGymSlotSuccess(GymSlotModel model);
  void onAddSubscriptionSuccess(CommonModel model);

  // void onGetCourseWiseMaterialsSuccess(CourseWiseMaterialsModel model);
  void onGetGymError(Object errorTxt);
}

class ExplorePresenter {
  ExploreContract _view;
  RestDatasource api = new RestDatasource();

  ExplorePresenter(this._view);

  // getAllMaterials() async {

  //   api.getAllMaterials().then(
  //     (AllMaterialModel model) {
  //       if (model.success) {
  //         _view.onGetAllMaterialsSuccess(model);
  //       } else {
  //         _view.onGetAllMaterialsError(model.message);
  //       }
  //     },
  //   );
  // }

  getGym() async {
    print("get Gym 1");
    api.getGym().then(
      (GymModel model) {
        if (model != null && model.status) {
          _view.onGetGymSuccess(model);
        } else {
          _view.onGetGymError(model?.message ?? '');
        }
      },
    );
  }

  getGymDetails(String gymId) async {
    print("get Gym Details 1");
    api.getGymDetails(gymId).then(
      (GymDetailsModel model) {
        if (model.status) {
          _view.onGetGymDetailsSuccess(model);
        } else {
          _view.onGetGymError(model.status);
        }
      },
    );
  }

  searchGym({String name, String lat, String lng}) async {
    print("get Gym Details 1");
    api.searchGym(name:name,lng: lng,lat: lat).then(
      (GymSearchModel model) {
        if (model.status) {
          _view.onsearchGymSuccess(model);
        } else {
          _view.onGetGymError(model.message);
        }
      },
    );
  }

  getGymPlans(String gymId) async {
    print("get Gym Details 1");
    api.getGymPlans(gymId: gymId).then(
      (GymPlanModel model) {
        if (model.status) {
          _view.onGymPlansSuccess(model);
        } else {
          _view.onGetGymError(model.message);
        }
      },
    );
  }

  getGymSlots(String gymId) async {
    print("get Gym Details 1");
    api.getGymSlot(gymId).then(
      (GymSlotModel model) {
        if (model.status) {
          _view.onGymSlotSuccess(model);
        } else {
          _view.onGetGymError(model.message);
        }
      },
    );
  }

  addSubscription(
      String price, Map<String, dynamic> body, String planId) async {
    print("get Gym Details 1");
    api.addSubscritpion(body).then(
      (CommonModel model) {
        if (model.status) {
          _view.onAddSubscriptionSuccess(model);
        } else {
          _view.onGetGymError(model.message);
        }
      },
    );
  }
}
