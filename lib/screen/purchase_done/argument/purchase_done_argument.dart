import 'package:flutter/material.dart';
import 'package:wtf/screen/purchase_done/BookingSuccess.dart';

class PurchaseDoneArgument{
  PurchaseDoneType purchaseDoneType;
  //default Constructor :D
  PurchaseDoneArgument({this.purchaseDoneType = PurchaseDoneType.PURCHASE_DONE_REGULAR});
}