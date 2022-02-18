import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/progress_loader.dart';

class EventSubmissionScreen extends StatelessWidget {
  const EventSubmissionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);

    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        title: Text(
          '${store.selectedEventData.name} Submissions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Consumer<GymStore>(
        builder: (context, store, child) => store.selectedEventSubmissions !=
                null
            ? store.selectedEventSubmissions.data != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Wrap(
                          runSpacing: 6.0,
                          spacing: 6.0,
                          alignment: WrapAlignment.spaceEvenly,
                          runAlignment: WrapAlignment.spaceEvenly,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: store.selectedEventSubmissions.data[0].days
                              .map((e) {
                            String day =
                                'Day ${store.selectedEventSubmissions.data[0].days.indexOf(e) + 1} Event';
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 150.0,
                              color: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    day,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppConstants.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (e.submissions.isEmpty) ...{
                                        Icon(
                                          Icons.upcoming_outlined,
                                          color: AppConstants.red,
                                        ),
                                        UIHelper.horizontalSpace(8.0),
                                        Text(
                                          'Upcoming',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.red,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      } else ...{
                                        if (e.submissions.length == 3) ...{
                                          Icon(
                                            Icons.check_circle,
                                            color: AppConstants.green,
                                          ),
                                          UIHelper.horizontalSpace(8.0),
                                          Text(
                                            'Completed',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppConstants.red,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        } else ...{
                                          Icon(
                                            Icons.offline_bolt,
                                            color: AppConstants.orangeBg,
                                          ),
                                          UIHelper.horizontalSpace(8.0),
                                          Text(
                                            'Running',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppConstants.orangeBg2,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        }
                                      }
                                    ],
                                  ),
                                  // if (Helper.stringForDatetime3(
                                  //             DateTime.now().toIso8601String())
                                  //         .contains(e.date) &&
                                  //     e.submissions.length < 3)
                                  CustomButton(
                                    height: 20.0,
                                    bgColor: AppConstants.primaryColor,
                                    onTap: () {
                                      log('data:: ${Helper.stringForDatetime3(DateTime.now().toIso8601String())}  == ${e.date}');
                                      store.setEventSubmission(
                                        data: e.submissions,
                                      );
                                      locator<AppPrefs>()
                                          .selectedMySchedule
                                          .setValue(day);
                                      NavigationService.navigateTo(
                                          Routes.submissionDetail);
                                    },
                                    text: 'Post',
                                    textColor: Colors.white,
                                    textSize: 14.0,
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'No Submissions found',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  )
            : Loading(),
      ),
    );
  }

  whiteButton(title, onPress) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: onPress,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
          ),
        ),
      );
}
