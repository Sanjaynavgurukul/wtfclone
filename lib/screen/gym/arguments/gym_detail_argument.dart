import 'package:flutter/material.dart';
import 'package:wtf/model/gym_model.dart';

class GymDetailArgument{
  final GymModelData gym;
  final String gymId;
  final bool fromDynamicLink;
  GymDetailArgument({@required this.gym,@required this.gymId,this.fromDynamicLink = false});
}