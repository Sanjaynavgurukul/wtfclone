import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/gym/arguments/gym_detail_argument.dart';
import 'package:wtf/screen/gym/membership_page.dart';
import 'package:wtf/widget/ComingSoonWidget.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/gym_list_search_adapter.dart';
import 'package:wtf/widget/progress_loader.dart';

class DiscoverScreen extends StatefulWidget {
  static const String routeName = '/discoverScreen';
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GymStore user;
  bool callMethod = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  void callData({String type = 'gym'}) {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        user.getDiscoverNow(context: context, type: type);
      }
    });
  }

  void onRefreshPage({String type = 'gym'}) {
    user.selectedGymTypes = null;
    this.callMethod = true;
    print('check lat and lngss --- onrefresh --  ${locator<AppPrefs>().lat.getValue()} -- ${locator<AppPrefs>().lng.getValue()}');
    user.getDiscoverNow(context: context, type: type);
  }

  @override
  Widget build(BuildContext context) {
    //Calling data
    callData(type: 'gym');

    return Consumer<GymStore>(builder: (context, user, snapshot) {
      if (user.selectedGymTypes == null || user.selectedGymTypes.data == null) {
        return Center(
          child: Loading(),
        );
      } else {
        //This is data
        GymTypes gym = user.selectedGymTypes;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              ' Discover WTF ${user.discoverType == 'gym' ? 'Arena' : 'Fitness Studios'}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.BACK_GROUND_BG,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 54),
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: (){
                            FocusScope.of(context).unfocus();
                            //user.determinePosition(context);
                            showSearch(
                                context: context,
                                delegate: GymListSearchAdapter(
                                    searchableList:
                                    user.selectedGymTypes.data,onClick: (GymModelData data){
                                  // print('this is clicked from search ----- ${data.gymName}');
                                  // context.read<GymStore>().getGymByID(
                                  //   context: context,
                                  //   gymId: data.userId,
                                  // );
                                  print('gym iD --- from nav ${data.userId}');
                                  NavigationService.pushName(Routes.buyMemberShipPage,argument: GymDetailArgument(gym: data, gymId: data.userId));
                                  // Navigator.of(context).push(
                                  //   CupertinoPageRoute(
                                  //     builder: (_) => BuyMemberShipPage(
                                  //       gymId: data.userId,
                                  //     ),
                                  //   ),
                                  // );
                                }));
                          },
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: 0.0,
                                bottom: 0.0,
                                left: 17,
                              ),
                              hintText: 'Search your favourite WTF gyms',
                              hintStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 13.0,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  // user.determinePosition();
                                  // NavigationService.navigateTo(
                                  //     Routes.searchScreen);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5.0),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xffBA1406),
                                          Color(0xff490000),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xff2d2d2d),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpace(12.0),
                    Flexible(
                      child: InkWell(
                        onTap: () async {
                          LocationResult result =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                Helper.googleMapKey,
                                displayLocation:
                                    LatLng(user.getLat(), user.getLng()),
                              ),
                            ),
                          );
                          print(result);
                          setState(() {
                            print('Checking selected new location ----');
                            if (result != null) {
                              print('User has choose new location -----');
                              locator<AppPrefs>().lat.setValue(result.latLng.latitude.toString());
                              locator<AppPrefs>().lng.setValue(result.latLng.longitude.toString());
                              print('check lat and lngss --- onchange --  ${locator<AppPrefs>().lat.getValue()} -- ${locator<AppPrefs>().lng.getValue()}');
                              onRefreshPage(type: 'gym');
                            } else {
                              print('Same as previous location ----');
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/svg/change.svg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              onRefreshPage(type: 'gym');
            },
            child: ListView.builder(
              itemCount: gym.data.length,
              padding:
                  EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 40),
              itemBuilder: (context, index) {
                return GymCard(item: gym.data[index]);
              },
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    user.setGymTypes(data: null);
    super.dispose();
  }
}

class GymCard extends StatelessWidget {
  GymCard(
      {Key key,
      @required this.item,
      this.recommended_list = false,
      this.clicable = true,
      this.cat_logo = ''})
      : super(key: key);

  final GymModelData item;
  bool recommended_list;
  String cat_logo;
  bool clicable;

  bool isRecommended(String value) {
    return value != null;
  }

  String convertToMonth(String value) {
    return (int.parse(value) / 30).round().toString();
  }

  bool showOffer(GymModelData item){
    if(item.offer != null){
      print('is front 1');
      return true;
    }else{
      print('is front 0');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clicable ? () {
          // context.read<GymStore>().getGymByID(
          //       context: context,
          //       gymId: item.userId,
          //     );
          print('gym iD --- from nav ${item.userId} ${item.longitude}---${item.latitude}');
          NavigationService.pushName(Routes.buyMemberShipPage,argument: GymDetailArgument(gym: item, gymId: item.userId));

          // Navigator.of(context).push(
          //   CupertinoPageRoute(
          //     builder: (_) => BuyMemberShipPage(
          //       gymId: item.userId,
          //     ),
          //   ),
          // );
      }:null,
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
            color: Color(0xff272727),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.only(right: 15),
              child: Stack(
                children: [
                  GradientImageWidget(
                    //TODO Gym Cover image missing
                    network: item.cover_image ??
                        'https://media.istockphoto.com/photos/gym-background-fitness-weight-equipment-on-empty-dark-floor-picture-id1213615970?k=20&m=1213615970&s=612x612&w=0&h=S2Ny5JNrAlcpZ_0mt76CKAwARqvJN5glvHpB9fD3DA0=',
                    gragientColor: [Colors.transparent, Color(0xff272727)],
                  ),
                  // Padding(
                  //   padding:
                  //   const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  //   child: Align(
                  //     alignment: Alignment.bottomLeft,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       children: [
                  //         Flexible(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             children: [
                  //               Text(
                  //                 item.type?.capitalize() ?? '',
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 12.5,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 5,
                  //               ),
                  //               Text(
                  //                 item.gymName ?? '',
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 5,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Flexible(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               Flexible(
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.end,
                  //                   crossAxisAlignment:
                  //                   CrossAxisAlignment.center,
                  //                   children: [
                  //                     Icon(
                  //                       Icons.access_time,
                  //                       color: Colors.white,
                  //                       size: 16,
                  //                     ),
                  //                     SizedBox(
                  //                       width: 4,
                  //                     ),
                  //                     Text(
                  //                       '9 am-11 am',
                  //                       style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 12.5,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5.0,
                  // ),
                  // if (item.rating != 0)
                  //   Positioned(
                  //     top: 12.0,
                  //     right: 12.0,
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 4.0,
                  //         horizontal: 6.0,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: item.rating <= 2
                  //             ? Colors.red
                  //             : item.rating > 2 && item.rating <= 3
                  //             ? Colors.orange
                  //             : Colors.green,
                  //         borderRadius: BorderRadius.circular(6.0),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Text(
                  //             item.rating.toString() + ' ',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 14.0,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //           Icon(
                  //             Icons.star,
                  //             color: Colors.white,
                  //             size: 14.0,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  if ((item.text1 ?? '').isNotEmpty ||
                      (item.text2 ?? '').isNotEmpty)
                    Container(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 12, right: 12, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8))),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: <Widget>[
                            // Row(
                            //   children: [
                            //     Text('Live Class ',
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.w400,color: Colors.black)),
                            //     Container(
                            //       width: 12,height: 12,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.all(Radius.circular(100)),
                            //           border: Border.all(color: Color(0xffBA1406),width: 3)
                            //       ),
                            //     )
                            //   ],
                            // ),
                            if ((item.text1 ?? '').isNotEmpty)
                              Text('${item.text1}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            if ((item.text2 ?? '').isNotEmpty)
                              Text('${item.text2}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                  showOffer(item)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xffBF6D6D),
                              borderRadius:BorderRadius.only(bottomLeft: Radius.circular(4),bottomRight: Radius.circular(4))
                            ),
                            child: Text(item.offer.value != null ?'${item.offer.value}${item.offer.type.toLowerCase() == 'percentage'?'% OFF':'\u{20B9} OFF'}':'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (recommended_list)
                            Container(
                              margin: EdgeInsets.only(bottom: 6),
                              child: Image.network(
                                cat_logo,
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox();
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                                fit: BoxFit.fitHeight,
                                height: 50,
                              ),
                            ),
                          Text(item.gymName ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal)),
                          SizedBox(height: 4,),
                          Text(item.address1 + ' ' + item.address2,style: TextStyle(fontSize: 14,color: Colors.grey.shade300),),
                        ],
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (item.rating != null && item.rating > 0)
                            IgnorePointer(
                              ignoring: true,
                              child: RatingBar(
                                  initialRating: (item.rating ?? 0).toDouble(),
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 16,
                                  ratingWidget: RatingWidget(
                                    full: Icon(
                                      Icons.star,
                                      color: AppConstants.boxBorderColor,
                                    ),
                                    half: Icon(
                                      Icons.star_half,
                                      color: AppConstants.boxBorderColor,
                                    ),
                                    empty: Icon(
                                      Icons.star_border,
                                      color: AppConstants.white,
                                    ),
                                  ),
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  }),
                            ),
                          if (item.rating == null || item.rating <= 0)
                            RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: <WidgetSpan>[
                                  WidgetSpan(
                                      child: Text('Newly Opened',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400))),
                                ],
                              ),
                            ),
                          item.distance.contains('N/A')
                              ? SizedBox(
                                  height: 0,
                                )
                              : RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <WidgetSpan>[
                                      WidgetSpan(
                                          child: Icon(
                                        Icons.directions_car,
                                        size: 16,
                                        color: AppConstants.green,
                                      )),
                                      WidgetSpan(
                                          child: Text(
                                              ' ${item.duration_text ?? ''} away | ${item.distance_text ?? ''}',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 12, right: 12),
              title: isRecommended(item.plan_price)
                  ? Text(
                      '\u{20B9}${item.plan_price} for ${convertToMonth(item.plan_duration)} months',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Color(0XFFE2B411)))
                  : null,
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
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}