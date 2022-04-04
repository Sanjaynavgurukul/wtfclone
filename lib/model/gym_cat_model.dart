class GymCatModel {
  int id;
  String uid;
  String category_name;
  num price_start;
  num price_end;
  String status;
  String date_added;
  String last_updated;
  String description;
  String image;
  String banner;

  //Default Constructor :D
  GymCatModel();

  GymCatModel.fromJsonToModel(Map<String, dynamic> data) {
    this.id = int.parse(convertToString(data['id'].toString()) ?? '0');
    this.uid = data['uid'];
    this.category_name = data['category_name'];
    this.price_start = convertToInt(data['price_start'].toString());
    this.price_end = convertToInt(data['price_end'].toString());
    this.status = data['status'];
    this.date_added = data['date_added'];
    this.last_updated = data['last_updated'];
    this.description = data['description'];
    this.image = convertToString(data['image']);
    this.banner = convertToString(data['banner']);
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

num convertToInt(String key) {
  return key == "null" ? 0 : num.parse(key ?? '0');
}
