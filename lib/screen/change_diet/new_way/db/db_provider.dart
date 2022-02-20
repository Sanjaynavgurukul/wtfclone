import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/api_constants.dart';
import 'package:wtf/helper/api_helper.dart';
import 'package:wtf/helper/network_utils.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/diet_model.dart';

class DBProvider {
  NetworkUtil _netUtil = new NetworkUtil();
  static const String BASE_URL = APIHelper.BASE_URL;

  Future<List<DietModel>> getAllDietsCategory() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    List<DietModel> model;
    var res = await _netUtil
        .get(BASE_URL + Api.getAllDietDetails(), headers: mapHeader)
        .then((dynamic res) {
      if (res['status']) {
        model = (res['data'] as List)
            .map((p) => DietModel.fromJson(data: p))
            .toList();
      } else {
        model = [];
      }
    });
    return model;
  }

}
