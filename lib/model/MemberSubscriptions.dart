// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

class MemberSubscriptions {
  MemberSubscriptions({
    this.status,
    this.data,
  });

  bool status;
  List<SubscriptionData> data;

  factory MemberSubscriptions.fromJson(Map<String, dynamic> json) =>
      MemberSubscriptions(
        status: json["status"],
        data: List<SubscriptionData>.from(
            json["data"].map((x) => SubscriptionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SubscriptionData {
  SubscriptionData({
    this.id,
    this.uid,
    this.gymId,
    this.userId,
    this.price,
    this.trxId,
    this.trxStatus,
    this.taxPercentage,
    this.taxAmount,
    this.orderStatus,
    this.dateAdded,
    this.slotId,
    this.addon,
    this.startDate,
    this.expireDate,
    this.coupon,
    this.planId,
    this.remark,
    this.type,
    this.eventId,
    this.sessionId,
    this.orderId,
    this.receipt,
    this.planName,
    this.planImage,
    this.gymName,
    this.gymAddress1,
    this.gymType,
    this.gymAddress2,
    this.gymCity,
    this.gymState,
    this.gymPin,
    this.gymCountry,
    this.gymCoverImage,
    this.eventName,
    this.eventDate,
    this.addonName,
    this.lat,
    this.lng,
    this.nSession,
    this.completedSession,
    this.isPt,
  });

  int id;
  String uid;
  String gymId;
  String userId;
  var price;
  String trxId;
  String trxStatus = 'failed';
  var taxPercentage;
  var taxAmount;
  String orderStatus;
  DateTime dateAdded;
  String slotId;
  String addon;
  DateTime startDate;
  DateTime expireDate;
  String coupon;
  String planId;
  String remark;
  String type;
  dynamic eventId;
  String sessionId;
  dynamic orderId;
  String receipt;
  String planName;
  String planImage;
  String gymName;
  String gymAddress1;
  String gymType;
  String gymAddress2;
  String gymCity;
  String gymState;
  String gymPin;
  String gymCountry;
  var lat;
  var lng;
  var nSession;
  var completedSession;
  String gymCoverImage;
  dynamic eventName;
  dynamic eventDate;
  String addonName;
  int isPt;

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    SubscriptionData data;
    try {
      data = SubscriptionData(
        id: json["id"],
        uid: json["uid"],
        gymId: json["gym_id"],
        userId: json["user_id"],
        price: json["price"],
        trxId: json["trx_id"],
        trxStatus: json["trx_status"]??'failed',
        taxPercentage: json["tax_percentage"],
        taxAmount: json["tax_amount"],
        orderStatus: json["order_status"],
        dateAdded: DateTime.parse(json["date_added"]),
        slotId: json["slot_id"],
        addon: json["addon"],
        startDate: DateTime.parse(json["start_date"]),
        expireDate: DateTime.parse(json["expire_date"]),
        coupon: json["coupon"] == null ? null : json["coupon"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        remark: json["remark"] == null ? null : json["remark"],
        type: json["type"],
        eventId: json["event_id"],
        sessionId: json["session_id"] == null ? null : json["session_id"],
        orderId: json["order_id"],
        receipt: json["receipt"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        planImage: json["plan_image"] == null ? null : json["plan_image"],
        gymName: json["gym_name"],
        gymAddress1: json["gym_address1"],
        gymType: json["gym_type"],
        gymAddress2: json["gym_address2"],
        gymCity: json["gym_city"],
        gymState: json["gym_state"],
        gymPin: json["gym_pin"],
        gymCountry: json["gym_country"],
        gymCoverImage: json["gym_cover_image"],
        eventName: json["event_name"],
        eventDate: json["event_date"],
        addonName: json["addon_name"] == null ? null : json["addon_name"],
        lng: json['gym_long'],
        lat: json['gym_lat'],
        completedSession: json['completed_session'],
        nSession: json['n_session'],
      );
    } catch (e) {
      print('error: $e');
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "gym_id": gymId,
        "user_id": userId,
        "price": price,
        "trx_id": trxId,
        "trx_status": trxStatus,
        "tax_percentage": taxPercentage,
        "tax_amount": taxAmount,
        "order_status": orderStatus,
        "date_added": dateAdded.toIso8601String(),
        "slot_id": slotId,
        "addon": addon,
        "start_date": startDate.toIso8601String(),
        "expire_date": expireDate.toIso8601String(),
        "coupon": coupon == null ? null : coupon,
        "plan_id": planId == null ? null : planId,
        "remark": remark == null ? null : remark,
        "type": type,
        "event_id": eventId,
        "session_id": sessionId == null ? null : sessionId,
        "order_id": orderId,
        "receipt": receipt,
        "plan_name": planName == null ? null : planName,
        "plan_image": planImage == null ? null : planImage,
        "gym_name": gymName,
        "gym_address1": gymAddress1,
        "gym_type": gymType,
        "gym_address2": gymAddress2,
        "gym_city": gymCity,
        "gym_state": gymState,
        "gym_pin": gymPin,
        "gym_country": gymCountry,
        "gym_cover_image": gymCoverImage,
        "event_name": eventName,
        "event_date": eventDate,
        "addon_name": addonName == null ? null : addonName,
      };
}
