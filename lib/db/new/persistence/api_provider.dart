import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' show Client;
import 'package:wtf/db/new/model/weather_response_model.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/api_constants.dart';
import 'package:wtf/helper/api_helper.dart';
import 'package:wtf/helper/network_utils.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/gym_model.dart';

class ApiProvider {
  Client client = Client();

  //This is the London weather API url available at this link: https://openweathermap.org/current
  final _baseUrl =
      "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22";


  NetworkUtil _netUtil = new NetworkUtil();

  static const String BASE_URL = APIHelper.BASE_URL;
  // static const String BASE_URL = 'http://13.232.102.139:9000/';

  static Map<String, String> header = {
    "Authorization": "Bearer ${locator<AppPrefs>().token.getValue()}"
  };

  Future<GymModel> fetchLondonWeather() async {
    String lat = '24.607104';
    String lng = '73.7323645';
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();

    mapHeader["Authorization"] = "Bearer " + token;
    String url = BASE_URL + Api.getGyms(lat, lng);
    log('URL: $url');
    return _netUtil
        .get(
      url,
      headers: mapHeader,
    )
        .then((dynamic res) {
      print("response getGym : " + res.toString());
      GymModel model = res != null
          ? GymModel.fromJson(res)
          : GymModel(
        data: [],
        status: false,
      );
      return model;
    });
  }

  Future<WeatherResponse> fetchLondonWeathers() async {
    // final response = await client.get("$_baseUrl");
    // Make the network call asynchronously to fetch the London weather data.
    final response = await client.get(Uri.parse(_baseUrl));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}