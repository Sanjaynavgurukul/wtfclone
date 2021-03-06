import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/MemberSubscriptions.dart';
import 'package:wtf/widget/progress_loader.dart';

class MyTransaction extends StatefulWidget {
  @override
  _MyTransactionState createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  GymStore store;
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();

    List<SubscriptionData> getFilterList(List<SubscriptionData> data,
        {String status}){
      if(data != null && data.isNotEmpty){
        return data.where((element) => element.trxStatus ==status ).toList();
      }else {
        return [];
      }
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          brightness: Brightness.dark,
          title: Text(
            'My Transactions',
            style: AppConstants.customStyle(
              color: Colors.white,
              size: 16.0,
            ),
          ),
          bottom: TabBar(tabs: [
            Tab(
              text: 'Completed',
            ),
            Tab(
              text: 'Failed',
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (store.memberSubscriptions != null)
                      if (store.memberSubscriptions.data != null &&
                          store.memberSubscriptions.data.isNotEmpty)
                        ...store.memberSubscriptions.data
                            // .where((element) =>
                            //     element.trxStatus.toLowerCase() == 'done')
                            // .toList()
                            .map(
                              (e) => e != null
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 18.0,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      'Transaction Done for:  \n',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    fontSize: 12.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: e.type == 'addon' ||
                                                              e.type ==
                                                                  'addon_pt'
                                                          ? e.addonName
                                                          : e.type == 'event'
                                                              ? e.eventName
                                                              : '${e.planName ?? ''} Subscription',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child: RichText(
                                                    textAlign: TextAlign.right,
                                                    text: TextSpan(
                                                      text: 'Type:  \n',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.6),
                                                        fontSize: 12.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: e.type
                                                              .capitalize(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(6.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      'Transaction Amount:  \n',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    fontSize: 12.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Rs.${e.price}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Flexible(
                                                child: RichText(
                                                  textAlign: TextAlign.right,
                                                  text: TextSpan(
                                                    text: 'Status:  \n',
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                      fontSize: 12.0,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: e.trxStatus
                                                            .capitalize(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(6.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Transaction id:  \n',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    fontSize: 12.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: e.trxId,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                textAlign: TextAlign.right,
                                                text: TextSpan(
                                                  text: 'Tax amount:  \n',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    fontSize: 12.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Rs. ${e.taxAmount}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(6.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Tax Percentage:  \n',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    fontSize: 12.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${e.taxPercentage} %',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child: RichText(
                                                    textAlign: TextAlign.right,
                                                    text: TextSpan(
                                                      text: 'Date:  \n',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.6),
                                                        fontSize: 12.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: e.dateAdded !=
                                                                  null
                                                              ? Helper.stringForDatetime2(e
                                                                  .dateAdded
                                                                  .toIso8601String())
                                                              : '',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            )
                            .toList()
                      else
                        Center(
                          child: Text(
                            'No Transaction Found',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        )
                    else
                      Loading()
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: store.memberSubscriptions != null && getFilterData(store.memberSubscriptions.data,'failed') != null?
                    ListView.builder(
                      itemCount: getFilterData(store.memberSubscriptions.data,'failed').length,
                        itemBuilder: (context,index){
                      SubscriptionData e = getFilterData(store.memberSubscriptions.data,'failed')[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                  'Transaction Done for:  \n',
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6),
                                    fontSize: 12.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: e.type == 'addOn'
                                          ? e.addonName
                                          : e.type == 'event'
                                          ? e.eventName
                                          : '${e.planName ?? ''} Subscription',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      right: 4.0),
                                  child: RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      text: 'Type:  \n',
                                      style: TextStyle(
                                        color: Colors.white
                                            .withOpacity(0.6),
                                        fontSize: 12.0,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: e.type
                                              .capitalize(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    overflow:
                                    TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(6.0),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                  'Transaction Amount:  \n',
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6),
                                    fontSize: 12.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Rs.${e.price}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                    text: 'Status:  \n',
                                    style: TextStyle(
                                      color: Colors.white
                                          .withOpacity(0.6),
                                      fontSize: 12.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: e.trxStatus
                                            .capitalize(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(6.0),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Transaction id:  \n',
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6),
                                    fontSize: 12.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: e.trxId,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  text: 'Tax amount:  \n',
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6),
                                    fontSize: 12.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                      'Rs. ${e.taxAmount}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(6.0),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Tax Percentage:  \n',
                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6),
                                    fontSize: 12.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                      '${e.taxPercentage} %',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      right: 4.0),
                                  child: RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      text: 'Date:  \n',
                                      style: TextStyle(
                                        color: Colors.white
                                            .withOpacity(0.6),
                                        fontSize: 12.0,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: e.dateAdded !=
                                              null
                                              ? Helper.stringForDatetime2(e
                                              .dateAdded
                                              .toIso8601String())
                                              : '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    overflow:
                                    TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    })
                    :Center(child: Text('No Transaction available'),),
                // child: Column(
                //   children: [
                //     if (store.memberSubscriptions != null)
                //       if (store.memberSubscriptions.data != null &&
                //           store.memberSubscriptions.data.isNotEmpty)
                //         ...store.memberSubscriptions.data
                //             // .where((element) =>
                //             //     element.trxStatus.toLowerCase() == 'failed')
                //             // .toList()
                //             .map(
                //               (e) => e != null
                //                   ? Container(
                //                       padding: const EdgeInsets.symmetric(
                //                         horizontal: 12.0,
                //                         vertical: 18.0,
                //                       ),
                //                       margin: const EdgeInsets.symmetric(
                //                         vertical: 10.0,
                //                       ),
                //                       decoration: BoxDecoration(
                //                         border: Border.all(
                //                           color: Colors.white,
                //                           width: 1.0,
                //                         ),
                //                         borderRadius:
                //                             BorderRadius.circular(12.0),
                //                       ),
                //                       child: Column(
                //                         children: [
                //                           Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceBetween,
                //                             children: [
                //                               RichText(
                //                                 text: TextSpan(
                //                                   text:
                //                                       'Transaction Done for:  \n',
                //                                   style: TextStyle(
                //                                     color: Colors.white
                //                                         .withOpacity(0.6),
                //                                     fontSize: 12.0,
                //                                   ),
                //                                   children: [
                //                                     TextSpan(
                //                                       text: e.type == 'addOn'
                //                                           ? e.addonName
                //                                           : e.type == 'event'
                //                                               ? e.eventName
                //                                               : '${e.planName ?? ''} Subscription',
                //                                       style: TextStyle(
                //                                         color: Colors.white,
                //                                         fontSize: 15.0,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                                 overflow: TextOverflow.ellipsis,
                //                               ),
                //                               Flexible(
                //                                 child: Padding(
                //                                   padding:
                //                                       const EdgeInsets.only(
                //                                           right: 4.0),
                //                                   child: RichText(
                //                                     textAlign: TextAlign.right,
                //                                     text: TextSpan(
                //                                       text: 'Type:  \n',
                //                                       style: TextStyle(
                //                                         color: Colors.white
                //                                             .withOpacity(0.6),
                //                                         fontSize: 12.0,
                //                                       ),
                //                                       children: [
                //                                         TextSpan(
                //                                           text: e.type
                //                                               .capitalize(),
                //                                           style: TextStyle(
                //                                             color: Colors.white,
                //                                             fontSize: 15.0,
                //                                           ),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     overflow:
                //                                         TextOverflow.ellipsis,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                           UIHelper.verticalSpace(6.0),
                //                           Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceBetween,
                //                             children: [
                //                               RichText(
                //                                 text: TextSpan(
                //                                   text:
                //                                       'Transaction Amount:  \n',
                //                                   style: TextStyle(
                //                                     color: Colors.white
                //                                         .withOpacity(0.6),
                //                                     fontSize: 12.0,
                //                                   ),
                //                                   children: [
                //                                     TextSpan(
                //                                       text: 'Rs.${e.price}',
                //                                       style: TextStyle(
                //                                         color: Colors.white,
                //                                         fontSize: 15.0,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                                 overflow: TextOverflow.ellipsis,
                //                               ),
                //                               Flexible(
                //                                 child: RichText(
                //                                   textAlign: TextAlign.right,
                //                                   text: TextSpan(
                //                                     text: 'Status:  \n',
                //                                     style: TextStyle(
                //                                       color: Colors.white
                //                                           .withOpacity(0.6),
                //                                       fontSize: 12.0,
                //                                     ),
                //                                     children: [
                //                                       TextSpan(
                //                                         text: e.trxStatus
                //                                             .capitalize(),
                //                                         style: TextStyle(
                //                                           color: Colors.white,
                //                                           fontSize: 15.0,
                //                                         ),
                //                                       ),
                //                                     ],
                //                                   ),
                //                                   overflow:
                //                                       TextOverflow.ellipsis,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                           UIHelper.verticalSpace(6.0),
                //                           Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceBetween,
                //                             children: [
                //                               RichText(
                //                                 text: TextSpan(
                //                                   text: 'Transaction id:  \n',
                //                                   style: TextStyle(
                //                                     color: Colors.white
                //                                         .withOpacity(0.6),
                //                                     fontSize: 12.0,
                //                                   ),
                //                                   children: [
                //                                     TextSpan(
                //                                       text: e.trxId,
                //                                       style: TextStyle(
                //                                         color: Colors.white,
                //                                         fontSize: 16.0,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               RichText(
                //                                 textAlign: TextAlign.right,
                //                                 text: TextSpan(
                //                                   text: 'Tax amount:  \n',
                //                                   style: TextStyle(
                //                                     color: Colors.white
                //                                         .withOpacity(0.6),
                //                                     fontSize: 12.0,
                //                                   ),
                //                                   children: [
                //                                     TextSpan(
                //                                       text:
                //                                           'Rs. ${e.taxAmount}',
                //                                       style: TextStyle(
                //                                         color: Colors.white,
                //                                         fontSize: 16.0,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                           UIHelper.verticalSpace(6.0),
                //                           Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceBetween,
                //                             children: [
                //                               RichText(
                //                                 text: TextSpan(
                //                                   text: 'Tax Percentage:  \n',
                //                                   style: TextStyle(
                //                                     color: Colors.white
                //                                         .withOpacity(0.6),
                //                                     fontSize: 12.0,
                //                                   ),
                //                                   children: [
                //                                     TextSpan(
                //                                       text:
                //                                           '${e.taxPercentage} %',
                //                                       style: TextStyle(
                //                                         color: Colors.white,
                //                                         fontSize: 16.0,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               Flexible(
                //                                 child: Padding(
                //                                   padding:
                //                                       const EdgeInsets.only(
                //                                           right: 4.0),
                //                                   child: RichText(
                //                                     textAlign: TextAlign.right,
                //                                     text: TextSpan(
                //                                       text: 'Date:  \n',
                //                                       style: TextStyle(
                //                                         color: Colors.white
                //                                             .withOpacity(0.6),
                //                                         fontSize: 12.0,
                //                                       ),
                //                                       children: [
                //                                         TextSpan(
                //                                           text: e.dateAdded !=
                //                                                   null
                //                                               ? Helper.stringForDatetime2(e
                //                                                   .dateAdded
                //                                                   .toIso8601String())
                //                                               : '',
                //                                           style: TextStyle(
                //                                             color: Colors.white,
                //                                             fontSize: 15.0,
                //                                           ),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     overflow:
                //                                         TextOverflow.ellipsis,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ],
                //                       ),
                //                     )
                //                   : Container(),
                //             )
                //             .toList()
                //       else
                //         Center(
                //           child: Text(
                //             'No Transaction Found',
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 16.0,
                //             ),
                //           ),
                //         )
                //     else
                //       Loading()
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget oldUI(SubscriptionData e){
    return Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text:
                'Transaction Done for:  \n',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.6),
                  fontSize: 12.0,
                ),
                children: [
                  TextSpan(
                    text: e.type == 'addOn'
                        ? e.addonName
                        : e.type == 'event'
                        ? e.eventName
                        : '${e.planName ?? ''} Subscription',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Flexible(
              child: Padding(
                padding:
                const EdgeInsets.only(
                    right: 4.0),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    text: 'Type:  \n',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(0.6),
                      fontSize: 12.0,
                    ),
                    children: [
                      TextSpan(
                        text: e.type
                            .capitalize(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  overflow:
                  TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(6.0),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text:
                'Transaction Amount:  \n',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.6),
                  fontSize: 12.0,
                ),
                children: [
                  TextSpan(
                    text: 'Rs.${e.price}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Flexible(
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: 'Status:  \n',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(0.6),
                    fontSize: 12.0,
                  ),
                  children: [
                    TextSpan(
                      text: e.trxStatus
                          .capitalize(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                overflow:
                TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(6.0),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: 'Transaction id:  \n',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.6),
                  fontSize: 12.0,
                ),
                children: [
                  TextSpan(
                    text: e.trxId,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                text: 'Tax amount:  \n',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.6),
                  fontSize: 12.0,
                ),
                children: [
                  TextSpan(
                    text:
                    'Rs. ${e.taxAmount}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(6.0),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: 'Tax Percentage:  \n',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.6),
                  fontSize: 12.0,
                ),
                children: [
                  TextSpan(
                    text:
                    '${e.taxPercentage} %',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                const EdgeInsets.only(
                    right: 4.0),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    text: 'Date:  \n',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(0.6),
                      fontSize: 12.0,
                    ),
                    children: [
                      TextSpan(
                        text: e.dateAdded !=
                            null
                            ? Helper.stringForDatetime2(e
                            .dateAdded
                            .toIso8601String())
                            : '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  overflow:
                  TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<SubscriptionData> getFilterData(List<SubscriptionData> data,String type){
    if(data != null && data.isNotEmpty){
      List<SubscriptionData> finalData = data.where((element) => element.trxStatus == type).toList();
      if(finalData.isNotEmpty && finalData != null) return finalData;
      else return [];
    }else{
      return [];
    }
  }

}
