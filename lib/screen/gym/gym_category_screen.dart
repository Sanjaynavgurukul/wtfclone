import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';

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
                  ExploreCardColor color = ExploreCardColor.getColorList()[i-1];
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
                                  color.leftColor??Colors.transparent,
                                  color.rightColor??Color(0xff164741
                                  ),
                                ],
                              ),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Column(
                            children: [
                              SizedBox(height: 18,),
                              Container(
                                child: Image.asset(color.image??'assets/images/pro.png',height: 100),
                                // child: SvgPicture.asset(
                                //     color.image??'assets/images/pro.png',
                                //     semanticsLabel: 'lite Gym'
                                // ),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.all(0),
                                title: Text(color.label??'NO NAME',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal)),
                              ),
                              Container(
                                height:36,
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
                                  )
                                ),
                                child: Text('( Starting at 99 )'),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('Some Feature',style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal)),
                                    SizedBox(height: 4,),
                                    Text('Some Feature Two',style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal)),
                                    SizedBox(height: 4,),
                                    Text('Some Feature Three',style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal)),
                                    SizedBox(height: 4,),
                                    Text('Some Feature Four',style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreCardColor{
  Color leftColor;
  Color rightColor;
  String image;
  String label;
  ExploreCardColor({@required this.leftColor,@required this.rightColor,@required this.image,@required this.label});

  static List<ExploreCardColor> getColorList()=>[
    ExploreCardColor(leftColor: Colors.transparent,rightColor: Color(0xff900079).withOpacity(0.5),image: 'assets/images/elite.png',label: 'WTF ELITE GYM'),
    ExploreCardColor(leftColor: Color(0xff473F16),rightColor: Colors.transparent,image: 'assets/images/luxe.png',label: 'WTF LUXURY GYM'),
    ExploreCardColor(leftColor: Colors.transparent,rightColor: Color(0xff164741),image: 'assets/images/pro.png',label: 'WTF PRO GYM'),
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

class GymCategoryScreens extends StatefulWidget {
  static const String routeName = '/gymCategoryScreen';

  const GymCategoryScreens({Key key}) : super(key: key);

  @override
  _GymCategoryScreenStates createState() => _GymCategoryScreenStates();
}

class _GymCategoryScreenStates extends State<GymCategoryScreens>
    with TickerProviderStateMixin {
  TabController _controller;
  List<String> _tabList = ['Crossfit', 'yoga', 'pilates', 'aerobics', 'zumba'];

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        TabController(vsync: this, initialIndex: 0, length: _tabList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
        backgroundColor: AppColors.BACK_GROUND_BG,
        elevation: 0,
        bottom: PreferredSize(
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                controller: _controller,
                indicatorColor: AppConstants.bgColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: _tabList
                    .map((e) => Tab(
                          child: Text('${e.toUpperCase()}'),
                        ))
                    .toList()),
            preferredSize: Size.fromHeight(30.0)),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Nearby CrossFit Classes'),
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                'View all',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return addonItem();
                }),
          )
        ],
      ),
    );
  }

  Widget addonItem() {
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
                      child: Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8)),
                                color: Colors.white.withOpacity(0.7)),
                            child: Text(
                              '2.8KM',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
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

  Widget trainersItem() {
    return Container(
      width: 300,
      child: Stack(
        children: [],
      ),
    );
  }
}

class CircleBlurPainter extends CustomPainter {

  CircleBlurPainter({@required this.circleWidth, this.blurSigma});

  double circleWidth;
  double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.lightBlue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}