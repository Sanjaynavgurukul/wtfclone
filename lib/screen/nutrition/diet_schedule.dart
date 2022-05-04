import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
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
    if (store.dietItem != null &&
        store.dietItem.data != null &&
        store.dietItem.data.first.day != null) {
      store.dietItem.data.first.day.breakfast.map((e) {
        if (e.consumptionStatus ?? false) {
          consumed += 1;
        }
      }).toList();

      store.dietItem.data.first.day.mmSnack.map((e) {
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
        bottomNavigationBar: store.dietItem != null && isConValid()
            ? Padding(
          padding: EdgeInsets.only(left: 12,right: 12,bottom: 12),
              child: Container(
                  child: TextButton(
                    onPressed: () {
                      store.collectDietRewards(
                        context: context,
                        date: date,
                      );
                    },
                    child: Container(
                      height: 54,
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
                ),
            )
            : Padding(padding: EdgeInsets.only(left: 12,right: 12,bottom: 12),child: CollecReward()),
        appBar: AppBar(
          backgroundColor: AppColors.BACK_GROUND_BG,
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
              color: Color(0xff2d2d2d),
              height: 90.0,
              child: DatePicker(
                DateTime(calendetDate.year, calendetDate.month - 1,
                    calendetDate.day),
                // initialSelectedDate: selectedValue,
                initialSelectedDate: DateTime.now(),

                controller: datePickerController,
                selectionColor: AppConstants.bgColor,
                selectedTextColor: Colors.white,
                deactivatedColor: Colors.white,
                monthTextStyle: TextStyle(color: Colors.white),
                dateTextStyle: TextStyle(color: Colors.white),
                dayTextStyle: TextStyle(color: Colors.white),
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
              child: store.dietItem != null
                  ? store.dietItem.data != null &&
                          store.dietItem.data.isNotEmpty &&
                          store.dietItem.data.first.day != null
                      ? ListView(
                        padding: EdgeInsets.only(bottom: 70),
                          shrinkWrap: true,
                          children: [
                            store.dietItem.data.first.day.breakfast.isNotEmpty
                                ? Nutritioncard(
                                    nutrionType: store.dietItem.data.first.day
                                        .breakfast.first.category,
                                    breakfast:
                                        store.dietItem.data.first.day.breakfast,
                                    date: date,
                                    day: day,
                                  )
                                : Container(),
                            store.dietItem.data.first.day.mmSnack.isNotEmpty
                                ? Nutritioncard(
                                    nutrionType: store.dietItem.data.first.day
                                        .mmSnack.first.category,
                                    breakfast:
                                        store.dietItem.data.first.day.mmSnack,
                                    date: date,
                                    day: day,
                                  )
                                : Container(),
                            store.dietItem.data.first.day.lunch.isNotEmpty
                                ? Nutritioncard(
                                    nutrionType: store.dietItem.data.first.day
                                        .lunch.first.category,
                                    breakfast:
                                        store.dietItem.data.first.day.lunch,
                                    date: date,
                                    day: day,
                                  )
                                : Container(),
                            store.dietItem.data.first.day.snacks.isNotEmpty
                                ? Nutritioncard(
                                    nutrionType: store.dietItem.data.first.day
                                        .snacks.first.category,
                                    breakfast:
                                        store.dietItem.data.first.day.snacks,
                                    date: date,
                                    day: day,
                                  )
                                : Container(),
                            store.dietItem.data.first.day.dinner.isNotEmpty
                                ? Nutritioncard(
                                    nutrionType: store.dietItem.data.first.day
                                        .dinner.first.category,
                                    breakfast:
                                        store.dietItem.data.first.day.dinner,
                                    date: date,
                                    day: day,
                                  )
                                : Container(),
                          ],
                        )
                      : Center(
                          child: Text(
                            'No Diet Records Found!',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                color: Colors.white70),
                          ),
                        )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Loading(),
                    ),
            ),
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
          height: 54,
          width: MediaQuery.of(context).size.width * .95,
          decoration: BoxDecoration(
            color: AppConstants.bgColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Text(
              "Claim WTF Coins",
              style: TextStyle(
                color: AppConstants.white,
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
  final Breakfast data;
  final Function() onMarked;
  final isMarked;
  String date;

  DietCard({
    this.data,
    this.onMarked,
    this.isMarked = false,
    this.date,
  });

  @override
  _DietCardState createState() => _DietCardState(
        this.data,
        // this.isMarked,
      );
}

class _DietCardState extends State<DietCard> {
  Breakfast data;

  // bool isMarked;

  _DietCardState(
    this.data,
    // this.isMarked,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onMarked();
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
                        width: 70.0,
                        height: 70.0,
                        color: Colors.red.withOpacity(0.1),
                        child: Image.network(
                          data.coImage.isEmpty ||
                                  data.coImage == null ||
                                  data.coImage == "null"
                              ? Images.noImageFound
                              : data.coImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpace(12.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              data.name ?? '',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(6.0),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChipBox(
                                      text: 'Calorie Consumption',
                                    ),
                                    UIHelper.verticalSpace(6.0),
                                    Text(
                                      '${data.cal ?? 0} Cal' ?? 'n/a',
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
                          ),
                        ],
                      ),
                    ),
                    UIHelper.horizontalSpace(40.0),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -10.0,
            right: 10.0,
            child: (data.consumptionStatus != null && !data.consumptionStatus)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: data.consumptionStatus,
                        activeColor: AppConstants.bgColor,
                        side: BorderSide(
                          color: Colors.white,
                        ),
                        shape: CircleBorder(),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onChanged: (val) {
                          // setState(() {
                          //   isMarked = val;
                          // });
                          widget.onMarked();
                        },
                      ),
                      Text(
                        ' Click here\nto consume',
                        style: TextStyle(
                          color: AppConstants.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 10.0,
                        ),
                      ),
                      UIHelper.verticalSpace(4.0),
                      DietDataInfo(data: data),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        width: 24.0,
                        height: 24.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green,
                              blurRadius: 2.0,
                              spreadRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check,
                          color: AppConstants.white,
                        ),
                      ),
                      UIHelper.verticalSpace(4.0),
                      DietDataInfo(data: data),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class DietDataInfo extends StatelessWidget {
  const DietDataInfo({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Breakfast data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.PRIMARY_COLOR,
            titlePadding: EdgeInsets.only(
              left: 16.0,
              top: 6.0,
              right: 6.0,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            content: Html(
              data: data.description ?? '',
              // padding: EdgeInsets.all(8.0),
              // customRender: (node, children) {
              //   if (node is dom.Element) {
              //     switch (node.localName) {
              //       case "custom_tag": // using this, you can handle custom tags in your HTML
              //         return Column(children: children);
              //     }
              //   }
              // },
            ),
          ),
        );
      },
      child: Icon(
        Icons.info_outline,
        color: AppConstants.white,
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
    this.bgColor = AppConstants.bgColor,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: bgColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: size,
        ),
      ),
    );
  }
}
