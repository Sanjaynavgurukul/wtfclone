import 'package:flutter/material.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/widget/image_stack.dart';
import 'dart:math' as math;

class ScheduleMain extends StatefulWidget {
  static const String routeName = '/scheduleMain';

  const ScheduleMain({Key key}) : super(key: key);

  @override
  State<ScheduleMain> createState() => _ScheduleMainState();
}

class _ScheduleMainState extends State<ScheduleMain> {
  double recommendedCircleHeight = 90.00;
  List<String> imagePath = [
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.BACK_GROUND_BG,
        elevation: 0,
        title: Text('My Schedule'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(left: 0, right: 0),
                title: Text('Hello,',
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
                subtitle: Text('Chamman Kumar',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                trailing: ClipOval(
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Text('Error');
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              labelWidget(label: 'Recommended Program'),
              SizedBox(
                height: 18,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 0.0,
                spacing: 12.0,
                // gap between lines
                children: <Widget>[
                  recommendedWidget(label: "Goal Focus", imageUrl: ''),
                  recommendedWidget(label: "Addons", imageUrl: ''),
                  recommendedWidget(label: "Personal Training", imageUrl: ''),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              labelWidget(label: 'Current Trainer'),
              SizedBox(
                height: 18,
              ),
              labelWidget(label: 'Your Subscription'),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    yourSubscriptionWidget(),
                    yourSubscriptionWidget(),
                    yourSubscriptionWidget(),
                    yourSubscriptionWidget(),
                    yourSubscriptionWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget recommendedWidget(
      {@required String label, @required String imageUrl}) {
    return Container(
        alignment: Alignment.center,
        width: recommendedCircleHeight,
        margin: EdgeInsets.only(bottom: 22),
        child: Column(
          children: [
            Container(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      width: recommendedCircleHeight,
                      height: recommendedCircleHeight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.white)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: recommendedCircleHeight - 1.2,
                        height: recommendedCircleHeight - 1.2,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xffE00303),
                                  Color(0xff485AFE)
                                ]))),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$label',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }

  Widget labelWidget({@required String label,}) {
    return Text(
      '$label',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget yourSubscriptionWidget() {
    return InkWell(
      onTap: (){
        NavigationService.pushName(Routes.exercisesScreen);
      },
      child: Container(
        margin: EdgeInsets.only(right: 26),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 11),
              constraints:
                  BoxConstraints(minHeight: 200, minWidth: 140,maxWidth: 140),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12,right: 12,bottom: 12,top: 20),
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.green,border: Border.all(color: Colors.white,width: 1)),
                  ),
                  SizedBox(height: 12,),
                  Padding(
                      padding:EdgeInsets.only(left: 12),child: Text('General Training',style: TextStyle(fontSize: 12),)),
                  SizedBox(height: 12,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.transparent,
                              Colors.white
                            ])
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                        child: Text('F 24 3 MONTH',style: TextStyle(fontSize: 12),)),
                  ),SizedBox(height: 2,),
                  Padding(
                      padding:EdgeInsets.only(left: 12),child: Text('MEMBERSHIP',style: TextStyle(fontSize: 12),)),
                ],
              ),
            ),
            Positioned(
              right: -20,
              top: 20,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: AppColors.BACK_GROUND_BG),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.white),
                  child: Text('View Schedule',
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
