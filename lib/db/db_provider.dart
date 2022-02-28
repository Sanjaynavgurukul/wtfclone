import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wtf/db/db_helper/response_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/api_constants.dart';
import 'package:wtf/helper/api_helper.dart';
import 'package:wtf/helper/network_utils.dart';

part 'db_repository.dart';

final GetIt locator = GetIt.instance;

class DBProvider {
  //Local Variables :D
  NetworkUtil _netUtil = new NetworkUtil();

  String baseApiUrl = APIHelper.BASE_URL;

  // static const String BASE_URL = 'http://13.232.102.139:9000/';

  static Map<String, String> header = {
    "Authorization": "Bearer ${locator<AppPrefs>().token.getValue()}"
  };

  Future<bool> networkCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<ResponseHelper> getResponse({@required String apiURL}) async {
    //checking network check
    bool check = await networkCheck() ?? false;
    if (!check)
      return ResponseHelper(
          finalData: null, dbResponse: DbResponse.RESPONSE_NETWORK_ERROR);

    //Fetching Data response from database
    var request = http.Request('GET', Uri.parse('$apiURL'));
    request.headers.addAll(header);
    http.StreamedResponse response = await request.send();

    //Handle response Status
    if (response.statusCode == 200) {
      log('TAG getNearByGym response : $response');

      var json = jsonDecode(await response.stream.bytesToString());
      return ResponseHelper(
          finalData: json, dbResponse: DbResponse.RESPONSE_SUCCESS);
    } else {
      return ResponseHelper(
          finalData: null, dbResponse: DbResponse.RESPONSE_FAILED);
    }
  }

  Future<ResponseHelper> getNearByGym(
      {@required String latitude,
      @required String longitude,
      @required String gymType}) async {
    //Api URL
    String apiURL = baseApiUrl + Api.getNearByGym(latitude, longitude, gymType);
    //Fetching Data response from database
    return getResponse(apiURL: apiURL);
  }
}
