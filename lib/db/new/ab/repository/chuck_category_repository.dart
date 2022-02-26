import 'package:wtf/db/new/ab/networking/ApiProvider.dart';
import 'dart:async';
import 'package:wtf/db/new/ab/models/chuck_categories.dart';

class ChuckCategoryRepository {
  ApiProvider _provider = ApiProvider();

  Future<chuckCategories> fetchChuckCategoryData() async {
    final response = await _provider.get("jokes/categories");
    return chuckCategories.fromJson(response);
  }
}
