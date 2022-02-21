import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/model/diet_model.dart';
import 'package:wtf/screen/change_diet/widget/day_wise_list_item.dart';

import 'arguments/diet_arguments.dart';

class DietDetails extends StatefulWidget {
  const DietDetails({Key key}) : super(key: key);
  static const String routeName = '/dietDetails';

  @override
  _DietDetailsState createState() => _DietDetailsState();
}

class _DietDetailsState extends State<DietDetails> {
  DayWise data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DietArgument args =
        ModalRoute.of(context).settings.arguments as DietArgument;
    if (args.data != null)
      data = args.data;
    else
      data = new DayWise();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          NavigationService.pushName(Routes.choosePlanScreen);
        },
        label: Text('Buy This'),
        icon: Icon(Icons.lock),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: [
          Container(
            padding: getPadding(),
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Image(image: AssetImage('assets/images/egg.png')),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 0),
            child: Text(data.dayLabel ?? "EMPTY",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 36,
                    fontWeight: FontWeight.w700)),
          ),

          ListView.builder(
              itemCount: data.meal.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                MealSlot d = data.meal[index];
                bool blur = index == 0 || index == 1;
                return DayWiseListItem(
                  blur: !blur,
                  data: d,
                );
              })
        ],
      ),
    );
  }

  Widget ab() {
    return ListView(
      children: [
        Container(
          padding: getPadding(),
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Image(image: AssetImage('assets/images/egg.png')),
        ),
        Padding(
          padding: getPadding(),
          child: Text('DayWise' ?? "EMPTY",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 36,
                  fontWeight: FontWeight.w700)),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
            padding: getPadding(),
            alignment: Alignment.topLeft,
            child: Text('Description',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: Colors.white))),
        Padding(
          padding: getPadding(),
          child: Text("data.description" ?? 'Nothing',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  color: Colors.white)),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(),
              child: Text('Ingredients',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.white)),
            ),
            Container(
              width: double.infinity,
              color: AppConstants.primaryColor,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('You are using free diet plan',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          color: Colors.white)),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      NavigationService.pushName(Routes.choosePlanScreen,
                          argument: DietArgument(data: data));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 250, maxHeight: 56),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: AppConstants.bgColor),
                      child: Text('Buy this',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  EdgeInsets getPadding() {
    return EdgeInsets.only(left: 12, right: 12, bottom: 18);
  }
}
