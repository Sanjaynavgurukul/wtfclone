import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/all_diets.dart';
import 'package:wtf/widget/progress_loader.dart';

class DietSchedule extends StatefulWidget {
  @override
  _DietScheduleState createState() => _DietScheduleState();
}

class _DietScheduleState extends State<DietSchedule> {
  UserStore userStore;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  GymStore store;

  @override
  void initState() {
    Future.delayed(Duration.zero, loadSchedules);
    super.initState();
  }

  loadSchedules() {
    DateTime date = DateTime.now();
    var dateRes =
        '${date.day}/${date.month.toString().padLeft(2, '0')}/${date.year}';

    print(dateRes);
    context.read<GymStore>().getMyDietSchedules(
              date: Helper.formatDate2(date.toIso8601String()),
            )
        // userId: SharedPref.pref.getString(Preferences.USER_ID))
        // .getMySchedules(date: '5/09/2021', userId: 'FPzm2j79SoAR9')
        ;
  }

  @override
  Widget build(BuildContext context) {
    userStore = context.watch<UserStore>();
    store = context.watch<GymStore>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
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
        body: CustomScrollView(
          primary: true,
          shrinkWrap: true,
          cacheExtent: 200000.0,
          slivers: [
            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 100.0,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         UIHelper.verticalSpace(20.0),
            //         Container(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 8.0,
            //             horizontal: 14.0,
            //           ),
            //           child: Row(
            //             children: [
            //               IconButton(
            //                 onPressed: () {
            //                   NavigationService.goBack;
            //                 },
            //                 icon: Icon(
            //                   Icons.arrow_back_ios,
            //                   color: Colors.grey,
            //                 ),
            //               ),
            //               Align(
            //                 alignment: Alignment.bottomCenter,
            //                 child: Text(
            //                   'Diet Schedule',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 20.0,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //               Spacer(
            //                 flex: 1,
            //               ),
            //               InkWell(
            //                 onTap: () async {
            //                   Navigator.of(context).push(
            //                     MaterialPageRoute(
            //                       // builder: (context) => MyProfileXd(),
            //                       builder: (context) => SidebarDrawer(),
            //                     ),
            //                   );
            //                 },
            //                 child: PreferenceBuilder<String>(
            //                   preference: locator<AppPrefs>().avatar,
            //                   builder: (context, snapshot) {
            //                     print('user image: $snapshot');
            //                     String img = snapshot;
            //                     if (img.startsWith(
            //                         'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com')) {
            //                       img.replaceFirst(
            //                           'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com',
            //                           AppConstants.cloudFrontImage);
            //                     }
            //                     return CircleAvatar(
            //                       foregroundImage: NetworkImage(img),
            //                       backgroundColor:
            //                           Colors.blueGrey.withOpacity(0.2),
            //                       radius: 30,
            //                     );
            //                   },
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(
                  Duration(days: 365),
                ),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: {
                  // CalendarFormat.twoWeeks: '2 weeks',
                  CalendarFormat.twoWeeks: '2 Week',
                  CalendarFormat.month: 'Month',
                },
                headerVisible: true,
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                formatAnimationCurve: Curves.easeInOutCubic,
                pageAnimationCurve: Curves.easeInOutCubic,
                formatAnimationDuration: Duration(milliseconds: 800),
                pageAnimationDuration: Duration(milliseconds: 800),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    var date =
                        Helper.formatDate2(selectedDay.toIso8601String());
                    // locator<AppPrefs>()
                    //     .currentWorkoutDaySelected
                    //     .setValue(selectedDay.toIso8601String());
                    print(date);
                    context
                        .read<GymStore>()
                        .getMyDietSchedules(
                          date: date,
                        )
                        .then((value) {
                      setState(() {
                        // print('From MySchedule ${mySchedule.data}');
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    });
                  }
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  weekendStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  disabledTextStyle: TextStyle(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  holidayTextStyle: TextStyle(
                    color: Colors.red.withOpacity(0.4),
                  ),
                  outsideTextStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  weekendTextStyle: TextStyle(
                    color: Colors.red.withOpacity(0.8),
                  ),
                ),
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _calendarFormat =
                              _calendarFormat == CalendarFormat.month
                                  ? CalendarFormat.twoWeeks
                                  : CalendarFormat.month;
                        });
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/arrow_down.svg',
                        color: Colors.red,
                      ),
                    ),
                    UIHelper.verticalSpace(16.0),
                    Flexible(
                      child: Consumer<GymStore>(
                        builder: (context, store, child) => store.allDiets !=
                                null
                            ? store.allDiets.data != null &&
                                    store.allDiets.data.isNotEmpty
                                ? Wrap(
                                    children: store.allDiets.data
                                        .map(
                                          (e) => DietCard(
                                            data: e,
                                            isMarked: !(e.status == 'active'),
                                            onMarked: (val) {
                                              store.markDietAsConsumed(
                                                dietId: e.uid,
                                                context: context,
                                                selectedDate: _selectedDay,
                                              );
                                            },
                                          ),
                                        )
                                        .toList(),
                                  )
                                : Center(
                                    child: Text(
                                      'No Schedules!',
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
