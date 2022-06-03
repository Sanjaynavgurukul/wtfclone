

class RecommendedProgramModel{
  //Default Constructor D:
  RecommendedProgramModel({this.status, this.data});

  bool status;
  List<RecommendedProgramModelData> data;

  factory RecommendedProgramModel.fromJson(Map<String, dynamic> json) =>
      RecommendedProgramModel(
        status: json["status"],
        data: json.containsKey('data')
            ? List<RecommendedProgramModelData>.from(
            json["data"].map((x) => RecommendedProgramModelData.fromJson(x)))
            : [],
      );
}
class RecommendedProgramModelData{
  String uid;
  String name;
  String description;
  String status;
  String type;

  RecommendedProgramModelData({this.status,this.description,this.uid,this.type,this.name});

  factory RecommendedProgramModelData.fromJson(Map<String, dynamic> json) {
    return RecommendedProgramModelData(
      uid: json["uid"] == null ? '' : json["uid"],
      name: json["name"] == null ? '' : json["name"],
      description: json["description"] == null ? '' : json["description"],
      status: json["status"] == null ? '' : json["status"],
      type: json["type"] == null ? '' : json["type"],
    );
  }
}