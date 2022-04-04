import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/model/gym_cat_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/DiscoverScreen.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';

import 'arguments/gym_cat_argument.dart';

class GymCategoryScreen extends StatefulWidget {
  static const String routeName = '/gymCategoryScreen';

  const GymCategoryScreen({Key key}) : super(key: key);

  @override
  _GymCategoryScreenState createState() => _GymCategoryScreenState();
}

class _GymCategoryScreenState extends State<GymCategoryScreen> {
  GymStore user;
  bool callMethod = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  void callData({@required String catId}) {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        user.getCatNearByGymsList(cat_id: 'kD9djr2OjIxHI');
      }
    });
  }

  void onRefreshPage({@required String catId}) {
    user.selectedGymTypes = null;
    this.callMethod = true;
    callData(catId: catId);
  }

  @override
  Widget build(BuildContext context) {
    final GymCatArgument args =
    ModalRoute.of(context).settings.arguments as GymCatArgument;
    if(args.gymCatModel.uid == null ||args.gymCatModel.uid.isEmpty){
      return Scaffold(body: Center(child: Text('Something went wrong!!'),),);
    }else{

      //Calling data
      callData(catId:args.gymCatModel.uid);

      return Consumer<GymStore>(builder: (context, user, snapshot) {
        if (user.selectedGymTypes == null || user.selectedGymTypes.data == null) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }else{
          //This is data
          GymTypes gym = user.selectedGymTypes;
          GymCatModel cat = args.gymCatModel;
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              onRefreshPage(catId: args.gymCatModel.uid);
            },
            child: Container(
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
                                        errorBuilder: (context, error, stackTrace) {
                                          return Center(child: Text("Failed",));
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
                                        fit: BoxFit.fitHeight,
                                        height: 400,
                                      ),
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
                                if(cat.image != null || cat.image.isNotEmpty)
                                  Image.network(
                                    cat.image,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(child: Text("Failed",));
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
                                    fit: BoxFit.fitHeight,
                                    height: 100,
                                  ),
                                // Image.asset(
                                //   'assets/images/luxe.png',
                                //   height: 100,
                                // ),
                                if(cat.category_name != null || cat.category_name.isNotEmpty)Text(cat.category_name,
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
                                        'STARTING AT ${cat.price_start ?? 99}',
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
                    gym.data.isEmpty?Text('No Gyms Found'):
                    Container(
                      child: ListView.builder(
                        itemCount: gym.data.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GymCard(item: gym.data[index],recommended_list: true,cat_logo: cat.image,);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
        }
      });
    }
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
