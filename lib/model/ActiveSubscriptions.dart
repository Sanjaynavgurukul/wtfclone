import 'dart:convert';

import 'package:wtf/model/MemberSubscriptions.dart';

ActiveSubscriptions activeSubscriptionsFromJson(String str) =>
    ActiveSubscriptions.fromJson(json.decode(str));

String activeSubscriptionsToJson(ActiveSubscriptions data) =>
    json.encode(data.toJson());

class ActiveSubscriptions {
  ActiveSubscriptions({
    this.status,
    this.data,
  });

  bool status;
  SubscriptionData data;

  factory ActiveSubscriptions.fromJson(Map<String, dynamic> json) =>
      ActiveSubscriptions(
        status: json["status"],
        data: json.containsKey('data') && json['data'] != null
            ? SubscriptionData.fromJson(json["data"][0])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data != null ? data.toJson() : null,
      };
}
