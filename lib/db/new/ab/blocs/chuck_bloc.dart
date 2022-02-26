import 'dart:async';
import 'package:wtf/db/new/ab/networking/Repsonse.dart';
import 'package:wtf/db/new/ab/repository/chuck_repository.dart';
import 'package:wtf/db/new/ab/models/chuck_response.dart';

class ChuckBloc {
  ChuckRepository _chuckRepository;
  StreamController _chuckDataController;
  bool _isStreaming;

  StreamSink<Response<chuckResponse>> get chuckDataSink =>
      _chuckDataController.sink;

  Stream<Response<chuckResponse>> get chuckDataStream =>
      _chuckDataController.stream;

  ChuckBloc(String category) {
    _chuckDataController = StreamController<Response<chuckResponse>>();
    _chuckRepository = ChuckRepository();
    _isStreaming = true;
    fetchChuckyJoke(category);
  }

  fetchChuckyJoke(String category) async {
    chuckDataSink.add(Response.loading('Getting a Chucky joke!'));
    try {
      chuckResponse chuckJoke = await _chuckRepository.fetchChuckJoke(category);
      if (_isStreaming) chuckDataSink.add(Response.completed(chuckJoke));
    } catch (e) {
      if (_isStreaming) chuckDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _isStreaming = false;
    _chuckDataController?.close();
  }
}
