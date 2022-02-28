import 'package:wtf/model/gym_model.dart';

class GymSearchModel {
  bool status;
  String message;
  List<GymModelData> data;

  GymSearchModel({this.status, this.message, this.data});

  GymSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = List<GymModelData>.from(json["data"].map((x) => GymModelData.fromJson(x)));
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

class Data {
  String uid;
  String name;
  String gymName;
  String gymId;
  String address1;
  String address2;
  String city;
  String state;
  String country;
  String leaseAgreement;
  String electricityBill;
  String bankStatement;
  String dateAdded;
  String lateUpdated;
  String planType;
  String description;
  String coverImage;

  Data({
    this.uid,
    this.name,
    this.gymId,
    this.gymName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.leaseAgreement,
    this.electricityBill,
    this.bankStatement,
    this.dateAdded,
    this.lateUpdated,
    this.planType,
    this.description,
    this.coverImage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    gymId = json['gym_id'];
    address1 = json['address1'];
    address2 = json['address2'];
    gymName = json['gym_name'] ?? '';
    city = json['city'];
    state = json['state'];
    country = json['country'];
    leaseAgreement = json['lease_agreement'];
    electricityBill = json['electricity_bill'];
    bankStatement = json['bank_statement'];
    dateAdded = json['date_added'];
    lateUpdated = json['late_updated'];
    planType = json['plan_type'];
    description = json['description'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['gym_id'] = this.gymId;
    data['gym_name'] = this.gymName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['lease_agreement'] = this.leaseAgreement;
    data['electricity_bill'] = this.electricityBill;
    data['bank_statement'] = this.bankStatement;
    data['date_added'] = this.dateAdded;
    data['late_updated'] = this.lateUpdated;
    data['plan_type'] = this.planType;
    data['description'] = this.description;
    return data;
  }
}
