// To parse this JSON data, do
//
//     final verifyPayment = verifyPaymentFromJson(jsonString);

import 'dart:convert';

VerifyPayment verifyPaymentFromJson(String str) =>
    VerifyPayment.fromJson(json.decode(str));

String verifyPaymentToJson(VerifyPayment data) => json.encode(data.toJson());

class VerifyPayment {
  VerifyPayment({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  VerifiedData data;

  factory VerifyPayment.fromJson(Map<String, dynamic> json) => VerifyPayment(
        status: json["status"],
        message: json["message"],
        data: json.containsKey('data')
            ? VerifiedData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class VerifiedData {
  VerifiedData({
    this.id,
    this.entity,
    this.amount,
    this.currency,
    this.status,
    this.orderId,
    this.invoiceId,
    this.international,
    this.method,
    this.amountRefunded,
    this.refundStatus,
    this.captured,
    this.description,
    this.cardId,
    this.bank,
    this.wallet,
    this.vpa,
    this.email,
    this.contact,
    this.notes,
    this.fee,
    this.tax,
    this.errorCode,
    this.errorDescription,
    this.errorSource,
    this.errorStep,
    this.errorReason,
    this.acquirerData,
    this.createdAt,
  });

  String id;
  String entity;
  int amount;
  String currency;
  String status;
  String orderId;
  dynamic invoiceId;
  bool international;
  String method;
  int amountRefunded;
  dynamic refundStatus;
  bool captured;
  String description;
  dynamic cardId;
  String bank;
  dynamic wallet;
  dynamic vpa;
  String email;
  String contact;
  List<dynamic> notes;
  int fee;
  int tax;
  dynamic errorCode;
  dynamic errorDescription;
  dynamic errorSource;
  dynamic errorStep;
  dynamic errorReason;
  AcquirerData acquirerData;
  int createdAt;

  factory VerifiedData.fromJson(Map<String, dynamic> json) => VerifiedData(
        id: json["id"],
        entity: json["entity"],
        amount: json["amount"],
        currency: json["currency"],
        status: json["status"],
        orderId: json["order_id"],
        invoiceId: json["invoice_id"],
        international: json["international"],
        method: json["method"],
        amountRefunded: json["amount_refunded"],
        refundStatus: json["refund_status"],
        captured: json["captured"],
        description: json["description"],
        cardId: json["card_id"],
        bank: json["bank"],
        wallet: json["wallet"],
        vpa: json["vpa"],
        email: json["email"],
        contact: json["contact"],
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        fee: json["fee"],
        tax: json["tax"],
        errorCode: json["error_code"],
        errorDescription: json["error_description"],
        errorSource: json["error_source"],
        errorStep: json["error_step"],
        errorReason: json["error_reason"],
        acquirerData: AcquirerData.fromJson(json["acquirer_data"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "amount": amount,
        "currency": currency,
        "status": status,
        "order_id": orderId,
        "invoice_id": invoiceId,
        "international": international,
        "method": method,
        "amount_refunded": amountRefunded,
        "refund_status": refundStatus,
        "captured": captured,
        "description": description,
        "card_id": cardId,
        "bank": bank,
        "wallet": wallet,
        "vpa": vpa,
        "email": email,
        "contact": contact,
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "fee": fee,
        "tax": tax,
        "error_code": errorCode,
        "error_description": errorDescription,
        "error_source": errorSource,
        "error_step": errorStep,
        "error_reason": errorReason,
        "acquirer_data": acquirerData.toJson(),
        "created_at": createdAt,
      };
}

class AcquirerData {
  AcquirerData({
    this.bankTransactionId,
  });

  String bankTransactionId;

  factory AcquirerData.fromJson(Map<String, dynamic> json) => AcquirerData(
        bankTransactionId: json["bank_transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "bank_transaction_id": bankTransactionId,
      };
}
