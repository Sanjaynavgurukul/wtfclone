// To parse this JSON data, do
//
//     final offers = offersFromJson(jsonString);

import 'dart:convert';

Offers offersFromJson(String str) => Offers.fromJson(json.decode(str));

String offersToJson(Offers data) => json.encode(data.toJson());

class Offers {
  Offers({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.code,
    this.tags,
    this.startDateTime,
    this.endDateTime,
    this.visibilityDateTime,
    this.status,
    this.data,
    this.merchantName,
    this.version,
    this.restrictedPrograms,
    this.offerCode,
    this.title,
    this.programCode,
    this.internalLink,
    this.externalLink,
    this.imageLink,
    this.mobileImageLink,
    this.logoImageLink,
    this.description,
    this.redemptionProcess,
    this.escalationMatrix,
    this.termAndCondition,
    this.purchaseable,
    this.longDescription,
  });

  String code;
  List<Tag> tags;
  DateTime startDateTime;
  DateTime endDateTime;
  DateTime visibilityDateTime;
  bool status;
  dynamic data;
  dynamic merchantName;
  String version;
  List<dynamic> restrictedPrograms;
  String offerCode;
  String title;
  dynamic programCode;
  dynamic internalLink;
  String externalLink;
  String imageLink;
  dynamic mobileImageLink;
  String logoImageLink;
  String description;
  String redemptionProcess;
  dynamic escalationMatrix;
  String termAndCondition;
  Purchaseable purchaseable;
  String longDescription;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        code: json["code"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        startDateTime: DateTime.parse(json["startDateTime"]),
        endDateTime: DateTime.parse(json["endDateTime"]),
        visibilityDateTime: DateTime.parse(json["visibilityDateTime"]),
        status: json["status"],
        data: json["data"],
        merchantName: json["merchantName"],
        version: json["version"],
        restrictedPrograms:
            List<dynamic>.from(json["restrictedPrograms"].map((x) => x)),
        offerCode: json["offerCode"],
        title: json["title"],
        programCode: json["programCode"],
        internalLink: json["internalLink"],
        externalLink: json["externalLink"],
        imageLink: json["imageLink"],
        mobileImageLink: json["mobileImageLink"],
        logoImageLink: json["logoImageLink"],
        description: json["description"],
        redemptionProcess: json["redemptionProcess"],
        escalationMatrix: json["escalationMatrix"],
        termAndCondition: json["termAndCondition"],
        purchaseable: Purchaseable.fromJson(json["purchaseable"]),
        longDescription: json["longDescription"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "startDateTime": startDateTime.toIso8601String(),
        "endDateTime": endDateTime.toIso8601String(),
        "visibilityDateTime": visibilityDateTime.toIso8601String(),
        "status": status,
        "data": data,
        "merchantName": merchantName,
        "version": version,
        "restrictedPrograms":
            List<dynamic>.from(restrictedPrograms.map((x) => x)),
        "offerCode": offerCode,
        "title": title,
        "programCode": programCode,
        "internalLink": internalLink,
        "externalLink": externalLink,
        "imageLink": imageLink,
        "mobileImageLink": mobileImageLink,
        "logoImageLink": logoImageLink,
        "description": description,
        "redemptionProcess": redemptionProcess,
        "escalationMatrix": escalationMatrix,
        "termAndCondition": termAndCondition,
        "purchaseable": purchaseable.toJson(),
        "longDescription": longDescription,
      };
}

class Purchaseable {
  Purchaseable({
    this.isPurchaseable,
    this.isActivated,
    this.price,
    this.validityPeriod,
    this.validityPeriodType,
    this.isImported,
    this.voucherTemplate,
  });

  bool isPurchaseable;
  bool isActivated;
  int price;
  int validityPeriod;
  int validityPeriodType;
  bool isImported;
  dynamic voucherTemplate;

  factory Purchaseable.fromJson(Map<String, dynamic> json) => Purchaseable(
        isPurchaseable: json["isPurchaseable"],
        isActivated: json["isActivated"],
        price: json["price"],
        validityPeriod: json["validityPeriod"],
        validityPeriodType: json["validityPeriodType"],
        isImported: json["isImported"],
        voucherTemplate: json["voucherTemplate"],
      );

  Map<String, dynamic> toJson() => {
        "isPurchaseable": isPurchaseable,
        "isActivated": isActivated,
        "price": price,
        "validityPeriod": validityPeriod,
        "validityPeriodType": validityPeriodType,
        "isImported": isImported,
        "voucherTemplate": voucherTemplate,
      };
}

class Tag {
  Tag({
    this.tagKey,
    this.values,
  });

  String tagKey;
  List<Value> values;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        tagKey: json["TagKey"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TagKey": tagKey,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class Value {
  Value({
    this.name,
    this.color,
  });

  String name;
  String color;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        name: json["Name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "color": color,
      };
}
