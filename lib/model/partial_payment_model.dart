class PartialPaymentModel{
  //Default Constructor D:
  PartialPaymentModel({this.status,this.data});

  bool status;
  List<PartialPaymentData> data;

  factory PartialPaymentModel.fromJson(Map<String, dynamic> json) =>
      PartialPaymentModel(
        status: json["status"],
        data: json.containsKey('data')
            ? List<PartialPaymentData>.from(
            json["data"].map((x) => PartialPaymentData.fromJson(x)))
            : [],
      );
}

class PartialPaymentData {
  //Default Constructor :d
  PartialPaymentData(
      {this.uid,
      this.email,
      this.status,
      this.name,
      this.date,
      this.date_added,
      this.amount,
      this.mobile,
      this.order_id,
      this.payment_id,
      this.subscription_id,
      this.user_id});

  String uid;
  String subscription_id;
  String user_id;
  String amount; //Convert in to String
  String date; //Convert into String
  String status;
  String date_added;
  String order_id; //Can be null
  String payment_id; //Can be null
  String name; //can be null
  String mobile;
  String email; //Can be null

  factory PartialPaymentData.fromJson(Map<String, dynamic> json) => PartialPaymentData(
        uid: json["uid"],
        subscription_id: json["subscription_id"],
        user_id: json["user_id"],
        amount: json["amount"] == null ? '' : json["amount"].toString(),
        date: json["date"] == null ? '' : json["date"].toString(),
        status: json["status"] == null ? '' : json["status"].toString(),
        date_added:
            json["date_added"] == null ? '' : json["date_added"].toString(),
        order_id: json["order_id"] == null ? '' : json["order_id"].toString(),
        payment_id:
            json["payment_id"] == null ? '' : json["payment_id"].toString(),
        name: json["name"] == null ? '' : json["name"].toString(),
        mobile: json["mobile"].toString(),
        email: json["email"] == null ? '' : json["email"].toString(),
      );

}
