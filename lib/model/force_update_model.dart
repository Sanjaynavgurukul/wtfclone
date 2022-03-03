class ForceUpdateModel {
  // String description;
  // int version_code;
  // bool forceUpdate;
  // String play_store_path;
  // String app_store_path;
  // bool notify_update;
  // bool greater_then;
  // bool less_then;
  int id;
  String uid;
  String wtf_version;
  String google_version;
  String apple_version;
  String date_added;

  //Default Constructor :
  ForceUpdateModel({
    this.id,
    this.date_added,
    this.uid,
    this.apple_version,
    this.google_version,
    this.wtf_version,
  });

  factory ForceUpdateModel.fromJson(Map<String, dynamic> json) => ForceUpdateModel(
      id: json["id"],
      date_added: json["date_added"],
      uid: json["uid"],
      apple_version: json["apple_version"],
      google_version: json["google_version"],
      wtf_version: json["wtf_version"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_added": date_added,
    "uid": uid,
    "apple_version": apple_version,
    "google_version": google_version,
    "wtf_version": wtf_version,
  };
}
