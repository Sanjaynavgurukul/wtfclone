import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';

import '../main.dart';
import 'AppPrefs.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<Map<String, dynamic>> get(String url,
      {Map<String, String> headers}) async {
    print("${url}  ${headers}");
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      log('RESP: $url \n ${response.body} \n status code: $statusCode');
      if (statusCode == 200 || statusCode == 201) {
        Map res = json.decode(response.body);
        if (res.containsKey('message') && res['message'] == 'invalid token') {
          await locator<AppPrefs>().clear();
          NavigationService.navigateToReplacement(Routes.loader);
        } else {
          //print('w849379834r98345344634863487r ');
          return _decoder.convert(response.body);
        }
      }
      if (statusCode < 200 || json == null) {
        return null;
      }

      return _decoder.convert(response.body);
    });
  }

  Future<dynamic> put(String url,
      {Map<String, String> headers, Map body}) async {
    print("${url}  ${headers}");
    log('body: ${body}');
    return http
        .put(Uri.parse(url), headers: headers, body: json.encode(body))
        .then((http.Response response) async {
      Map res = json.decode(response.body);
      final int statusCode = response.statusCode;
      log('res: ${res}');
      // if (res.containsKey('message') && res['message'] == 'invalid token') {
      //   await locator<AppPrefs>().clear();
      //   NavigationService.navigateToReplacement(Routes.loader);
      // }
      // if (statusCode < 200 || statusCode > 400 || json == null) {
      //   return null;
      // }
      return _decoder.convert(response.body);
    });
  }

  Future<dynamic> post(String url,
      {Map<String, String> headers, Map body, encoding}) {
    log('url: ${url}');
    log('body: ${body}');
    return http
        .post(Uri.parse(url),
            body: json.encode(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      print(response.body);
      final String res = response.body;
      final int statusCode = response.statusCode;

      /* if (statusCode != 200 || json == null) {
        throw new Exception("Error while fetching data");
      }*/
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postJsonBody(String url,
      {Map<String, String> headers, String body, encoding}) {
    print(body);
    return http
        .post(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      print(response.body);
      final String res = response.body;
      final int statusCode = response.statusCode;

      /* if (statusCode != 200 || json == null) {
        throw new Exception("Error while fetching data");
      }*/
      return _decoder.convert(res);
    });
  }

  Future<dynamic> getWithHeader(String url, {Map<String, String> headers}) {
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}
