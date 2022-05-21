import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/preamble_helper.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/member_detils.dart';
import 'package:wtf/model/preamble_model.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../../main.dart';

class BodyStats extends StatelessWidget {
  const BodyStats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26.0),
          child: Text(
            'My Body Stats',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        Consumer<GymStore>(
          builder: (context, store, child) => store.memberStats != null
              ? store.memberStats.data != null
                  ? StaggeredGridView.count(
                      crossAxisCount: 2,
                      staggeredTiles: [
                        StaggeredTile.count(1, 1.28),
                        StaggeredTile.count(1, 1.25),
                        StaggeredTile.count(1, 1.28),
                        StaggeredTile.count(1, 1.25),
                      ],
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      children: _tiles(),
                    )
                  : Container()
              : Loading(),
        ),
        Center(
          child: Text(
            'Note: Tap on any card to update.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _tiles() {
    List titles = [
      'Calories Burnt - Today',
      'How fat am I?',
      'How many calories should I burn?',
      'My Goal'
    ];
    return [0, 1, 2, 3]
        .map(
          (e) => e == 3
              ? MyGoals(titles[e], e)
              : e == 0
                  ? MyCalories(titles[e], e)
                  : e == 1
                      ? MyBodyFat(titles[e], e)
                      : MyBmr(titles[e], e),
        )
        .toList();
  }
}

class ListItems extends StatelessWidget {
  final title, index;

  const ListItems(
    this.title,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: index.isEven
                      ? [
                          Colors.transparent,
                          AppConstants.primaryColor,
                        ]
                      : [
                          Colors.transparent,
                          Colors.white12,
                          Colors.transparent
                        ],
                  stops: index.isEven ? [0.1, 1.0] : [0.0, 0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 15.0,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30.0,
              left: 15.0,
              child: Center(
                child: Text(
                  '7',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              left: 15.0,
              child: Center(
                child: Text(
                  'of 8 cups',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//My Goal Section :D
class MyGoals extends StatelessWidget {
  final title, index;

  const MyGoals(
    this.title,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO check preabmle navigation :D
        // NavigationService.navigateTo(Routes.updateFitnessProfile);
        bool filledPreamble = locator<AppPrefs>().memberAdded.getValue();
        if(filledPreamble){
          context.read<GymStore>().preambleFromLogin = false;
          context.read<GymStore>().getMemberById();
          NavigationService.navigateTo(Routes.userDetail);
        }else{
          NavigationService.navigateTo(Routes.userDetail);
        }
      },
      child: Card(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                  color:Color(0xff2d2d2d)
                // gradient: LinearGradient(
                //   begin: FractionalOffset.topCenter,
                //   end: FractionalOffset.bottomCenter,
                //   colors: index.isEven
                //       ? [
                //           Colors.transparent,
                //           AppConstants.primaryColor,
                //         ]
                //       : [
                //           Colors.transparent,
                //           Colors.white12,
                //           Colors.transparent
                //         ],
                //   stops: index.isEven ? [0.1, 1.0] : [0.0, 0.5, 1.0],
                // ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/duration.png',
                      height: 20.0,
                    ),
                    UIHelper.horizontalSpace(6.0),
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PreferenceBuilder<PreambleModel>(
                      preference: locator<AppPrefs>().memberData,
                      builder: (context, snapshot) {
                        return RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Target Weight:  \n',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.0,
                            ),
                            children: [
                              if (snapshot != null &&
                                  snapshot.target_weight != null)
                                TextSpan(
                                  text: snapshot.target_weight.toString() + " Kg",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    UIHelper.verticalSpace(6.0),
                    Center(
                      child: Image.asset(
                        'assets/images/goal.png',
                        height: 80.0,
                      ),
                    ),
                    UIHelper.verticalSpace(6.0),
                    PreferenceBuilder<PreambleModel>(
                      preference: locator<AppPrefs>().memberData,
                      builder: (context, snapshot) {
                        return RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Current Weight:  \n',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.0,
                            ),
                            children: [
                              if (snapshot != null && snapshot.weight != null)
                                TextSpan(
                                  text: snapshot.weight + " Kg",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Calories burn count section :D
class MyCalories extends StatelessWidget {
  final title, index;

  const MyCalories(
    this.title,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return InkWell(
      onTap: () {
        // NavigationService.navigateTo(Routes.calorieCounter);
        if(PreambleHelper.hasPreamble()){
          NavigationService.navigateTo(Routes.calorieCounter);
        }else{
          PreambleHelper.showPreambleWarningDialog(context: context);
        }
      },
      child: Card(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color:Color(0xff2d2d2d)
                // gradient: LinearGradient(
                //   begin: FractionalOffset.topCenter,
                //   end: FractionalOffset.bottomCenter,
                //   colors: index.isEven
                //       ? [
                //           Colors.transparent,
                //           AppConstants.bgColor,
                //         ]
                //       : [
                //           Colors.transparent,
                //           Colors.white12,
                //           Colors.transparent
                //         ],
                //   stops: index.isEven ? [0.1, 1.0] : [0.0, 0.5, 1.0],
                // ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 6.0,
              right: 6.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cal.png',
                      height: 30.0,
                    ),
                    Flexible(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // if (store.memberStats.data.weekcalories.isNotEmpty &&
            //     store.memberStats.data.weekcalories.first.eCalories != null)
            //   Positioned(
            //     bottom: 20.0,
            //     left: 0.0,
            //     right: 0.0,
            //     child: Center(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           UIHelper.verticalSpace(6.0),
            //           Center(
            //             child: Image.asset(
            //               'assets/images/caloriess.jpeg',
            //               height: 120.0,
            //             ),
            //           ),
            //           UIHelper.verticalSpace(6.0),
            //         ],
            //       ),
            //     ),
            //   ),
            Positioned(
              top: 100.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: store.memberStats.data.weekcalories.isNotEmpty &&
                        store.memberStats.data.weekcalories.first.eCalories !=
                            null
                    ? Column(
                        children: [
                          Text(
                            store.memberStats.data.weekcalories.first.eCalories
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          UIHelper.verticalSpace(6.0),
                          Text(
                            'K Cal',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Complete a workout to calculate calories burned.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBmr extends StatelessWidget {
  final title, index;

  const MyBmr(
    this.title,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return InkWell(
      onTap: () {
        if(PreambleHelper.hasPreamble()){
          NavigationService.navigateTo(Routes.bmrCalculator);
        }else{
          PreambleHelper.showPreambleWarningDialog(context: context);
        }
      },
      child: Card(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                  color:Color(0xff2d2d2d)
                // gradient: LinearGradient(
                //   begin: FractionalOffset.topCenter,
                //   end: FractionalOffset.bottomCenter,
                //   colors: index.isEven
                //       ? [
                //           Colors.transparent,
                //           AppConstants.primaryColor,
                //         ]
                //       : [
                //           Colors.transparent,
                //           Colors.white12,
                //           Colors.transparent
                //         ],
                //   stops: index.isEven ? [0.1, 1.0] : [0.0, 0.5, 1.0],
                // ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 4.0,
              right: 4.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bmr.png',
                      height: 30.0,
                    ),
                    Flexible(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: store.memberStats.data.bmrCal.isNotEmpty ? 20.0 : 60.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: store.memberStats.data.bmrCal.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          UIHelper.verticalSpace(6.0),
                          Center(
                            child: Image.asset(
                              'assets/images/muscle.png',
                              height: 120.0,
                            ),
                          ),
                          UIHelper.verticalSpace(8.0),
                          Text(
                            double.tryParse(store.memberStats.data.bmrCal.first
                                            .bmrResult)
                                        .toStringAsFixed(2) +
                                    ' Kcal' ??
                                '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Click here to calculate',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//How fat am i Section :D
class MyBodyFat extends StatelessWidget {
  final title, index;

  const MyBodyFat(
    this.title,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return InkWell(
      onTap: () {
        if(PreambleHelper.hasPreamble()){
          NavigationService.navigateTo(Routes.bodyFatCal);
        }else{
          PreambleHelper.showPreambleWarningDialog(context: context);
        }
      },
      child: Card(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                  color:Color(0xff2d2d2d)
                // gradient: LinearGradient(
                //   begin: FractionalOffset.topCenter,
                //   end: FractionalOffset.bottomCenter,
                //   colors: index.isEven
                //       ? [
                //           Colors.transparent,
                //           AppConstants.primaryColor,
                //         ]
                //       : [
                //           Colors.transparent,
                //           Colors.white12,
                //           Colors.transparent
                //         ],
                //   stops: index.isEven ? [0.1, 1.0] : [0.0, 0.5, 1.0],
                // ),
              ),
              child: store.memberStats.data.bodyfatCal.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IntrinsicHeight(
                        //   child: AspectRatio(
                        //     aspectRatio: 1.7,
                        //     child: BarChart(
                        //       BarChartData(
                        //         barTouchData: barTouchData,
                        //         titlesData: titlesData,
                        //         borderData: borderData,
                        //         barGroups: store.memberStats.data.bodyfatCal
                        //             .map(
                        //               (e) => BarChartGroupData(
                        //                 x: 0,
                        //                 barRods: [
                        //                   BarChartRodData(
                        //                     y: e.bodyFatResult.floorToDouble(),
                        //                     colors: [
                        //                       AppConstants.primaryColor,
                        //                       Colors.white,
                        //                     ],
                        //                   )
                        //                 ],
                        //                 // showingTooltipIndicators: [0],
                        //               ),
                        //             )
                        //             .toList(),
                        //         maxY: 20,
                        //         rangeAnnotations: RangeAnnotations(
                        //           horizontalRangeAnnotations: [],
                        //         ),
                        //         // read about it in the BarChartData section
                        //       ),
                        //       swapAnimationDuration:
                        //           Duration(milliseconds: 150), // Optional
                        //       swapAnimationCurve: Curves.linear, // Optional
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: Image.asset(
                            'assets/images/body_fat.png',
                            height: 80.0,
                          ),
                        ),
                        UIHelper.verticalSpace(6.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Fat: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              store.memberStats.data.bodyfatCal.first
                                          .bodyFatResult
                                          .toStringAsFixed(2) +
                                      " %" ??
                                  '',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Click here to calculate',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
            Positioned(
              top: 10.0,
              left: 6.0,
              right: 6.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/images/fat.png',
                      height: 20.0,
                    ),
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: false,
        bottomTitles: SideTitles(
          showTitles: false,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mn';
              case 1:
                return 'Te';
              case 2:
                return 'Wd';
              case 3:
                return 'Tu';
              case 4:
                return 'Fr';
              case 5:
                return 'St';
              case 6:
                return 'Sn';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );
}
