class GymPlanModel {
  bool status;
  String message;
  List<GymPlanData> data;

  GymPlanModel({this.status, this.message, this.data});

  GymPlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<GymPlanData>();
      json['data'].forEach((v) {
        data.add(new GymPlanData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class GymPlanData {
  int id;
  String plan_uid;
  String plan_name;
  String plan_type;
  String plan_price;
  String tax_percentage;
  String date_added;
  String last_updated;
  String status;
  String duration;
  String image;
  String description;
  String trainer_id;
  String trainer_name;
  int is_recomended;
  String gym_name;

  GymPlanData(
      {this.status,
      this.plan_uid,
      this.duration,
      this.description,
      this.date_added,
      this.last_updated,
      this.id,
      this.gym_name,
      this.image,
      this.is_recomended,
      this.plan_name,
      this.plan_type,
      this.plan_price,
      this.tax_percentage,
      this.trainer_id,
      this.trainer_name});

  factory GymPlanData.fromJson(Map<String, dynamic> json) {
    String img = json['images'];

    return GymPlanData(
      status: json['status'] ?? '',
      plan_uid: json['plan_uid'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
      date_added: json['date_added'] ?? '',
      last_updated: json['last_updated'] ?? '',
      id: json['id'] ?? 0,
      gym_name: json['gym_name'] ?? '',
      image: img != null
          ? img.replaceAll(
          'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com',
          'https://d1e9q0asw0l2kk.cloudfront.net')
          : '',
      is_recomended: json['is_recomended'] ?? 0,
      plan_name: json['plan_name'] ?? '',
      plan_type: json['plan_type'] ?? '',
      plan_price: json['plan_price'] ?? '',
      tax_percentage: json['tax_percentage'] ?? '',
      trainer_id: json['trainer_id'] ?? '',
      trainer_name: json['trainer_name'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['status'] = this.status;
    data['plan_uid'] = this.plan_uid;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['date_added'] = this.date_added;
    data['last_updated'] = this.last_updated;
    data['id'] = this.id;
    data['gym_name'] = this.gym_name;
    data['image'] = this.image;
    data['is_recomended'] = this.is_recomended;
    data['plan_name'] = this.plan_name;
    data['plan_type'] = this.plan_type;
    data['plan_price'] = this.plan_price;
    data['tax_percentage'] = this.tax_percentage;
    data['trainer_id'] = this.trainer_id;
    data['trainer_name'] = this.trainer_name;

    return data;
  }
}
