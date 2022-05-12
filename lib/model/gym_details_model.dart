// To parse this JSON data, do
//
//     final gymDetailsModel = gymDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'WorkoutDetailModel.dart';
import 'gym_model.dart';

GymDetailsModel gymDetailsModelFromJson(String str) =>
    GymDetailsModel.fromJson(json.decode(str));

String gymDetailsModelToJson(GymDetailsModel data) =>
    json.encode(data.toJson());

class GymDetailsModel {
  GymDetailsModel({
    this.status,
    this.data,
    // this.equipment,
    // this.addon,
    // this.offer,
    // this.plan,
    this.message,
  });

  bool status;
  GymModelData data;

  // List<Gallery> gallery;
  // List<Equipment> equipment;
  // List<Benfit> benefits;
  // List<Addon> addon;
  // List<dynamic> offer;
  // List<Plan> plan;
  String message;

  factory GymDetailsModel.fromJson(Map<String, dynamic> json) {
    print('json in model--- $json');
    return GymDetailsModel(
      status: json["status"],
      data: json["status"] ? GymModelData.fromJson(json["data"]):null,

      // addon: List<Addon>.from(json["addon"].map((x) => Addon.fromJson(x))),
      // offer: List<dynamic>.from(json["offer"].map((x) => x)),
      // plan: List<Plan>.from(json["plan"].map((x) => Plan.fromJson(x))),
      message: json.containsKey('message') ? json['message'] : '',
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        // "equipment": List<dynamic>.from(equipment.map((x) => x.toJson())),
        // "addon": List<dynamic>.from(addon.map((x) => x.toJson())),
        // "offer": List<dynamic>.from(offer.map((x) => x)),
        // "plan": List<dynamic>.from(plan.map((x) => x.toJson())),
      };
}

class Addon {
  Addon({
    this.uid,
    this.name,
    this.gymId,
    this.description,
    this.image,
    this.price,
    this.status,
    this.slots,
  });

  String uid;
  String name;
  String gymId;
  String description;
  String image;
  String price;
  String status;
  List<Slot> slots;

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        uid: json["uid"],
        name: json["name"],
        gymId: json["gym_id"],
        description: json["description"],
        image: json["image"] == null ? null : json["image"],
        price: json["price"],
        status: json["status"],
        slots: json["slots"] == null
            ? null
            : List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "gym_id": gymId,
        "description": description,
        "image": image == null ? null : image,
        "price": price,
        "status": status,
        "slots": slots == null
            ? null
            : List<dynamic>.from(slots.map((x) => x.toJson())),
      };
}

class Slot {
  Slot({
    this.uid,
    this.gymId,
    this.trainerId,
    this.startTime,
    this.endTime,
    this.slot,
    this.status,
  });

  String uid;
  String gymId;
  String trainerId;
  String startTime;
  String endTime;
  String slot;
  String status;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        uid: json["uid"],
        gymId: json["gym_id"],
        trainerId: json["trainer_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        slot: json["slot"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "gym_id": gymId,
        "trainer_id": trainerId,
        "start_time": startTime,
        "end_time": endTime,
        "slot": slot,
        "status": status,
      };
}

class Benfit {
  Benfit({
    this.uid,
    this.name,
    this.gymId,
    this.breif,
    this.image,
    this.status,
  });

  String uid;
  String name;
  String gymId;
  String breif;
  String image;
  String status;

  factory Benfit.fromJson(Map<String, dynamic> json) => Benfit(
        uid: json["uid"],
        name: json["name"],
        gymId: json["gym_id"],
        breif: json["breif"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "gym_id": gymId,
        "breif": breif,
        "image": image == null ? null : image,
        "status": status,
      };
}

class Equipment {
  Equipment({
    this.uid,
    this.gymId,
    this.equipment,
    this.quantity,
    this.brand,
    this.status,
  });

  String uid;
  String gymId;
  String equipment;
  String quantity;
  String brand;
  String status;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        uid: json["uid"],
        gymId: json["gym_id"],
        equipment: json["equipment"],
        quantity: json["quantity"],
        brand: json["brand"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "gym_id": gymId,
        "equipment": equipment,
        "quantity": quantity,
        "brand": brand,
        "status": status,
      };
}

class Gallery {
  Gallery(
      {this.uid,
      this.images,
      this.type,
      this.status,
      this.category_id,
      this.date_added,
      this.gym_id,
      this.last_updated});

  String uid;
  String gym_id;
  String category_id;
  String images;
  String status;
  String date_added;
  String last_updated;
  String type;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        uid: json["uid"],
        gym_id: json["gym_id"],
        category_id: json["category_id"],
        status: json["status"],
        date_added: json["date_added"],
        last_updated: json["last_updated"],
        type: json["type"],
        images: json["images"] == null ? null : json["images"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "images": images == null ? null : images,
        "gym_id": gym_id,
        "category_id": category_id,
        "status": status,
        "date_added": date_added,
        "last_updated": last_updated,
        "type": type,
      };
}

class Plan {
  Plan({
    this.uid,
    this.planName,
    this.gymId,
    this.planType,
    this.planPrice,
    this.taxPercentage,
  });

  String uid;
  String planName;
  String gymId;
  String planType;
  String planPrice;
  String taxPercentage;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        uid: json["uid"],
        planName: json["plan_name"],
        gymId: json["gym_id"],
        planType: json["plan_type"],
        planPrice: json["plan_price"],
        taxPercentage: json["tax_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "plan_name": planName,
        "gym_id": gymId,
        "plan_type": planType,
        "plan_price": planPrice,
        "tax_percentage": taxPercentage,
      };
}
