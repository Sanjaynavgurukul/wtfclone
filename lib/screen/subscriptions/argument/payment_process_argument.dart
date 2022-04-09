import 'package:flutter/foundation.dart';

class PaymentProcessArgument{
  final Map<String ,dynamic> data;
  final String price;
  PaymentProcessArgument({@required this.data,@required this.price});
}