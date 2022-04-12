import 'package:flutter/foundation.dart';

class PaymentProcessArgument{
  final Map<String ,dynamic> data;
  final String price;
  final String orderId;
  PaymentProcessArgument({@required this.data,@required this.price,@required this.orderId});
}