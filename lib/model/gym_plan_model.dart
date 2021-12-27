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
  String planName;
  String planPrice;
  String taxPercentage;
  String uid;
  String planType;
  String image;
  String duration;

  GymPlanData({
    this.planName,
    this.planPrice,
    this.taxPercentage,
    this.uid,
    this.image,
    this.duration,
    this.planType,
  });

  factory GymPlanData.fromJson(Map<String, dynamic> json) {
    String img = json['images'];

    return GymPlanData(
      duration: json['duration'] ?? '',
      image: img != null
          ? img.replaceAll(
              'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com',
              'https://d1e9q0asw0l2kk.cloudfront.net')
          : '',
      planName: json['plan_name'],
      planPrice: json['plan_price'],
      taxPercentage: json['tax_percentage'],
      uid: json['plan_uid'] ?? '',
      planType: json['plan_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_name'] = this.planName;
    data['plan_price'] = this.planPrice;
    data['tax_percentage'] = this.taxPercentage;
    return data;
  }
}
