import 'package:flutter/foundation.dart';
import 'package:wtf/screen/subscriptions/payment_process.dart';

class PaymentProcessArgument{
  final Map<String ,dynamic> data;
  final String price;
  final String orderId;
  final PaymentType paymentType;
  PaymentProcessArgument({@required this.data,@required this.price,@required this.orderId,this.paymentType = PaymentType.PAYMENT_REGULAR});
}