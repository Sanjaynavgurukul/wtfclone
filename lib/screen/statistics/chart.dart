import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/widget/progress_loader.dart';

class Chart extends StatelessWidget {
  const Chart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => store.memberStats != null
          ? store.memberStats.data != null &&
                  store.memberStats.data.weekcalories.isNotEmpty &&
                  store.memberStats.data.weekcalories.first.eCalories.isNotEmpty
              ? Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  height: Get.height * 0.28,
                  width: double.maxFinite,
                  child: Consumer<GymStore>(
                      builder: (context, store, child) => LineChart(
                            LineChartData(
                              maxY: 2000,
                              lineTouchData: LineTouchData(
                                  enabled: true,
                                  getTouchLineEnd: (data, val) => 0,
                                  touchTooltipData: LineTouchTooltipData(
                                    tooltipBgColor: Colors.red,
                                  )),
                              borderData: FlBorderData(
                                show: true,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white24,
                                  ),
                                ),
                              ),
                              axisTitleData: FlAxisTitleData(
                                  show: true,
                                  topTitle: AxisTitle(
                                    titleText: 'CALORIES',
                                    margin: 20,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                    showTitle: true,
                                    textAlign: TextAlign.left,
                                  )),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: store.memberStats.data.weekcalories
                                      .map((e) => FlSpot(
                                          store.memberStats.data.weekcalories
                                              .indexOf(e)
                                              .floorToDouble(),
                                          double.tryParse(e.eCalories)))
                                      .toList(),
                                  // [
                                  //             FlSpot(0, 400),
                                  //             FlSpot(1, 900),
                                  //             FlSpot(2, 800),
                                  //             FlSpot(3, 1500),
                                  //             FlSpot(4, 1600),
                                  //             FlSpot(5, 1800),
                                  //             FlSpot(6, 1300),
                                  //           ],
                                  isCurved: true,
                                  barWidth: 1,
                                  colors: [
                                    Colors.black,
                                    Colors.white38,
                                    Colors.white54,
                                    Colors.white70,
                                    Colors.white,
                                  ],
                                  belowBarData: BarAreaData(
                                    show: false,
                                  ),
                                  aboveBarData: BarAreaData(
                                    show: false,
                                  ),
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                ),
                              ],
                              minY: 0,
                              titlesData: FlTitlesData(
                                topTitles: SideTitles(showTitles: false),
                                rightTitles: SideTitles(showTitles: false),
                                bottomTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 5,
                                    getTextStyles: (context, double) {
                                      return TextStyle(
                                          fontSize: 12, color: Colors.white70);
                                    },
                                    getTitles: (value) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return 'MON';
                                        case 1:
                                          return 'TUE';
                                        case 2:
                                          return 'WED';
                                        case 3:
                                          return 'THU';
                                        case 4:
                                          return 'FRI';
                                        case 5:
                                          return 'SAT';
                                        default:
                                          return 'SUN';
                                      }
                                    }),
                                leftTitles: SideTitles(
                                  getTextStyles: (context, value) => TextStyle(
                                    fontSize: 11,
                                    color: value == 1000
                                        ? Colors.white
                                        : Colors.white70,
                                  ),
                                  showTitles: true,
                                  reservedSize: 25,
                                  getTitles: (value) {
                                    return '${value.toInt()}';
                                  },
                                ),
                              ),
                              gridData: FlGridData(
                                show: false,
                              ),
                            ),
                          )),
                )
              : Container()
          : Loading(),
    );
  }
}
