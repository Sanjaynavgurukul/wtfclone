import 'package:get_it/get_it.dart';
import 'package:wtf/db/db_helper/response_helper.dart';
import 'package:wtf/db/demo_model/demo_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:wtf/helper/AppPrefs.dart';

part 'db_repository.dart';

final GetIt locator = GetIt.instance;

class DBProvider {

  final stream = Stream.periodic(Duration(seconds: 5)).asyncMap((_) async {
    // it was tested that the lifecycle aware stream made this occur only when the app is in foreground
    print("API call done");
    // you can call your server here

    return "API results";
  });


  // Stream<ResponseHelper> getDemoData()async{
  //   //User Id getting from SharePref :D
  //   String token = locator<AppPrefs>().token.getValue();
  //
  //   //Api Header
  //   Map<String, String> headers = Map();
  //   headers["Authorization"] = "Bearer " + token;
  //
  //   //Fetching Data response from database
  //   var request = http.Request(
  //       'GET', Uri.parse('application/x-www-form-urlencoded/bank/'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //
  //   //Handle response Status
  //   if (response.statusCode == 200) {
  //     var json = jsonDecode(await response.stream.bytesToString());
  //     return ResponseHelper(
  //         finalData: json, dbResponse: DbResponse.RESPONSE_SUCCESS);
  //   } else {
  //     return ResponseHelper(
  //         finalData: null, dbResponse: DbResponse.RESPONSE_FAILED);
  //   }
  // }

  Future<ResponseHelper> getDemoDatas() async {

    //User Id getting from SharePref :D
    String token = locator<AppPrefs>().token.getValue();

    //Api Header
    Map<String, String> headers = Map();
    headers["Authorization"] = "Bearer " + token;

    //Fetching Data response from database
    var request = http.Request(
        'GET', Uri.parse('application/x-www-form-urlencoded/bank/'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    //Handle response Status
    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      return ResponseHelper(
          finalData: json, dbResponse: DbResponse.RESPONSE_SUCCESS);
    } else {
      return ResponseHelper(
          finalData: null, dbResponse: DbResponse.RESPONSE_FAILED);
    }
  }
}
