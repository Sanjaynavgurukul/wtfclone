import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
        title:Text('Choose your slot'),
        backgroundColor: AppColors.BACK_GROUND_BG,
      ),
      body: Container(
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 12,right: 12),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(12)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff262626),
                              Color(0xff151515),
                            ],
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('07:00 - 8:00 AM'),
                          SizedBox(height: 16,),
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
                                      leading:Container(
                                        width:54,
                                        height:54,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(Radius.circular(100))
                                        ),
                                      ),
                                      title: Wrap(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                                border: Border.all(width: 1,color: Colors.grey)
                                            ),child: Text('Some trainer name'),
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
                  viewportFraction:0.9,
                  reverse: false,

                  enableInfiniteScroll: false),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {

                    return  Container(
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
                                borderRadius:
                                BorderRadius.only(topRight: Radius.circular(8)),
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
          SizedBox(height:16),
          Container(
            margin: EdgeInsets.only(right: 12,left: 12),
            child: ListTile(
              onTap: (){

              },
              contentPadding: EdgeInsets.all(0),
              subtitle: Text('Noida Sector 8',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Colors.grey.withOpacity(0.8))),
              dense: true,
              title: Text('WTF Supernatural Cross fitness Advance',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
              trailing: Container(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
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
