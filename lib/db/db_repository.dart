part of 'db_provider.dart';

class DBRepository {
  //Private Variable :D
  DBProvider _dbProvider = DBProvider();

  Future<ResponseHelper> getNearByGym(
          {@required String latitude,
          @required String longitude,
          @required String gymType}) =>
      _dbProvider.getNearByGym(
          latitude: latitude, longitude: longitude, gymType: gymType);
}
