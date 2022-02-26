import 'package:wtf/db/new/ab/networking/ApiProvider.dart';
import 'package:wtf/db/new/ab/models/chuck_response.dart';
import 'dart:async';

class ChuckRepository {
  ApiProvider _provider = ApiProvider();

  Future<chuckResponse> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=" + category);
    return chuckResponse.fromJson(response);
  }
}
