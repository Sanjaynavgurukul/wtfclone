import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/screen/schedule/arguments/main_workout_argument.dart';
import 'package:wtf/widget/gradient_image_widget.dart';

class DateWorkoutList extends StatefulWidget {
  static const routeName = '/dateWorkoutList';

  const DateWorkoutList({Key key}) : super(key: key);

  @override
  _DateWorkoutListState createState() => _DateWorkoutListState();
}

class _DateWorkoutListState extends State<DateWorkoutList> {
  GymStore user;
  bool callMethod = true;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  void callData() {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        user.getScheduleData(date:Helper.formatDate2(_selectedDay.toIso8601String()),);
      }
    });
  }

  void onRefreshPage() {
    user.scheduleData = null;
    this.callMethod = true;
    callData();
  }

  @override
  Widget build(BuildContext context) {
    //Calling initial Data :D
    callData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.BACK_GROUND_BG,
        title: Text('My Schedule'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          onRefreshPage();
        },
        child: CustomScrollView(
          primary: true,
          shrinkWrap: true,
          cacheExtent: 200000.0,
          slivers: [
            //Date Selection Section :D
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.now().subtract(Duration(days: 14)),
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
                        setState(() {
                          // print('From MySchedule ${mySchedule.data}');
                          this.callMethod = true;
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });

                        // Call `setState()` when updating the selected day

                        // var date =
                        // Helper.formatDate2(selectedDay.toIso8601String());
                        // locator<AppPrefs>().selectedWorkoutDate.setValue(date);
                        // print(date);
                        // context
                        //     .read<GymStore>()
                        //     .getMySchedules(
                        //   date: date,
                        // )
                        //     .then((value) {
                        //   setState(() {
                        //     // print('From MySchedule ${mySchedule.data}');
                        //     _selectedDay = selectedDay;
                        //     _focusedDay = focusedDay;
                        //   });
                        // });
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
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Consumer<GymStore>(builder: (context, user, snapshot) {
                if (user.scheduleData == null) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else {
                  return user.scheduleData.data.allData.isEmpty ||
                      user.scheduleData.data.allData == null
                      ? Center(
                    child: Text('No Workout Found'),
                  )
                      : Flexible(
                    child: Column(
                      children: user.scheduleData.data.allData.values
                          .map(
                            (e) =>
                            ScheduleListItems(
                              name: user.scheduleData.data.allData.keys
                                  .firstWhere(
                                    (element) =>
                                user.scheduleData.data
                                    .allData[element] ==
                                    e,
                              ),
                              schedule: e,
                              selectedDate: _selectedDay,
                            ),
                      )
                          .toList(),
                    ),
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}

class ScheduleListItems extends StatelessWidget {
  final String name;
  final DateTime selectedDate;
  final List<MyScheduleAddonData> schedule;

  const ScheduleListItems({
    this.schedule,
    this.name,
    @required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: schedule
              .map(
                (e) =>
                InkWell(
                  onTap: () {
                    context.read<GymStore>().setSelectedSchedule(
                      context: context,
                      val: schedule.first,
                    );
                    store.getCurrentTrainer(context: context);
                    NavigationService.pushName(Routes.mainWorkout,
                        argument: MainWorkoutArgument(
                            data: e, workoutType: name, time: selectedDate));
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          child: GradientImageWidget(
                            borderRadius: BorderRadius.circular(8.0),
                            network: name == 'General Training'
                                ? Images.generalTraining
                                : name == 'Personal Training'
                                ? Images.personalTraining
                                : e.gymCoverImage
                                .startsWith('https://wtfupme')
                                ? null
                                : e.gymCoverImage,
                            stops: [0.01, 1.0],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: const [
                                Colors.transparent,
                                Colors.red,
                              ],
                              stops: const [0.4, 1.0],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 0.0,
                          right: 0.0,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  name == 'addon'
                                      ? e.addonName
                                      : name == 'event'
                                      ? e.eventName +
                                      ' (${e.eventType == 'regular' ? 'Event' : e
                                          .eventType ?? ''})'
                                      : name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                UIHelper.verticalSpace(10.0),
                                if (name == 'Personal Training' ||
                                    name == 'addon')
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Total Session: ${e.nSession ?? 0}'),
                                        Text(
                                            'Completed Session: ${e
                                                .completedSession ?? 0}'),
                                      ],
                                    ),
                                  ),
                                if (name == 'event')
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 4.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Addon: - ${e.addonName}',
                                        ),
                                        Text(
                                          'Gym Name - ${e.gymname}',
                                        ),
                                        Text(
                                          'Address: ${e.gymAddress1}, ${e
                                              .gymAddress2}',
                                        ),
                                      ],
                                    ),
                                  ),
                                if (name == 'Live Sessions')
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 4.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${e.addonName}',
                                        ),
                                        Text(
                                          '${e.gymname}',
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          )
              .toList(),
        ),
      )
    );
  }
}
