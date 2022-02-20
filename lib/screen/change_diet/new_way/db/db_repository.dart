import 'package:wtf/model/diet_model.dart';
import 'package:wtf/screen/change_diet/new_way/db/db_provider.dart';
class DBRepository{
  final DBProvider _provider = new DBProvider();

  Future<List<DietModel>> getAllDiet()=> _provider.getAllDietsCategory();
}