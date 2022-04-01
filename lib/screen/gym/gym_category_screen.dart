import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';

class GymCategoryScreen extends StatefulWidget {
  static const String routeName = '/gymCategoryScreen';

  const GymCategoryScreen({Key key}) : super(key: key);

  @override
  _GymCategoryScreenState createState() => _GymCategoryScreenState();
}

class _GymCategoryScreenState extends State<GymCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                child: Stack(
                  children: [
                    Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 400,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          pageSnapping: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                        ),
                        items: [1, 2, 3, 4, 5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                child: Image.network(
                                    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                    loadingBuilder: (context, _, chunk) =>
                                        chunk == null
                                            ? _
                                            : RectangleShimmering(
                                                width: double.infinity,
                                                height: 180.0,
                                              )),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    //Bottom Gradient :d
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xff0d0d0d)],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            'assets/images/luxe.png',
                            height: 100,
                          ),
                          Text('WTF LUXURY GYM',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 22)),
                          SizedBox(height: 12),
                          Wrap(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                      radius: 4.0,
                                      colors: [
                                        Color(0xffc59e00),
                                        AppColors.BACK_GROUND_BG
                                      ]),
                                ),
                                child: Text(
                                  'STARTING AT 99',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Perks',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22)),
              SizedBox(
                height: 12,
              ),
              Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 0.0,
                  spacing: 12.0,
                  children: [
                    perkItem('Free Diet\nPlan'),
                    perkItem('Locker'),
                    perkItem('Live Class'),
                    perkItem('Personal\nTraining'),
                    perkItem('Shower'),
                  ]),
              SizedBox(
                height: 20,
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                title: Text('Explore'),
                trailing: TextButton.icon(
                    onPressed: () {
                      _showModalSheet().then((value){
                        if(value != null){
                          print('Filter action distance value --- ${value.distance}');
                          print('Filter action price value --- ${value.lowToHigh}');
                        }
                      });
                    },
                    icon: Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Sort',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                child: ListView.builder(
                  itemCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return exploreItem();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget perkItem(
    String label,
  ) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.map),
          SizedBox(
            height: 6,
          ),
          Text(
            label ?? 'Free Diet Plan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget exploreItem() {
    return Container(
      width: 200,
      margin: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 120.0,
                  initialPage: 0,
                  viewportFraction: 0.9,
                  reverse: false,
                  enableInfiniteScroll: false),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 12),
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: Wrap(
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.all(6),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.only(
                      //               topRight: Radius.circular(8)),
                      //           color: Colors.white.withOpacity(0.7)),
                      //       child: Text(
                      //         '2.8KM',
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(right: 12, left: 12),
            child: ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.all(0),
              subtitle: Text('Noida Sector 8',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.withOpacity(0.8))),
              dense: true,
              title: Text('WTF Supernatural Cross fitness Advance',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
              trailing: Container(
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff490000),
                        Color(0xffBA1406),
                      ],
                    )),
                child: Text("Book Now"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<FilterModel> _showModalSheet() {
    double value = 1.0;
    int _groupValue = 0;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter state) {
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                unselectedWidgetColor: Colors.grey,
                textTheme: TextTheme(
                  bodyText1: TextStyle(),
                  bodyText2: TextStyle(),
                ).apply(
                  bodyColor: AppConstants.bgColor,
                  displayColor: AppConstants.bgColor,
                ),
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
              ),
              child: Material(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text('Sort'.toUpperCase(),
                            style: TextStyle(color: AppConstants.black,fontWeight: FontWeight.w300)),
                        subtitle: Text('Give Some Description',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 16, right: 16),
                          title: Text('Distance',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          trailing: Text('in km',
                              style: TextStyle(color: Colors.black)),
                          tileColor: Colors.grey.withOpacity(0.1)),
                      SfSlider(
                        min: 1.0,
                        max: 10.0,
                        interval: 1,
                        showLabels: true,
                        showTicks: true,
                        stepSize: 1,
                        activeColor: AppConstants.bgColor,
                        value: value,
                        onChanged: (dynamic newValue) {
                          state(() {
                            value = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 16, right: 16),
                        title: Text('Price Filter',
                            style: TextStyle(color: Colors.black,fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        tileColor: Colors.grey.withOpacity(0.1),
                      ),
                      RadioListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 16, right: 16),
                        value: 0,
                        controlAffinity: ListTileControlAffinity.trailing,
                        groupValue: _groupValue,
                        title: Text("Price Low To High",
                            style: TextStyle(color: Colors.black)),
                        onChanged: (newValue) =>
                            state(() => _groupValue = newValue),
                        activeColor: AppConstants.bgColor,
                      ),
                      RadioListTile(
                        value: 1,
                        contentPadding: EdgeInsets.only(left: 16, right: 16),
                        dense: true,
                        groupValue: _groupValue,
                        title: Text("Price High To Low",
                            style: TextStyle(color: Colors.black)),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (newValue) =>
                            state(() => _groupValue = newValue),
                        activeColor: AppConstants.bgColor,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap:(){
                            Navigator.pop(context,FilterModel(distance: value.toInt(),lowToHigh: _groupValue == 0?true:false));
                          },
                          child: Container(
                            constraints:
                                BoxConstraints(minWidth: 80, maxWidth: 200),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: AppConstants.bgColor),
                            child: Text('Submit',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class FilterModel{
  int distance;
  bool lowToHigh;
  //Default Constructor :D
  FilterModel({@required this.distance,@required this.lowToHigh});
}

class GymCategoryScreens extends StatefulWidget {
  static const String routeName = '/gymCategoryScreen';

  const GymCategoryScreens({Key key}) : super(key: key);

  @override
  _GymCategoryScreenStates createState() => _GymCategoryScreenStates();
}

class _GymCategoryScreenStates extends State<GymCategoryScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        backgroundColor: AppColors.BACK_GROUND_BG,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(height: 400.0, viewportFraction: 1),
                items: [1, 2, 3].map((i) {
                  ExploreCardColor color =
                      ExploreCardColor.getColorList()[i - 1];
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 12, left: 16, right: 16, bottom: 16),
                          decoration: BoxDecoration(
                              color: Color(0xff0D0D0D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.topRight,
                                colors: [
                                  color.leftColor ?? Colors.transparent,
                                  color.rightColor ?? Color(0xff164741),
                                ],
                              ),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              Container(
                                child: Image.asset(
                                    color.image ?? 'assets/images/pro.png',
                                    height: 100),
                                // child: SvgPicture.asset(
                                //     color.image??'assets/images/pro.png',
                                //     semanticsLabel: 'lite Gym'
                                // ),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.all(0),
                                title: Text(color.label ?? 'NO NAME',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal)),
                              ),
                              Container(
                                height: 36,
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xff292929).withOpacity(0.5),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff2e2e2e).withOpacity(0.75),
                                        Color(0xffc4c4c4).withOpacity(0.75),
                                      ],
                                    )),
                                child: Text('( Starting at 99 )'),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('Some Feature',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text('Some Feature Two',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text('Some Feature Three',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text('Some Feature Four',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 141,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    color: Color(0xff292929),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5))),
                                child: Text('Know more',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.normal)),
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ));
                    },
                  );
                }).toList(),
              ),
              ListTile(
                  title: Text('Categories'),
                  subtitle: Text('Choose your gym of your budget',
                      style: TextStyle(fontWeight: FontWeight.w200))),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cat(label: 'WTF ELITE', image: 'assets/images/elite.png'),
                    cat(label: 'WTF LUXURY', image: 'assets/images/luxe.png'),
                    cat(label: 'WTF PRO', image: 'assets/images/pro.png'),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              ListTile(
                title: Text('Recommended'),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: getRecommended(),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getRecommended() => [
        recommendedItem(index: 0),
        recommendedItem(index: 1),
        recommendedItem(index: 2)
      ];

  Widget recommendedItem({int index = 0}) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg"),
                    fit: BoxFit.cover)),
            child: Align(
              alignment: Alignment.topRight,
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(8))),
                    child: Image.asset(
                      ExploreCardColor.getColorList()[index].image,
                      height: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('WTF Crossfit Advance', style: TextStyle(fontSize: 14)),
            subtitle: Text(
              'Noida Sector 8,C Block',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget cat({@required String image, @required String label}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            width: 94,
            height: 94,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Image.asset(image ?? 'assets/images/pro.png'),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            label ?? 'Non Label',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
          )
        ],
      ),
    );
  }
}

class ExploreCardColor {
  Color leftColor;
  Color rightColor;
  String image;
  String label;

  ExploreCardColor(
      {@required this.leftColor,
      @required this.rightColor,
      @required this.image,
      @required this.label});

  static List<ExploreCardColor> getColorList() => [
        ExploreCardColor(
            leftColor: Colors.transparent,
            rightColor: Color(0xff900079).withOpacity(0.5),
            image: 'assets/images/elite.png',
            label: 'WTF ELITE GYM'),
        ExploreCardColor(
            leftColor: Color(0xff473F16),
            rightColor: Colors.transparent,
            image: 'assets/images/luxe.png',
            label: 'WTF LUXURY GYM'),
        ExploreCardColor(
            leftColor: Colors.transparent,
            rightColor: Color(0xff164741),
            image: 'assets/images/pro.png',
            label: 'WTF PRO GYM'),
      ];
}

class GymCategoryScreenss extends StatefulWidget {
  static const String routeName = '/gymCategoryScreen';

  const GymCategoryScreenss({Key key}) : super(key: key);

  @override
  _GymCategoryScreenStatess createState() => _GymCategoryScreenStatess();
}

class _GymCategoryScreenStatess extends State<GymCategoryScreenss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your slot'),
        backgroundColor: AppColors.BACK_GROUND_BG,
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 12, right: 12),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: double.infinity,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff262626),
                              Color(0xff151515),
                            ],
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('07:00 - 8:00 AM'),
                          SizedBox(
                            height: 16,
                          ),
                          ListView.builder(
                              itemCount: 2,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  alignment: Alignment.topRight,
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: ListTile(
                                      leading: Container(
                                        width: 54,
                                        height: 54,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      ),
                                      title: Wrap(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey)),
                                            child: Text('Some trainer name'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // child: Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  // Container(
                                  //   width:54,
                                  //   height:54,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.grey,
                                  //     borderRadius: BorderRadius.all(Radius.circular(100))
                                  //   ),
                                  // ),
                                  //     // SizedBox(width:12),
                                  //     ListTile(
                                  //       title: Text('hi'),
                                  //     ),
                                  //     Container(
                                  //       padding: EdgeInsets.all(12),
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.transparent,
                                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                                  //         border: Border.all(width: 1,color: Colors.grey)
                                  //       ),child: Text('Some trainer name here Some trainer name here Some trainer name here'),
                                  //     )
                                  //   ],
                                  // ),
                                );
                              }),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
