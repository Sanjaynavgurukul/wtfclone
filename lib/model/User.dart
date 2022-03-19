import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.status,
    this.data,
  });

  bool status;
  UserData data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class UserData {
  UserData({
    this.uid,
    this.profile,
    this.registerBy,
    this.name,
    this.mobile,
    this.email,
    this.accountType,
    this.dateAdded,
    this.lastUpdated,
    this.lastLogin,
    this.lastIp,
    this.status,
  });

  String uid;
  dynamic profile;
  String registerBy;
  String name;
  String mobile;
  String email;
  String accountType;
  String dateAdded;
  String lastUpdated;
  String lastLogin;
  String lastIp;
  String status;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["uid"],
        profile: json["profile"],
        registerBy: json["register_by"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        accountType: json["account_type"],
        dateAdded: json["date_added"].toString(),
        lastUpdated: json["last_updated"],
        lastLogin: json["last_login"],
        lastIp: json["last_ip"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "profile": profile,
        "register_by": registerBy,
        "name": name,
        "mobile": mobile,
        "email": email,
        "account_type": accountType,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "last_login": lastLogin,
        "last_ip": lastIp,
        "status": status,
      };
}
