import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/all_diets.dart';
import 'package:wtf/model/diet_item.dart';
import 'package:wtf/widget/nutrition_card.dart';
import 'package:wtf/widget/progress_loader.dart';

class DietSchedule extends StatefulWidget {
  @override
  _DietScheduleState createState() => _DietScheduleState();
}

class _DietScheduleState extends State<DietSchedule> {
  UserStore userStore;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime selectedValue = DateTime.now();
  DateTime calendetDate = DateTime.now();
  DietItem res;
  String date;
  String day;
  GymStore store;

  DatePickerController datePickerController = DatePickerController();

  @override
  void initState() {
    Future.delayed(Duration.zero, loadSchedules);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      datePickerController.jumpToSelection();
      // datePickerController.animateToSelection(
      //     duration: Duration(milliseconds: 500));
    });
    super.initState();
  }

  loadSchedules() {
    DateTime tdate = DateTime.now();
    day = DateFormat('EEEE').format(tdate).toLowerCase();
    final df = DateFormat('dd-MM-yyyy');
    date = df.format(tdate).toString();
    store.getdietcat(context: context, day: day, date: date);
    isConValid();
    //store.getdietConsumed(context: context, date: date);
  }

  bool isConValid() {
    int consumed = 0;
    if (store.dietItem != null) {
      store.dietItem.data.first.day.breakfast.map((e) {
        if (e.consumptionStatus ?? false) {
          consumed += 1;
        }
      }).toList();
      store.dietItem.data.first.day.dinner.map((e) {
        if (e.consumptionStatus ?? false) {
          consumed += 1;
        }
      }).toList();
      store.dietItem.data.first.day.snacks.map((e) {
        if (e.consumptionStatus ?? false) {
          consumed += 1;
        }
      }).toList();
      store.dietItem.data.first.day.lunch.map((e) {
        if (e.consumptionStatus ?? false) {
          consumed += 1;
        }
      }).toList();

      if (consumed ==
          (store.dietItem.data.first.day.breakfast.length +
              store.dietItem.data.first.day.dinner.length +
              store.dietItem.data.first.day.lunch.length +
              store.dietItem.data.first.day.snacks.length)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    userStore = context.watch<UserStore>();
    store = context.watch<GymStore>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.primaryColor,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          elevation: 1.0,
          title: Text(
            'Diet Schedule',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          primary: true,
          shrinkWrap: true,
          cacheExtent: 200000.0,
          children: [
            Container(
              color: Colors.white,
              height: 90.0,
              child: DatePicker(
                DateTime(calendetDate.year, calendetDate.month - 1,
                    calendetDate.day),
                initialSelectedDate: selectedValue,
                controller: datePickerController,
                selectionColor: AppConstants.primaryColor,
                selectedTextColor: Colors.white,
                deactivatedColor: Colors.white,
                onDateChange: (cdate) {
                  final df = DateFormat('dd-MM-yyyy');
                  day = DateFormat('EEEE').format(cdate).toLowerCase();
                  date = df.format(cdate).toString();
                  if (day != null) {
                    store.getdietcat(context: context, day: day, date: date);
                    isConValid();
                    // store.getdietConsumed(context: context, date: date);
                  }
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 165 - kToolbarHeight,
              color: AppConstants.primaryColor,
              child: store.dietItem != null
                  ? store.dietItem.data != null &&
                          store.dietItem.data.isNotEmpty
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            Nutritioncard(
                              nutrionType: store.dietItem.data.first.day
                                  .breakfast.first.category,
                              breakfast:
                                  store.dietItem.data.first.day.breakfast,
                              date: date,
                              day: day,
                            ),
                            Nutritioncard(
                              nutrionType: store
                                  .dietItem.data.first.day.lunch.first.category,
                              breakfast: store.dietItem.data.first.day.lunch,
                              date: date,
                              day: day,
                            ),
                            Nutritioncard(
                              nutrionType: store.dietItem.data.first.day.snacks
                                  .first.category,
                              breakfast: store.dietItem.data.first.day.snacks,
                              date: date,
                              day: day,
                            ),
                            Nutritioncard(
                              nutrionType: store.dietItem.data.first.day.dinner
                                  .first.category,
                              breakfast: store.dietItem.data.first.day.dinner,
                              date: date,
                              day: day,
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            'No Diet Records Found!',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white70),
                          ),
                        )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Loading(),
                    ),
            ),
            store.dietItem != null && isConValid()
                ? Container(
                    child: TextButton(
                      onPressed: () {
                        store.collectDietRewards(context: context, date: date);
                      },
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width * .95,
                        decoration: BoxDecoration(
                          color: AppConstants.bgColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            "Claim WTF Coins",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : CollecReward(),
          ],
        ),
      ),
    );
  }
}

class CollecReward extends StatelessWidget {
  const CollecReward({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          FlashHelper.informationBar(
            context,
            message:
                "You have to consume all the meals before collecting the reward ",
          );
        },
        child: Container(
          height: 35,
          width: MediaQuery.of(context).size.width * .95,
          decoration: BoxDecoration(
            color: AppConstants.bgColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Text(
              "Claim WTF Coins",
              style: TextStyle(
                color: AppConstants.deactivatedText,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DietCard extends StatefulWidget {
  final DietData data;
  final Function(bool) onMarked;
  final isMarked;

  DietCard({
    this.data,
    this.onMarked,
    this.isMarked = false,
  });

  @override
  _DietCardState createState() => _DietCardState(
        this.data,
        this.isMarked,
      );
}

class _DietCardState extends State<DietCard> {
  DietData data;
  bool isMarked;
  _DietCardState(
    this.data,
    this.isMarked,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ),
      // padding: const EdgeInsets.symmetric(
      //   vertical: 12.0,
      //   horizontal: 16.0,
      // ),
      elevation: 12.0,
      color: Colors.black.withOpacity(0.3),
      child: InkWell(
        onTap: () {
          setState(() {
            isMarked = !isMarked;
          });
          widget.onMarked(isMarked);
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          color: Colors.red.withOpacity(0.1),
                          child: data.image != null
                              ? Image.network(
                                  data.image,
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                      ),
                      UIHelper.horizontalSpace(12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            data.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          UIHelper.verticalSpace(6.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipBox(
                                text:
                                    'Date: ${Helper.stringForDatetime2(data.dateAdded)}' ??
                                        'n/a',
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ChipBox(
                                    text: 'Calorie Gain',
                                  ),
                                  UIHelper.verticalSpace(6.0),
                                  Text(
                                    '${data.expCal ?? 0} Cal' ?? 'n/a',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              UIHelper.horizontalSpace(12.0),
                              Column(
                                children: [
                                  ChipBox(
                                    text: 'Intake',
                                  ),
                                  UIHelper.verticalSpace(6.0),
                                  Text(
                                    '${data.intake ?? 0}' ?? 'n/a',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  if (data.status == 'consumed')
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        'Consumed',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Positioned(
              top: 2.0,
              right: 10.0,
              child: (data.status == 'pending' || data.status == 'active')
                  ? Checkbox(
                      value: isMarked,
                      activeColor: AppConstants.primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (val) {
                        setState(() {
                          isMarked = val;
                        });
                        widget.onMarked(isMarked);
                      },
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChipBox extends StatelessWidget {
  final String text;
  final Color bgColor;
  final double size;

  ChipBox({
    this.text,
    this.bgColor = Colors.red,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: bgColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: size,
        ),
      ),
    );
  }
}
