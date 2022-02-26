import 'package:rxdart/rxdart.dart';
import 'package:wtf/db/new/model/weather_response_model.dart';
import 'package:wtf/db/new/persistence/repository.dart';
import 'package:wtf/model/gym_model.dart';

class WeatherBloc {
  Repository _repository = Repository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of WeatherResponse object and pass it to the UI screen as a stream.
  final _weatherFetcher = PublishSubject<GymModel>();

  //This method is used to pass the weather response as stream to UI
  Stream<GymModel> get weather => _weatherFetcher.stream;

  fetchLondonWeather() async {
    GymModel weatherResponse = await _repository.fetchLondonWeather();
    _weatherFetcher.sink.add(weatherResponse);
  }

  dispose() {
    //Close the weather fetcher
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();
