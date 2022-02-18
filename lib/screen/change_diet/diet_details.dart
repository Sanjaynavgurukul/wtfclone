import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

class DietDetails extends StatefulWidget {
  const DietDetails({Key key}) : super(key: key);

  @override
  _DietDetailsState createState() => _DietDetailsState();
}

class _DietDetailsState extends State<DietDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      body: Column(
        children: [
          Expanded(flex: 3,child: Container(),),
          Expanded(flex: 1,child: Stack(
            children: [

              Container(
                color: AppConstants.primaryColor,

              )
            ],
          ),),
        ],
      ),
    );
  }
}
