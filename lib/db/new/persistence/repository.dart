import 'package:wtf/model/gym_model.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<GymModel> fetchLondonWeather() => appApiProvider.fetchLondonWeather();
}