// To parse this JSON data, do
//
//     final coinBalance = coinBalanceFromJson(jsonString);

import 'dart:convert';

CoinBalance coinBalanceFromJson(String str) =>
    CoinBalance.fromJson(json.decode(str));

String coinBalanceToJson(CoinBalance data) => json.encode(data.toJson());

class CoinBalance {
  CoinBalance({
    this.status,
    this.data,
  });

  bool status;
  List<Data> data;

  factory CoinBalance.fromJson(Map<String, dynamic> json) => CoinBalance(
        status: json["status"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.wtfCoins,
  });

  int wtfCoins;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wtfCoins: json["wtf_coins"],
      );

  Map<String, dynamic> toJson() => {
        "wtf_coins": wtfCoins,
      };
}
