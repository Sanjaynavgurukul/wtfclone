
class AddonsCatModel {
  int id;
  String uid;
  String name;
  String description;
  String image;
  String status;
  String date_added;
  String last_updated;
  CatAddonsSlotsModel addons;

  //Default Constructor :D
  AddonsCatModel();

  AddonsCatModel.fromJsonToModel(Map<String, dynamic> data) {
    this.id = int.parse(convertToString(data['id'].toString()) ?? '0');
    this.uid = data['uid'];
    this.name = data['name'];
    this.description = data['description'];
    this.image = convertToString(data['image']);
    this.status = convertToString(data['status']);
    this.date_added = convertToString(data['date_added']);
    this.last_updated = convertToString(data['last_updated']);
  }
}

String convertToString(dynamic key) {
  return key == null ? '' : key.toString();
}

bool convertToBool(String key) {
  return key == 'null'
      ? false
      : key == 'false'
      ? false
      : true;
}

int convertToInt(String key) {
  return key == "null" ? 0 : int.parse(key ?? '0');
}

class CatAddonsSlotsModel{
  int  id;
  String uid;
  String name;
  String gym_id;
  String description;
  String price;
  String image;
  String status;
  String date_added;
  String last_updated;
  bool free_seesion;//": "true",
  int is_pt;//": "0",
  bool is_live;//": false,
  String category_id;//": "1GcawD2d54AuI"

  //Default Constructor :D
  CatAddonsSlotsModel();

  CatAddonsSlotsModel.fromJsonToModel(Map<String, dynamic> data) {
    this.id = int.parse(convertToString(data['id'].toString()) ?? '0');
    this.uid = data['uid'];
    this.name = data['name'];
    this.gym_id = data['gym_id'];
    this.description = data['description'];
    this.price = data['price'];
    this.image = convertToString(data['image']);
    this.status = convertToString(data['status']);
    this.date_added = convertToString(data['date_added']);
    this.last_updated = convertToString(data['last_updated']);
    this.free_seesion = convertToBool(data['free_seesion'].toString());
    this.is_pt = convertToInt(data['is_pt'].toString());
    this.is_live = convertToBool(data['is_live'].toString());
    this.category_id = data['category_id'].toString();
  }
}
