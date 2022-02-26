import 'package:flutter/material.dart';

enum DbResponse{
  RESPONSE_FAILED,
  RESPONSE_SUCCESS
}

class ResponseHelper{
  Map<String,dynamic> finalData;
  DbResponse dbResponse;

  //Default Constructor :D
  ResponseHelper({@required this.finalData,@required this.dbResponse});
}