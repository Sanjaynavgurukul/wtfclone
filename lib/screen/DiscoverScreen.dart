import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/gym/membership_page.dart';
import 'package:wtf/widget/ComingSoonWidget.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/progress_loader.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GymStore store;

  //
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          ' Discover WTF ${store.discoverType == 'gym' ? 'Arena' : 'Fitness Studios'}',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.BACK_GROUND_BG,
      ),
      body: Column(
        children: [
          //Search Bar :D
          Container(
            color: AppColors.BACK_GROUND_BG,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: SearchBar(),
          ),
          //ListView
          Expanded(
            child: store.selectedGymTypes == null
                ? LoadingWithBackground()
                : store.selectedGymTypes != null &&
                        store.selectedGymTypes.data.isNotEmpty
                    ? ListView.builder(
                        itemCount: store.selectedGymTypes.data.length,
                        padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                        itemBuilder: (context, index) {
                          var item = store.selectedGymTypes.data[index];
                          return GymCard(item: item);
                        },
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Record Found',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget abd() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.0,
            ),
            SearchBar(),
            SizedBox(
              height: 25.0,
            ),
            Expanded(
              child: store.selectedGymTypes == null
                  ? LoadingWithBackground()
                  : store.selectedGymTypes != null &&
                          store.selectedGymTypes.data.isNotEmpty
                      ? ListView.builder(
                          itemCount: store.selectedGymTypes.data.length,
                          itemBuilder: (context, index) {
                            var item = store.selectedGymTypes.data[index];
                            return GymCard(item: item);
                          },
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Text(
                            'No Record Found',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
            ),
            UIHelper.verticalSpace(20.0),
            ComingSoonWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    store.setGymTypes(data: null);
    super.dispose();
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(builder: (context, store, child) {
      return Row(
        children: [
          Expanded(
            flex: 8,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(

                onTap: () {
                  FocusScope.of(context).unfocus();
                  store.determinePosition(context);
                  NavigationService.navigateTo(Routes.searchScreen);
                },
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
                      // store.determinePosition();
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
          UIHelper.horizontalSpace(12.0),
          Flexible(
            child: InkWell(
              onTap: () async {
                LocationResult result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlacePicker(
                      Helper.googleMapKey,
                      displayLocation: store.selectedNewLocation != null
                          ? LatLng(store.selectedNewLocation.latLng.latitude,
                              store.selectedNewLocation.latLng.longitude)
                          : LatLng(store.getLat(),
                              store.getLng()),
                    ),
                  ),
                );
                print(result);
                setState(() {
                  if (result != null) {
                    store.setNewLocation(
                      result: result,
                      context: context,
                    );
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
      );
    });
  }
}

class GymCard extends StatelessWidget {
  const GymCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final GymModelData item;

  bool isRecommended(String value) {
    return value != null;
  }

  String convertToMonth(String value) {
    return (int.parse(value) / 30).round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<GymStore>().getGymByID(
          context: context,
          gymId: item.userId,
        );
        print('gym iD --- from nav ${item.userId}');
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => BuyMemberShipPage(
              gymId: item.userId,
            ),
          ),
        );
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
            color: Color(0xff272727),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            Container(
              height: 176,
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
                            borderRadius:
                                BorderRadius.only(topRight: Radius.circular(8))),
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
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ListTile(
                      title: Text(item.gymName ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontStyle: FontStyle.normal)),
                      subtitle: Text(item.address1 + ' ' + item.address2),
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
                                                  fontWeight: FontWeight.w400))),
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

// Widget abc(BuildContext context) {
//   return InkWell(
//     onTap: () {
//       context.read<GymStore>().getGymDetails(
//             context: context,
//             gymId: item.userId,
//           );
//       Navigator.of(context).push(
//         CupertinoPageRoute(
//           builder: (_) => BuyMemberShipPage(
//             gymId: item.userId,
//           ),
//         ),
//       );
//     },
//     child: Container(
//       margin: EdgeInsets.only(bottom: 37),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: Colors.white70,
//             width: 1,
//           ),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height / 4.5,
//             width: MediaQuery.of(context).size.width,
//             // margin: EdgeInsets.only(right: 15),
//             child: Stack(
//               children: [
//                 GradientImageWidget(
//                   network: item.coverImage,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                   child: Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(
//                                 item.type?.capitalize() ?? '',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12.5,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 item.gymName ?? '',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Flexible(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Flexible(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time,
//                                       color: Colors.white,
//                                       size: 16,
//                                     ),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Text(
//                                       '9 am-11 am',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12.5,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 if (item.rating != 0)
//                   Positioned(
//                     top: 12.0,
//                     right: 12.0,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 4.0,
//                         horizontal: 6.0,
//                       ),
//                       decoration: BoxDecoration(
//                         color: item.rating <= 2
//                             ? Colors.red
//                             : item.rating > 2 && item.rating <= 3
//                                 ? Colors.orange
//                                 : Colors.green,
//                         borderRadius: BorderRadius.circular(6.0),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             item.rating.toString() + ' ',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Colors.white,
//                             size: 14.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 // if (item.status != 'active')
//                 //   Positioned(
//                 //     top: 12.0,
//                 //     left: 12.0,
//                 //     child: Container(
//                 //       padding: const EdgeInsets.symmetric(
//                 //         vertical: 4.0,
//                 //         horizontal: 6.0,
//                 //       ),
//                 //       decoration: BoxDecoration(
//                 //         color: item.rating <= 2
//                 //             ? Colors.red
//                 //             : item.rating > 2 && item.rating <= 3
//                 //                 ? Colors.orange
//                 //                 : Colors.green,
//                 //         borderRadius: BorderRadius.circular(6.0),
//                 //       ),
//                 //       child: Text(
//                 //         'Coming Soon',
//                 //         style: TextStyle(
//                 //           color: Colors.white,
//                 //           fontSize: 14.0,
//                 //           fontWeight: FontWeight.w500,
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Flexible(
//                       child: Text(
//                         '${item.address1}, ${item.address2}',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.5,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
