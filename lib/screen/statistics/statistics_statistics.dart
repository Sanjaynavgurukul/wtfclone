import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/statistics/statistics_item.dart';
import 'package:wtf/widget/progress_loader.dart';

class StatisticsStatistics extends StatelessWidget {
  const StatisticsStatistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Consumer<GymStore>(
        builder: (context, store, child) => store.memberStats != null
            ? Column(
                children: [
                  UIHelper.verticalSpace(30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatisticsItem(
                        text: 'My Body Fat',
                        subText: store.memberStats.data.bodyfatCal.isNotEmpty
                            ? store
                                .memberStats.data.bodyfatCal.first.bodyFatResult
                                .toStringAsFixed(2)
                            : '0',
                        showGradient:
                            store.memberStats.data.bodyfatCal.isNotEmpty,
                      ),
                      StatisticsItem(
                        text: 'BMR',
                        subText: store.memberStats.data.bmrCal.isNotEmpty
                            ? store.memberStats.data.bmrCal.first.bmrResult
                            : '0',
                        showGradient: store.memberStats.data.bmrCal.isNotEmpty,
                      ),
                      StatisticsItem(
                        text: 'Calories Burned',
                        subText: store.memberStats.data.weekcalories.isNotEmpty
                            ? store
                                .memberStats.data.weekcalories.first.eCalories
                                .toString()
                            : '0',
                        showGradient: store
                                .memberStats.data.weekcalories.isNotEmpty &&
                            store.memberStats.data.weekcalories.first.eCalories
                                    .toString() !=
                                '0',
                      ),
                    ],
                  )
                ],
              )
            : Loading(),
      ),
    );
  }
}
