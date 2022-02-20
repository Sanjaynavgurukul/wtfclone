import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/model/diet_model.dart';


class DietItem extends StatelessWidget {
  const DietItem({Key key, this.data}) : super(key: key);
  final DietModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            //replace this Container with your Card
            padding: EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 16),
            margin: EdgeInsets.only(top: 80/2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.grey.withOpacity(
                0.5,
              ),
            ),
            child: Column(
              children: [
                Text(data.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  height: 14,
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                        color: AppConstants.bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children: [
                        Text('Customize'),
                        SizedBox(width: 4,),
                        Icon(
                          Icons.lock_rounded,
                          color: Colors.white,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.white),
            child: CircleAvatar(
              radius: 18,
              child: ClipOval(
                child: Image.network(
                  'https://cdn.loveandlemons.com/wp-content/uploads/2021/04/green-salad.jpg',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
