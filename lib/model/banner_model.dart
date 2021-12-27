// To parse this JSON data, do
//
//     final bannerData = bannerDataFromJson(jsonString);

import 'dart:convert';

BannerItemData bannerDataFromJson(String str) =>
    BannerItemData.fromJson(json.decode(str));

String bannerDataToJson(BannerItemData data) => json.encode(data.toJson());

class BannerItemData {
  BannerItemData({
    this.status,
    this.data,
  });

  bool status;
  List<BannerItem> data;

  BannerItemData copyWith({
    bool status,
    List<BannerItem> data,
  }) =>
      BannerItemData(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory BannerItemData.fromJson(Map<String, dynamic> json) {
    List<BannerItem> wtfBanner = [];
    List<BannerItem> fcBanner = [];
    List<BannerItem> newItems = [];
    if (json.containsKey('data') && json['data'].length > 0) {
      for (int i = 0; i < json['data'].length; i++) {
        if (json['data'][i]['type'] == 'FC_banner') {
          fcBanner.add(BannerItem.fromJson(json['data'][i]));
        } else {
          wtfBanner.add(BannerItem.fromJson(json['data'][i]));
        }
      }
    }
    newItems.addAll(fcBanner);
    newItems.addAll(wtfBanner);
    return BannerItemData(
      status: json["status"] == null ? null : json["status"],
      data: json["data"] == null ? null : newItems,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BannerItem {
  BannerItem({
    this.uid,
    this.location,
    this.image,
    this.dateAdded,
    this.lastUpdated,
    this.status,
    this.type,
  });

  String uid;
  String location;
  String image;
  String dateAdded;
  String lastUpdated;
  String status;
  String type;

  BannerItem copyWith({
    String uid,
    String location,
    String image,
    String dateAdded,
    String lastUpdated,
    String status,
  }) =>
      BannerItem(
        uid: uid ?? this.uid,
        location: location ?? this.location,
        image: image ?? this.image,
        dateAdded: dateAdded ?? this.dateAdded,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        status: status ?? this.status,
      );

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        uid: json["uid"] == null ? null : json["uid"],
        location: json["location"] == null ? null : json["location"],
        image: json["image"] == null ? null : json["image"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
        status: json["status"] == null ? null : json["status"],
        type: json['type'] ?? 'WTF_banner',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "location": location == null ? null : location,
        "image": image == null ? null : image,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated == null ? null : lastUpdated,
        "status": status == null ? null : status,
        "type": type,
      };
}
