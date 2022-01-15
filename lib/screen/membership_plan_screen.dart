// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wtf/controller/explore_controller_presenter.dart';
// import 'package:wtf/controller/gym_store.dart';
// import 'package:wtf/helper/colors.dart';
// import 'package:wtf/helper/common_function.dart';
// import 'package:wtf/helper/ui_helpers.dart';
// import 'package:wtf/model/common_model.dart';
// import 'package:wtf/model/gym_details_model.dart';
// import 'package:wtf/model/gym_model.dart';
// import 'package:wtf/model/gym_plan_model.dart';
// import 'package:wtf/model/gym_search_model.dart';
// import 'package:wtf/model/gym_slot_model.dart';
// import 'package:wtf/widget/gradient_image_widget.dart';
// import 'package:wtf/widget/progress_loader.dart';
//
// import 'buy_subscription_screen.dart';
//
// class MembershipPlanScreen extends StatefulWidget {
//   @override
//   _MembershipPlanScreenState createState() => _MembershipPlanScreenState();
// }
//
// class _MembershipPlanScreenState extends State<MembershipPlanScreen>
//     implements ExploreContract {
//   ScrollController _controller = ScrollController();
//   ExplorePresenter _presenter;
//   GymPlanModel _gymPlanModel;
//   bool isLoaded = false;
//   GymStore store;
//
//   @override
//   void initState() {
//     super.initState();
//     _presenter = new ExplorePresenter(this);
//     getGymPlan("");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     store = context.read<GymStore>();
//     return Scaffold(
//       backgroundColor: AppColors.PRIMARY_COLOR,
//       appBar: PreferredSize(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               'WTF',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             UIHelper.verticalSpace(4.0),
//             Text(
//               store.selectedGymDetail.data.gymName,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             UIHelper.verticalSpace(16.0),
//             // SizedBox(
//             //   height: 5,
//             // ),
//             Text(
//               'Membership Options',
//               style: TextStyle(
//                 color: Colors.red,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         preferredSize: Size(
//           double.infinity,
//           100.0,
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           getGymPlan('');
//         },
//         backgroundColor: Colors.white,
//         child: CustomScrollView(
//           shrinkWrap: true,
//           slivers: [
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return !isLoaded
//                       ? LoadingWithBackground()
//                       : Padding(
//                           padding: const EdgeInsets.only(
//                             top: 16.0,
//                           ),
//                           child: Wrap(
//                             children: _gymPlanModel.data
//                                 .map((e) => InkWell(
//                                       onTap: () {
//                                         print('duration: ${e.duration}');
//                                         context
//                                             .read<GymStore>()
//                                             .selectedStartingDate = null;
//                                         // int days = e.planName ==
//                                         //         'Half yearly'
//                                         //     ? 6 * 30 + 3
//                                         //     : e.planName == 'Yearly'
//                                         //         ? 365
//                                         //         : 30;
//                                         setState(() {
//                                           context
//                                               .read<GymStore>()
//                                               .selectedGymPlan = e;
//                                         });
//                                         Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 BuySubscriptionScreen(),
//                                           ),
//                                         );
//                                         // NavigationService.navigateTo(
//                                         //     Routes.buySubscriptionScreen);
//                                       },
//                                       child: Container(
//                                         height: 250.0,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         margin: EdgeInsets.only(
//                                           bottom: 10.0,
//                                           left: 18.0,
//                                           right: 18.0,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8.0),
//                                         ),
//                                         child: Stack(
//                                           children: [
//                                             GradientImageWidget(
//                                               borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(11),
//                                                 topRight: Radius.circular(11),
//                                               ),
//                                               gragientColor: [
//                                                 Colors.transparent,
//                                                 AppColors.PRIMARY_COLOR,
//                                                 AppColors.PRIMARY_COLOR,
//                                                 // AppColors.PRIMARY_COLOR,
//                                               ],
//                                               stops: [0.0, 0.81, 1.0],
//                                               network: e.image,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                 bottom: 0,
//                                                 left: 10,
//                                                 right: 10,
//                                               ),
//                                               child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     Text(
//                                                       e.planName,
//                                                       // 'For 1 month',
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 24.0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 12,
//                                                     ),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Text(
//                                                           '\u20B9 ${e.planPrice}',
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () {
//                                                             print(
//                                                                 'duration: ${e.duration}');
//                                                             context
//                                                                 .read<
//                                                                     GymStore>()
//                                                                 .selectedStartingDate = null;
//                                                             // int days = e.planName ==
//                                                             //         'Half yearly'
//                                                             //     ? 6 * 30 + 3
//                                                             //     : e.planName == 'Yearly'
//                                                             //         ? 365
//                                                             //         : 30;
//                                                             setState(() {
//                                                               context
//                                                                   .read<
//                                                                       GymStore>()
//                                                                   .selectedGymPlan = e;
//                                                             });
//                                                             Navigator.of(
//                                                                     context)
//                                                                 .push(
//                                                               MaterialPageRoute(
//                                                                 builder:
//                                                                     (context) =>
//                                                                         BuySubscriptionScreen(),
//                                                               ),
//                                                             );
//                                                             // NavigationService.navigateTo(
//                                                             //     Routes.buySubscriptionScreen);
//                                                           },
//                                                           child: Container(
//                                                             padding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         6,
//                                                                     vertical:
//                                                                         6),
//                                                             decoration: BoxDecoration(
//                                                                 color:
//                                                                     Colors.red,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             8)),
//                                                             child: Row(
//                                                               mainAxisSize:
//                                                                   MainAxisSize
//                                                                       .min,
//                                                               // crossAxisAlignment: CrossAxisAlignment.center,
//                                                               children: [
//                                                                 Text(
//                                                                   'Buy now'
//                                                                       .toUpperCase(),
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         15,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 5.0,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ))
//                                 .toList(),
//                           ),
//                         );
//                 },
//                 childCount: 1,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 10.0,
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Note: The above prices are exclusive of GST',
//                   style: TextStyle(
//                     fontSize: 12.0,
//                     color: AppColors.TEXT_DARK,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void onGetGymDetailsSuccess(GymDetailsModel model) {
//     // TODO: implement onGetGymDetailsSuccess
//   }
//
//   @override
//   void onGetGymError(Object errorTxt) {
//     if (errorTxt is String) {
//       CommonFunction.showToast(errorTxt);
//     } else if (errorTxt is GymModel) {
//       CommonFunction.showToast(errorTxt.message);
//     }
//     CommonFunction.showToast(errorTxt);
//   }
//
//   @override
//   void onGetGymSuccess(GymModel model) {
//     // TODO: implement onGetGymSuccess
//   }
//
//   @override
//   void onGymPlansSuccess(GymPlanModel model) {
//     if (model != null && model.status) {
//       setState(() {
//         _gymPlanModel = model;
//         isLoaded = true;
//       });
//     } else {
//       CommonFunction.showToast(model.message);
//     }
//   }
//
//   @override
//   void onGymSlotSuccess(GymSlotModel model) {
//     // TODO: implement onGymSlotSuccess
//   }
//
//   @override
//   void onsearchGymSuccess(GymSearchModel model) {
//     // TODO: implement onsearchGymSuccess
//   }
//
//   Future<void> getGymPlan(String gymId) async {
//     // CommonFunction.showProgressDialog(context);
//     print("get Gym Plan 0");
//     await _presenter.getGymPlans(gymId);
//   }
//
//   @override
//   void onAddSubscriptionSuccess(CommonModel model) {
//     // TODO: implement onAddSubscriptionSuccess
//   }
// }
