import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/custom_expansion_tile.dart';
import 'package:wtf/widget/progress_loader.dart';

class UpcomingEventsWidget extends StatefulWidget {
  const UpcomingEventsWidget({Key key,this.onClick}) : super(key: key);
  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
  final Function onClick;
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  GymStore store;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    var newD = LayoutBuilder(
      builder: (context, constraints) => Consumer<GymStore>(
        builder: (context, store, child) => store.upcomingEvents != null
            ? store.upcomingEvents.data.isNotEmpty
                ? Container(
          height: 200.0,
          width: double.infinity,
          child: ListView.builder(
              itemCount: store.upcomingEvents.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = store.upcomingEvents.data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: InkWell(
                    onTap: () {
                      store.getEventById(
                        context: context,
                        eventId: item.eventId,
                      );
                      NavigationService.navigateTo(
                          Routes.eventDetails);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      child: Container(
                        width:
                        MediaQuery.of(context).size.width *
                            0.75,
                        // height: 80.0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          // color: AppColors.TEXT_DARK
                          //     .withOpacity(0.1),
                          color:Colors.grey,
                          borderRadius:
                          BorderRadius.circular(12.0),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 15.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: AppConstants
                                            .primaryColor,
                                        borderRadius:
                                        BorderRadius.only(
                                          topRight:
                                          Radius.circular(
                                              8.0),
                                          bottomRight:
                                          Radius.circular(
                                              8.0),
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(
                                        6.0),
                                    // Text(
                                    //   'Upcoming',
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontWeight:
                                    //         FontWeight.bold,
                                    //     fontSize: 16.0,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                UIHelper.verticalSpace(16.0),
                                Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    item.startDate.isAfter(
                                        DateTime.now())
                                        ? 'Join on ${Helper.stringForDatetime2(
                                      item.startDate
                                          .toIso8601String(),
                                    )} , ${item.startTime ?? '9 am'}'
                                        : 'Before ${Helper.stringForDatetime(
                                      item.expireDate
                                          .toIso8601String(),
                                    )}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(10.0),
                                Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize:
                                    MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 50.0,
                                        height: 50.0,
                                        child:
                                        item.eventImage !=
                                            null
                                            ? Image.network(
                                          item.eventImage,
                                          fit: BoxFit
                                              .cover,
                                        )
                                            : Container(),
                                      ),
                                      UIHelper.horizontalSpace(
                                          12.0),
                                      Flexible(
                                        child: IntrinsicHeight(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  item.eventName,
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize:
                                                    12.0,
                                                  ),
                                                ),
                                              ),
                                              UIHelper
                                                  .verticalSpace(
                                                  4.0),
                                              Flexible(
                                                child: Text(
                                                  item.gymName,
                                                  maxLines: 2,
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    fontSize:
                                                    12.0,
                                                  ),
                                                ),
                                              ),
                                              UIHelper
                                                  .verticalSpace(
                                                  4.0),
                                              Expanded(
                                                // flex: 1,
                                                child: Text(
                                                  '${item.gymAddress1}, ${item.gymAddress2}',
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  softWrap:
                                                  true,
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    fontSize:
                                                    10.0,
                                                  ),
                                                ),
                                              ),
                                              UIHelper
                                                  .verticalSpace(
                                                  8.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // if (item.coupon != null)
                                //   Align(
                                //     alignment:
                                //         Alignment.centerRight,
                                //     child: Container(
                                //       padding: const EdgeInsets
                                //           .symmetric(
                                //         horizontal: 10.0,
                                //         vertical: 6.0,
                                //       ),
                                //       margin:
                                //           const EdgeInsets.only(
                                //         left: 80.0,
                                //       ),
                                //       width: double.infinity,
                                //       color: Colors.white
                                //           .withOpacity(0.1),
                                //       child: Text(
                                //         'CODE  |  ${item.coupon}                                   ',
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight:
                                //               FontWeight.w500,
                                //           fontSize: 12.0,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                            // if (!item.startDate.isAfter(DateTime.now()))
                            Positioned(
                              right: 0.0,
                              left: 0.0,
                              bottom: 00.0,
                              child: Center(
                                child: IgnorePointer(
                                  child: InkWell(
                                    onTap: () async {
                                      await store.eventCheckIn(
                                          context: context,
                                          eventId:
                                          item.eventId);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets
                                          .symmetric(
                                        vertical: 8.0,
                                        horizontal: 12.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppConstants
                                            .primaryColor,
                                      ),
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                          color: AppConstants
                                              .white,
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
                : Container()
            : Loading(),
      ),
    );
    return newD;
  }
}
