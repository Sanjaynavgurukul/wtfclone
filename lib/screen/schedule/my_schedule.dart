import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/screen/side_bar_drawer/SidebarDrawer.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../../main.dart';

class MyScheduleScreen extends StatefulWidget {
  @override
  _MyScheduleScreenState createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  GymStore store;

  @override
  void initState() {
    Future.delayed(Duration.zero, loadSchedules);
    super.initState();
  }

  loadSchedules() {
    var dateRes =
        '${_selectedDay.day}/${_selectedDay.month.toString().padLeft(2, '0')}/${_selectedDay.year}';

    print(dateRes);
    context.read<GymStore>().getMySchedules(
          date: Helper.formatDate2(_selectedDay.toIso8601String()),
        );
    // userId: SharedPref.pref.getString(Preferences.USER_ID))
    // .getMySchedules(date: '5/09/2021', userId: 'FPzm2j79SoAR9')
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        body: CustomScrollView(
          primary: true,
          shrinkWrap: true,
          cacheExtent: 200000.0,
          slivers: [
            //This is header :D
            SliverToBoxAdapter(
              child: Container(
                height: 98.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpace(20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 14.0,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              NavigationService.goBack;
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.grey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'MY SCHEDULE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  // builder: (context) => MyProfileXd(),
                                  builder: (context) => SidebarDrawer(),
                                ),
                              );
                            },
                            child: PreferenceBuilder<String>(
                              preference: locator<AppPrefs>().avatar,
                              builder: (context, snapshot) {
                                print('user image: $snapshot');
                                String img = snapshot;
                                if (img.startsWith(
                                    'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com')) {
                                  img.replaceFirst(
                                      'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com',
                                      AppConstants.cloudFrontImage);
                                }
                                return CircleAvatar(
                                  foregroundImage: NetworkImage(img),
                                  backgroundColor:
                                      Colors.blueGrey.withOpacity(0.2),
                                  radius: 30,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //This is date selection section ;D
            SliverToBoxAdapter(
              child: TableCalendar(
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
                    // Call `setState()` when updating the selected day
                    var date =
                        Helper.formatDate2(selectedDay.toIso8601String());
                    locator<AppPrefs>().selectedWorkoutDate.setValue(date);
                    print(date);
                    context
                        .read<GymStore>()
                        .getMySchedules(
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
                    UIHelper.verticalSpace(8.0),
                    if (store.mySchedule != null)
                      SizedBox(
                        height: 20,
                      ),
                    Flexible(
                      child: Consumer<GymStore>(
                        builder: (context, store, child) => store.mySchedule !=
                                null
                            ? store.mySchedule.data != null &&
                                    store.mySchedule.data.allData.isNotEmpty
                                ? Wrap(
                                    children:
                                        store.mySchedule.data.allData.values
                                            .map(
                                              (e) => ScheduleListItems(
                                                name: store.mySchedule.data
                                                    .allData.keys
                                                    .firstWhere(
                                                  (element) =>
                                                      store.mySchedule.data
                                                          .allData[element] ==
                                                      e,
                                                ),
                                                schedule: e,
                                                selectedDate: _selectedDay,
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
                                        color: Colors.white70,
                                      ),
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
    print('schedules length: ${schedule.length}');
    return Consumer<GymStore>(
      builder: (context, store, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: schedule
              .map(
                (e) => InkWell(
                  onTap: () {
                    context.read<GymStore>().setSelectedSchedule(
                          context: context,
                          val: e,
                        );
                    store.getCurrentTrainer(context: context);
                    switch (name) {
                      case 'Personal Training':
                      case 'General Training':
                        print(
                            'schedule:: ${schedule.map((e) => e.toJson()).toList()}');
                        locator<AppPrefs>().selectedMySchedule.setValue(name);
                        locator<AppPrefs>()
                            .selectedMyScheduleName
                            .setValue(name);
                        locator<AppPrefs>()
                            .selectedWorkoutDate
                            .setValue(Helper.formatDate2(
                              selectedDate.toIso8601String(),
                            ));
                        locator<AppPrefs>().selectedMyScheduleData.setValue(e);
                        context.read<GymStore>().getMyWorkoutSchedules(
                              date: Helper.formatDate2(
                                selectedDate.toIso8601String(),
                              ),
                              subscriptionId: e.uid,
                              addonId:
                                  name == 'General Training' ? null : e.addonId,
                            );
                        // NavigationService.navigateTo(Routes.mainWorkoutScreen);
                        NavigationService.navigateTo(Routes.mainWorkout);
                        break;
                      case 'event':
                        store.getEventById(
                            context: context, eventId: e.eventId);
                        locator<AppPrefs>().selectedMySchedule.setValue(name);
                        locator<AppPrefs>()
                            .selectedMyScheduleName
                            .setValue(e.eventName);
                        NavigationService.navigateTo(Routes.eventDetails);
                        break;
                      case 'addon':
                        locator<AppPrefs>().selectedMySchedule.setValue(name);
                        locator<AppPrefs>()
                            .selectedMyScheduleName
                            .setValue(e.addonName);
                        print('addonId: ${e.addonId}');
                        locator<AppPrefs>()
                            .selectedWorkoutDate
                            .setValue(Helper.formatDate2(
                              selectedDate.toIso8601String(),
                            ));
                        locator<AppPrefs>().selectedMyScheduleData.setValue(e);
                        context.read<GymStore>().getMyWorkoutSchedules(
                            date: Helper.formatDate2(
                              selectedDate.toIso8601String(),
                            ),
                            subscriptionId: e.uid,
                            addonId: e.addonId);
                        NavigationService.navigateTo(Routes.mainWorkoutScreen);
                        break;
                      case 'Live Sessions':
                        log('sta:::-->> ${e.roomStatus}');
                        switch (e.roomStatus) {
                          case 'scheduled':
                            FlashHelper.informationBar(
                              context,
                              message:
                                  'Trainer has not started the live session yet',
                            );
                            break;
                          case 'started':
                            context.read<GymStore>().joinLiveSession(
                                  addonName: e.addonName,
                                  liveClassId: e.liveClassId,
                                  roomId: e.roomId,
                                  context: context,
                                  addonId: e.addonId,
                                );
                            break;
                          case 'completed':
                            FlashHelper.informationBar(
                              context,
                              message: 'Trainer has ended the live session',
                            );
                            break;
                          default:
                            break;
                        }
                        break;
                    }
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 4,
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
                                                    ' (${e.eventType == 'regular' ? 'Event' : e.eventType ?? ''})'
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
                                                  'Completed Session: ${e.completedSession ?? 0}'),
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
                                                'Address: ${e.gymAddress1}, ${e.gymAddress2}',
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
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
