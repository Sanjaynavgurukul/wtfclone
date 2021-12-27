import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wtf/helper/AppPrefs.dart';

import '../main.dart';

// ---------------------------

const String endpoint = 'http://qa.api.mycosme.co.jp/api';

http.Client client = http.Client();

Map<String, String> appendAccessTokenWith(
    Map<String, String> headers, String accessToken) {
  final Map<String, String> requestHeaders = {
    'Authorization': "Bearer $accessToken"
  }..addAll(headers);
  return requestHeaders;
}

// Get base
Future<dynamic> fetchData(
    {String url, String queryParams = "", bool addToken = true}) async {
  Map<String, String> requestHeaders;
  if (addToken) {
    requestHeaders = appendAccessTokenWith({
      'Content-Type': 'application/json; charset=UTF-8',
    }, locator<AppPrefs>().token.getValue());
  } else {
    requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }
  if (queryParams.isNotEmpty) {
    // ignore: parameter_assignments
    url += "?$queryParams";
  }

  final response = await http.get(
    Uri.parse(url),
    headers: requestHeaders,
  );
  print(requestHeaders.toString());

  if (response.statusCode == 200) {
    log(jsonDecode(response.body).toString());

    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

// Post base
Future<dynamic> postData({String url, Map body, bool addToken = true}) async {
  Map<String, String> requestHeaders;
  log(body.toString());
  if (addToken) {
    requestHeaders = appendAccessTokenWith({
      'Content-Type': 'application/json; charset=UTF-8',
    }, locator<AppPrefs>().token.getValue());
  } else {
    requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  final response = await http.post(
    Uri.parse(url),
    headers: requestHeaders,
    body: jsonEncode(body),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    log(jsonDecode(response.body).toString());
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to post data');
  }
}

// Put base
Future<dynamic> putData(
    {String url,
    Map<String, dynamic> body,
    String queryParams = '',
    bool addToken = true,
    bool isMedia = false}) async {
  Map<String, String> requestHeaders;

  Map<String, String> _header = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  if (addToken) {
    requestHeaders =
        appendAccessTokenWith(_header, locator<AppPrefs>().token.getValue());
  } else {
    requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }
  if (queryParams.isNotEmpty) {
    // ignore: parameter_assignments
    url += "?$queryParams";
  }

  var response = await http.put(
    Uri.parse(url),
    headers: requestHeaders,
    body: jsonEncode(body),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    log(jsonDecode(response.body).toString());
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to post data');
  }
}

enum ApiState {
  Success,
  Error,
}

class ApiResponse<T> {
  ApiState state;
  T data;
  bool status;
  String messsage;
  ApiResponse({
    this.state,
    this.data,
    this.status,
    this.messsage,
  });

  static Future<ApiResponse> call({Future<dynamic> request}) async {
    try {
      var response;

      response = await request;

      if (response != null) {
        print('banner resp:: $response');
        return ApiResponse(
            status: response['status'],
            data: response['data'],
            messsage: response['message'] ?? '',
            state: ApiState.Success);
      }
    } catch (e) {
      // throw e;
      return ApiResponse(
        state: ApiState.Error,
        status: false,
        messsage: 'Something went wrong',
      );
    }
  }
}
