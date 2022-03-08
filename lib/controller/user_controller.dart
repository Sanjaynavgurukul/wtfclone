import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/flash_helper.dart';

import '../main.dart';

class UserController extends ChangeNotifier {
  bool loading = false;

  bool get isLoading => loading;

  String name = locator<AppPrefs>().userName.getValue();
  String gender = locator<AppPrefs>().gender.getValue();
  String address = locator<AppPrefs>().memberData.getValue().name != null
      ? locator<AppPrefs>().memberData.getValue().location
      : null;
  int age = 25;
  double heightFeet = locator<AppPrefs>().memberData.getValue().height != null
      ? double.parse(locator<AppPrefs>()
      .memberData
      .getValue()
      .height
      .contains("'")
      ? '${locator<AppPrefs>().memberData.getValue().height.split("'")[0]}'
      : locator<AppPrefs>().memberData.getValue().height)
      : 5.0;
  int inches = locator<AppPrefs>().memberData.getValue().height != null &&
      locator<AppPrefs>().memberData.getValue().height.contains("'")
      ? int.parse(
      locator<AppPrefs>().memberData.getValue().height.split("'")[1])
      : 5;
  int weight = locator<AppPrefs>().memberData.getValue().weight != null
      ? int.parse(locator<AppPrefs>().memberData.getValue().weight)
      : 60;
  int targetWeight = locator<AppPrefs>().memberData.getValue().name != null
      ? int.parse(locator<AppPrefs>().memberData.getValue().targetWeight)
      : 75;
  var goalWeight = 0.25;
  String bodyType = locator<AppPrefs>().memberData.getValue().bodyType != null
      ? locator<AppPrefs>().memberData.getValue().bodyType
      : '';
  String activeType =
  locator<AppPrefs>().memberData.getValue().howActive != null
      ? locator<AppPrefs>().memberData.getValue().howActive
      : '';
  bool isSmoking = locator<AppPrefs>().memberData.getValue().isSmoking != null
      ? locator<AppPrefs>().memberData.getValue().isSmoking == 'true'
      : false;
  bool isDrinking = locator<AppPrefs>().memberData.getValue().isDrinking != null
      ? locator<AppPrefs>().memberData.getValue().isDrinking == 'true'
      : false;
  List<String> existingDisease =
  locator<AppPrefs>().memberData.getValue().existingDisease != null
      ? locator<AppPrefs>()
      .memberData
      .getValue()
      .existingDisease
      .split(',')
      .toList()
      : [];
  String type1 = locator<AppPrefs>().type1.getValue() != null
      ? locator<AppPrefs>().type1.getValue()
      : '';
  String type2 = locator<AppPrefs>().type2.getValue() != null
      ? locator<AppPrefs>().type2.getValue()
      : '';

  setValue({
    String name,
    String gender,
    String address,
    int age,
    double heightFeet,
    int inches,
    int weight,
    int targetWeight,
    var goalWeight,
    String bodyType,
    String activeType,
    bool isSmoking,
    bool isDrinking,
    String existingDisease,
    String type1,
    String type2,
  }) {
    this.name = name == null ? this.name : name;
    this.gender = gender == null ? this.gender : gender;
    this.address = address == null ? this.address : address;
    this.age = age == null ? this.age : age;
    this.heightFeet = heightFeet == null ? this.heightFeet : heightFeet;
    this.inches = inches == null ? this.inches : inches;
    this.weight = weight == null ? this.weight : weight;
    this.targetWeight = targetWeight == null ? this.targetWeight : targetWeight;
    this.goalWeight = goalWeight == null ? this.goalWeight : goalWeight;
    this.bodyType = bodyType == null ? this.bodyType : bodyType;
    this.isSmoking = isSmoking == null ? this.isSmoking : isSmoking;
    this.isDrinking = isDrinking == null ? this.isDrinking : isDrinking;
    this.existingDisease =
    existingDisease == null ? this.existingDisease : existingDisease;
    this.activeType = activeType == null ? this.activeType : activeType;
    this.type1 = type1 == null ? this.type1 : type1;
    this.type2 = type2 == null ? this.type2 : type2;
    notifyListeners();
  }

//type1,type2
  Future<dynamic> addMember({BuildContext context}) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> body = {
      'user_id': locator<AppPrefs>().memberId.getValue(),
      'name': locator<AppPrefs>().userName.getValue(),
      'email': locator<AppPrefs>().userEmail.getValue(),
      'age': age,
      'gender': gender,
      'height': heightFeet,
      'weight': weight,
      'target_weight': targetWeight,
      'target_duration': goalWeight.toStringAsFixed(2),
      'location': address,
      'lat': context.read<GymStore>().currentPosition.latitude ?? '',
      'long': context.read<GymStore>().currentPosition.longitude ?? '',
      'body_type': bodyType,
      'existing_disease': existingDisease.join(','),
      'is_smoking': isSmoking,
      'is_drinking': isDrinking,
      'howactive': activeType,
      'type1': type1,
      'type2': type2,
    };
    print('body: $body');
    Map<String, dynamic> res = await RestDatasource().addMember(body);
    print('controller response: $res');
    loading = false;
    notifyListeners();
    return res;
  }

  Future<dynamic> updateMember({BuildContext context}) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> body = {
      "uid": locator<AppPrefs>().memberData.getValue().uid,
      "user_uid": locator<AppPrefs>().memberId.getValue(),
      'name': locator<AppPrefs>().userName.getValue(),
      'email': locator<AppPrefs>().userEmail.getValue(),
      'age': age,
      'gender': gender,
      'location': address,
      'lat': context.read<GymStore>().currentPosition?.latitude ??
          locator<AppPrefs>().memberData.getValue().lat,
      'long': context.read<GymStore>().currentPosition?.longitude ??
          locator<AppPrefs>().memberData.getValue().long,
      'body_type': bodyType,
      "is_smoking": isSmoking,
      "is_drinking": isDrinking,
      'height': heightFeet,
      'weight': weight,
      'target_weight': targetWeight,
      'target_duration': goalWeight.toStringAsFixed(2),
      'existing_disease': existingDisease.join(','),
      'type1': type1,
      'type2': type2,
      'status': 'active',
    };
    print('body: $body');
    locator<AppPrefs>().updateMemberData.setValue(false);
    Map<String, dynamic> res = await RestDatasource().updateMember(body);
    print('controller response: $res');
    loading = false;
    if (res['status'] == true) {
      FlashHelper.successBar(context, message: 'Profile Updates Successfully');
    }
    notifyListeners();
    return res;
  }
}

class UserUpdateController extends ChangeNotifier {
  bool loading = false;

  bool get isLoading => loading;

  String name = locator<AppPrefs>().userName.getValue();
  String gender = locator<AppPrefs>().gender.getValue();
  String address = locator<AppPrefs>().memberData.getValue() != null
      ? locator<AppPrefs>().memberData.getValue().location
      : null;
  int age = 25;
  double heightFeet = locator<AppPrefs>().memberData.getValue() != null
      ? double.parse(locator<AppPrefs>().memberData.getValue().height)
      : 5.0;
  int inches = 5;
  int weight = locator<AppPrefs>().memberData.getValue() != null
      ? int.parse(locator<AppPrefs>().memberData.getValue().weight)
      : 60;
  int targetWeight = locator<AppPrefs>().memberData.getValue() != null
      ? int.parse(locator<AppPrefs>().memberData.getValue().targetWeight)
      : 75;
  var goalWeight = 0.25;
  String bodyType = locator<AppPrefs>().memberData.getValue() != null
      ? locator<AppPrefs>().memberData.getValue().bodyType
      : '';
  String activeType = locator<AppPrefs>().memberData.getValue() != null
      ? locator<AppPrefs>().memberData.getValue().howActive
      : '';
  bool isSmoking = locator<AppPrefs>().memberData.getValue() != null
      ? locator<AppPrefs>().memberData.getValue().isSmoking == 'true'
      : false;
  bool isDrinking = locator<AppPrefs>().memberData.getValue() != null
      ? locator<AppPrefs>().memberData.getValue().isDrinking == 'true'
      : false;
  List<String> existingDisease =
  locator<AppPrefs>().memberData.getValue() != null
      ? locator<AppPrefs>()
      .memberData
      .getValue()
      .existingDisease
      .split(',')
      .toList()
      : [];
  String type1 = locator<AppPrefs>().type1.getValue() != null
      ? locator<AppPrefs>().type1.getValue()
      : '';
  String type2 = locator<AppPrefs>().type2.getValue() != null
      ? locator<AppPrefs>().type2.getValue()
      : '';

  setValue({
    String name,
    String gender,
    String address,
    int age,
    double heightFeet,
    int inches,
    int weight,
    int targetWeight,
    var goalWeight,
    String bodyType,
    String activeType,
    bool isSmoking,
    bool isDrinking,
    String existingDisease,
    String type1,
    String type2,
  }) {
    this.name = name == null ? this.name : name;
    this.gender = gender == null ? this.gender : gender;
    this.address = address == null ? this.address : address;
    this.age = age == null ? this.age : age;
    this.heightFeet = heightFeet == null ? this.heightFeet : heightFeet;
    this.inches = inches == null ? this.inches : inches;
    this.weight = weight == null ? this.weight : weight;
    this.targetWeight = targetWeight == null ? this.targetWeight : targetWeight;
    this.goalWeight = goalWeight == null ? this.goalWeight : goalWeight;
    this.bodyType = bodyType == null ? this.bodyType : bodyType;
    this.isSmoking = isSmoking == null ? this.isSmoking : isSmoking;
    this.isDrinking = isDrinking == null ? this.isDrinking : isDrinking;
    this.existingDisease =
    existingDisease == null ? this.existingDisease : existingDisease;
    this.activeType = activeType == null ? this.activeType : activeType;
    this.type1 = type1 == null ? this.type1 : type1;
    this.type2 = type2 == null ? this.type2 : type2;
    notifyListeners();
  }

  Future<dynamic> addMember({BuildContext context}) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> body = {
      'user_id': locator<AppPrefs>().memberId.getValue(),
      'name': locator<AppPrefs>().userName.getValue(),
      'email': locator<AppPrefs>().userEmail.getValue(),
      'age': age,
      'gender': gender,
      'height': heightFeet,
      'weight': weight,
      'target_weight': targetWeight,
      'target_duration': goalWeight.toStringAsFixed(2),
      'location': address,
      'lat': context.read<GymStore>().currentPosition.latitude ?? '',
      'long': context.read<GymStore>().currentPosition.longitude ?? '',
      'body_type': bodyType,
      'existing_disease': existingDisease.join(','),
      'is_smoking': isSmoking,
      'is_drinking': isDrinking,
      'howactive': activeType,
      'type1': type1,
      'type2': type2,
    };
    print('body: $body');
    Map<String, dynamic> res = await RestDatasource().addMember(body);
    print('controller response: $res');
    loading = false;
    notifyListeners();
    return res;
  }

  Future<dynamic> updateMember({BuildContext context}) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> body = {
      'uid': locator<AppPrefs>().userData.getValue().uid,
      'user_id': locator<AppPrefs>().memberId.getValue(),
      'name': locator<AppPrefs>().userName.getValue(),
      'email': locator<AppPrefs>().userEmail.getValue(),
      'age': age,
      'gender': gender,
      'height': heightFeet,
      'weight': weight,
      'target_weight': targetWeight,
      'target_duration': goalWeight.toStringAsFixed(2),
      'location': address,
      'lat': context.read<GymStore>().currentPosition.latitude ?? '',
      'long': context.read<GymStore>().currentPosition.longitude ?? '',
      'body_type': bodyType,
      'existing_disease': existingDisease.join(','),
      'is_smoking': isSmoking,
      'is_drinking': isDrinking,
      'howactive': activeType,
      'type1': type1,
      'type2': type2,
    };
    print('body: $body');
    locator<AppPrefs>().updateMemberData.setValue(false);
    Map<String, dynamic> res = await RestDatasource().updateMember(body);
    print('controller response: $res');
    loading = false;
    notifyListeners();
    return res;
  }
}