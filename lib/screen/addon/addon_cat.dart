import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/model/gym_model.dart';

class AddonsCat extends StatefulWidget {
  static const String routeName = '/addonsCat';

  const AddonsCat({Key key}) : super(key: key);

  @override
  _AddonsCatState createState() => _AddonsCatState();
}

class _AddonsCatState extends State<AddonsCat> with TickerProviderStateMixin {
  TabController _controller;
  bool callMethod = true, callgymsMethod = true, refreshed = false;
  GymStore user;
  int initialTabSelected = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void callData() {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        user.getAddonsCat();
      }
    });
  }

  void calGymList(String cat_id) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callgymsMethod) {
        this.callgymsMethod = false;
        user.getNearestCatGym(cat_id: cat_id);
      }
    });
  }

  void setTabBarController(int length) {
    _controller = TabController(
        vsync: this, initialIndex: initialTabSelected, length: length);
  }

  void onRefreshPage() {
    user.nearestAddonsCatGymList = null;
    this.callMethod = true;
    this.callgymsMethod = true;
    callData();
  }

  @override
  Widget build(BuildContext context) {
    callData();
    return Consumer<GymStore>(builder: (context, user, snapshot) {
      if (user.addonsCatList == null || user.addonsCatList.isEmpty) {
        return Center(
          child: CupertinoActivityIndicator(),
        );
      } else {
        setTabBarController(user.addonsCatList.length);
        calGymList(user.addonsCatList[_controller.index].uid);
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
                      onTap: (index) {
                        initialTabSelected = index;
                        callgymsMethod = true;
                        calGymList(user.addonsCatList[_controller.index].uid);
                        log('check initial tab selected value --- $initialTabSelected');
                      },
                      tabs: user.addonsCatList
                          .map((e) => Tab(
                                child: Text('${e.name.toUpperCase() ?? ''}'),
                              ))
                          .toList()),
                  preferredSize: Size.fromHeight(30.0)),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                onRefreshPage();
              },
              child: user.addonsCatList.isEmpty
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Column(
                      children: [
                        ListTile(
                          title: Text(
                              'Nearby ${user.addonsCatList[_controller.index].name ?? 'No Name'} Classes'),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text(
                              'View all',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        user.nearestAddonsCatGymList != null &&
                                user.nearestAddonsCatGymList.data != null
                            ? Expanded(
                                child:
                                    user.nearestAddonsCatGymList.data.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: user
                                                .nearestAddonsCatGymList
                                                .data
                                                .length,
                                            itemBuilder: (context, index) {
                                              GymModelData data = user
                                                  .nearestAddonsCatGymList
                                                  .data[index];
                                              return addonItem(data: data);
                                            })
                                        : Center(child: Text('No Data Found')),
                              )
                            : Center(
                                child: CupertinoActivityIndicator(),
                              )
                      ],
                    ),
            ));
      }
    });
  }

  Widget sliderItem({@required GymModelData data, String imageUrl}) {
    return Container(
      alignment: Alignment.topRight,
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: NetworkImage(
            'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Wrap(
        children: [
          if (!data.distance.contains('N/A'))
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                  color: Colors.white.withOpacity(0.7)),
              child: Text(
                '${data.distance_text.toUpperCase() ?? ''}' ?? '',
                style: TextStyle(color: Colors.black),
              ),
            )
        ],
      ),
    );
  }

  Widget addonItem({@required GymModelData data}) {
    print('check adon id --- ${data.addons.name}');
    return Container(
      width: 200,
      margin: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.0,
            child: data.gallery == null || data.gallery.isEmpty
                ? data.cover_image != null && data.cover_image.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child:
                            sliderItem(data: data, imageUrl: data.cover_image))
                    : Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: sliderItem(data: data, imageUrl: null))
                : CarouselSlider(
                    options: CarouselOptions(
                        height: 120.0,
                        initialPage: 0,
                        viewportFraction: 0.9,
                        reverse: false,
                        enableInfiniteScroll: false),
                    items: data.gallery.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              margin: EdgeInsets.only(
                                  right: data.gallery.length == 1 ? 0 : 12),
                              child:
                                  sliderItem(imageUrl: i.images, data: data));
                        },
                      );
                    }).toList(),
                  ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(right: 12, left: 12),
            child: ListTile(
              onTap: () {
                showAsBottomSheet();
              },
              contentPadding: EdgeInsets.all(0),
              subtitle: Text(data.address1 + ' ' + data.address2,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.withOpacity(0.8))),
              dense: true,
              title: Text(data.gymName ?? '',
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

  @override
  void dispose() {
    // TODO: implement dispose
    user.nearestAddonsCatGymList = null;
    user.addonsCatList = null;
    super.dispose();
  }

  void showAsBottomSheet() async {
    DateTime _dateTime;
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        color: Colors.white,
        cornerRadiusOnFullscreen: 0.0,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [1, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (context, state) {
            return Material(
            color: Colors.white,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 6),
                title:Padding(
                  padding: EdgeInsets.only(bottom: 6),
                    child: Text('Select Your Slot',style:TextStyle(color: Colors.black))),
              subtitle: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                   // _selectedValue = date;
                  });
                },
              ),
            ),
          );
        },
        footerBuilder: (context, state) {

          return Material(
            child: Container(
              height: 56,
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(top: 4,bottom: 4),
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(maxWidth: 150,minWidth: 100),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.all(Radius.circular(6)),
                  color: AppConstants.bgColor
                ),
                child: Text('Submit',textAlign: TextAlign.center,),
              ),
            ),
          );
        },
        builder: (context, state) {
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
            child: Container(
              height: 800,
              color: Colors.white,
              child: Material(
                child: InkWell(
                  onTap: () => Navigator.pop(context, 'This is the result.'),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Text(
                            'This is the content of the sheet',
                          );
                        }),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });

    print(result); // This is the result.
  }
}
