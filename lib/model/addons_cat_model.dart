
class AddonsCatModel {
  // int id;
  // String uid;
  // String gym_id;
  // String name;
  // String description;
  // String price;
  // String image;
  // String status;
  // String date_added;
  // String last_updated;
  // bool free_seesion;
  // int is_pt;
  // bool is_live;
  // String category_id;
  // String gym_name;
  // String category_name;

  //Default Constructor :D

  int id;
  String uid;
  String name;
  String description;
  String image;
  String status;
  String date_added;
  String last_updated;

  //Default Constructor :D
  AddonsCatModel();

  String convertToString(dynamic key) {
    return key == null ? '' : key.toString();
  }

  bool convertToBool(String key) {
    return key == null
        ? false
        : key == 'false'
            ? false
            : true;
  }

  int convertToInt(String key) {
    return key == null ? 0 : int.parse(key ?? '0');
  }

  AddonsCatModel.fromJsonToModel(Map<String, dynamic> data) {
    this.id = int.parse(convertToString(data['id']) ?? '0');
    this.uid = data['uid'];
    this.name = data['name'];
    this.description = data['description'];
    this.image = convertToString(data['image']);
    this.status = convertToString(data['status']);
    this.date_added = convertToString(data['date_added']);
    this.last_updated = convertToString(data['last_updated']);
  }
}

///addoncat?page=1