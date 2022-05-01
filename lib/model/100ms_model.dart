class MsModel {
  bool status;
  String message;
  String token;
  MsData data;

  MsModel({this.status, this.message, this.token, this.data});

  factory MsModel.fromJson(Map<String, dynamic> json) => MsModel(
      status: json["status"],
      message: json["message"],
      token: json["token"],
      data: MsData.fromJson(json["data"]));
}

class MsData {
  String id;
  String name;
  String description;
  bool status;
  bool recording_source_template;
  String template;
  String template_id;
  String user;
  String customer;
  String created_at;
  String updated_at;

  MsData(
      {this.status,
      this.user,
      this.name,
      this.created_at,
      this.customer,
      this.description,
      this.id,
      this.recording_source_template,
      this.template,
      this.template_id,
      this.updated_at});

  factory MsData.fromJson(Map<String, dynamic> json) => MsData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        recording_source_template: json["recording_source_template"],
        template: json["template"],
        template_id: json["template_id"],
        user: json["user"],
        customer: json["customer"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );
}
