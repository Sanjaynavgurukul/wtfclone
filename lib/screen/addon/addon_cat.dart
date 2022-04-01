import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';

class AddonsCat extends StatefulWidget {
  static const String routeName = '/addonsCat';
  const AddonsCat({Key key}) : super(key: key);

  @override
  _AddonsCatState createState() => _AddonsCatState();
}

class _AddonsCatState extends State<AddonsCat> with TickerProviderStateMixin{

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
