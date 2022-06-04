import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wtf/100ms/common/util/utility_components.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/screen/schedule/timer_helper/exercise_timer_helper.dart';
import 'package:wtf/widget/image_stack.dart';
import 'dart:math' as math;

import 'package:wtf/widget/progress_loader.dart';

class ScheduleMain extends StatefulWidget {
  static const String routeName = '/scheduleMain';

  const ScheduleMain({Key key}) : super(key: key);

  @override
  State<ScheduleMain> createState() => _ScheduleMainState();
}

class _ScheduleMainState extends State<ScheduleMain> {
  GymStore user;
  bool callMethod = true;

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
        user.getMySchedules(
          date: Helper.formatDate2(DateTime.now().toIso8601String()),
        );
        print('final date checking called method --- ${user.workoutDate}');
      }
    });
  }

  void onRefreshPage() {
    user.mySchedule = null;
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
          elevation: 0,
          title: Text('My Schedule'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Consumer<GymStore>(
              builder: (context, store, child) => store.mySchedule != null
                  ? SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 0, right: 0),
                            title: Text('Hello,',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18)),
                            subtitle: Text(
                                '${locator<AppPrefs>().userName.getValue()}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                            trailing: ClipOval(
                              child: Image.network(
                                "${locator<AppPrefs>().avatar.getValue()}" ??
                                    'https://via.placeholder.com/150',
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Text('Error');
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RecommendedProgramScreen(),
                          SizedBox(
                            height: 12,
                          ),
                          ScheduleTrainerSection(),
                          SizedBox(
                            height: 18,
                          ),
                          if (store.mySchedule != null &&
                              store.mySchedule.data != null)
                            ScheduleItem(
                              allData: store.mySchedule.data,
                            )
                        ],
                      ),
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Loading(),
                    ),
            )));
  }

  Widget labelWidget({
    @required String label,
  }) {
    return Text(
      '$label',
      style: TextStyle(fontSize: 16),
    );
  }

}

class ScheduleItem extends StatefulWidget {
  const ScheduleItem({Key key, this.allData}) : super(key: key);
  final ScheduleData allData;

  @override
  State<ScheduleItem> createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  StopWatchTimer _stopWatchTimer;

  void startTimer(int mil) {
    print('checking data time ---- ${mil}');
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: mil,
      mode: StopWatchMode.countDown,
    );

    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          labelWidget(label: 'Your Subscription'),
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                //General Schedule :D
                Row(
                  children: widget.allData.regular
                      .map((e) => yourSubscriptionWidget(
                          theme: ScheduleModel.getData(type: 'is_regular'),
                          item: e,
                          cardLabel: "General Training"))
                      .toList(),
                ),
                Row(
                  children: widget.allData.addonPt
                      .map((e) => yourSubscriptionWidget(
                          theme: ScheduleModel.getData(type: 'is_pt'),
                          item: e,
                          cardLabel: "Personal Training"))
                      .toList(),
                ),
                Row(
                  children: widget.allData.addon
                      .map((e) => yourSubscriptionWidget(
                          theme: ScheduleModel.getData(type: 'is_addon'),
                          item: e,
                          cardLabel: "Addons"))
                      .toList(),
                ),
                Row(
                  children: widget.allData.addonLive
                      .map((e) => yourSubscriptionWidget(
                          theme: ScheduleModel.getData(type: 'is_live'),
                          item: e,
                          cardLabel: "Live Class"))
                      .toList(),
                ),
                Row(
                  children: widget.allData.event
                      .map((e) => yourSubscriptionWidget(
                          theme: ScheduleModel.getData(type: 'is_event'),
                          item: e,
                          cardLabel: "Event"))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget labelWidget({
    @required String label,
  }) {
    return Text(
      '$label',
      style: TextStyle(fontSize: 16),
    );
  }

  int getMiliSecond({DateTime date}) {
    print('check time here ---- $date');
    DateTime subDate = date;
    DateTime now = DateTime.now();
    int sec = subDate.difference(now).inSeconds;
    if (sec < 1) {
      return 0;
    } else {
      return sec * 1000;
    }
  }

  Widget yourSubscriptionWidget(
      {@required MyScheduleAddonData item,
      @required String cardLabel,
      @required ScheduleModel theme}) {
    int time = getMiliSecond(date: item.expireDate);
    print('check time here ---- $time');
    if (time != 0) {
      startTimer(time);
    }

    return InkWell(
      onTap: () {
        NavigationService.pushName(Routes.exercisesScreen);
      },
      child: Container(
        margin: EdgeInsets.only(right: 26),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 11),
              constraints:
                  BoxConstraints(minHeight: 200, minWidth: 140, maxWidth: 140),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 12, right: 12, bottom: 12, top: 20),
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.green,
                        border: Border.all(color: Colors.white, width: 1)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        '$cardLabel',
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.transparent, Colors.white])),
                    child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          '${item.planName}'.toUpperCase(),
                          style: TextStyle(fontSize: 12),
                        )),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'MEMBERSHIP',
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(
                    height: 2,
                  ),
                  if (time != 0)
                    StreamBuilder<int>(
                      stream: _stopWatchTimer.secondTime,
                      initialData: 0,
                      builder: (context, snap) {
                        int value = snap.data;
                        if (value == 0) {
                          return Container();
                        } else {
                          print('check time hhhhh - $value');
                          DateTime now = DateTime.now();
                          DateTime dif =
                              DateTime.now().add(Duration(seconds: value));
                          Duration difference = dif.difference(now);
                          int days = difference.inDays;
                          int hours = difference.inHours % 24;
                          int minutes = (difference.inMinutes % 60);
                          int seconds = difference.inSeconds % 60;

                          return Text(
                            // '${exTimerHelper.convertDay(value)}:${exTimerHelper.convertHour(value)}:${exTimerHelper.convertMin(value)}:${exTimerHelper.convertSec(value)}',
                            '$days:$hours:$minutes:$seconds',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
            Positioned(
              right: -20,
              top: 20,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: AppColors.BACK_GROUND_BG),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.white),
                  child: Text('View Schedule',
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScheduleModel {
  Color firstColor;
  Color secondColor;
  String iconUrl;

  ScheduleModel({this.firstColor, this.iconUrl, this.secondColor});

  static ScheduleModel getData({@required String type}) {
    switch (type) {
      case 'is_pt':
        return ScheduleModel(
            firstColor: Colors.orange, secondColor: Colors.orange, iconUrl: '');
      case 'is_addon':
        return ScheduleModel(
            firstColor: Colors.orange, secondColor: Colors.orange, iconUrl: '');
      case 'is_live':
        return ScheduleModel(
            firstColor: Colors.orange, secondColor: Colors.orange, iconUrl: '');
      case 'is_event':
        return ScheduleModel(
            firstColor: Colors.orange, secondColor: Colors.orange, iconUrl: '');
      default:
        //this is regular :D
        return ScheduleModel(
            firstColor: Colors.orange, secondColor: Colors.orange, iconUrl: '');
    }
  }
}

class RecommendedProgramScreen extends StatefulWidget {
  const RecommendedProgramScreen({Key key}) : super(key: key);

  @override
  State<RecommendedProgramScreen> createState() =>
      _RecommendedProgramScreenState();
}

class _RecommendedProgramScreenState extends State<RecommendedProgramScreen> {
  final double recommendedCircleHeight = 90.00;
  GymStore user;
  bool callMethod = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  void callData() {
    print('called recommended program-----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        user.getRecommendedProgram();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Calling initial Data :D
    callData();

    return Material(
      color: Colors.transparent,
      child: Consumer<GymStore>(builder: (context, store, child) {
        if (store.recommendedProgramModel == null) {
          return Container(
            child: Text('Shimmer'),
          );
        } else {
          if (!store.recommendedProgramModel.status ||
              store.recommendedProgramModel.data.isEmpty) {
            return SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelWidget(label: 'Recommended Program'),
                SizedBox(
                  height: 18,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 0.0,
                  spacing: 12.0,
                  // gap between lines
                  children: store.recommendedProgramModel.data
                      .map((e) => recommendedWidget(
                          label: e.name, imageUrl: '', type: e.type))
                      .toList(),
                ),
              ],
            );
          }
        }
      }),
    );
  }

  Widget labelWidget({
    @required String label,
  }) {
    return Text(
      '$label',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget recommendedWidget(
      {@required String label, @required String imageUrl, @required type}) {
    return InkWell(
      onTap: () => navigateToPage(navKey: type),
      child: Container(
          alignment: Alignment.center,
          width: recommendedCircleHeight,
          margin: EdgeInsets.only(bottom: 22),
          child: Column(
            children: [
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        width: recommendedCircleHeight,
                        height: recommendedCircleHeight,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Colors.white)),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: recommendedCircleHeight - 1.2,
                          height: recommendedCircleHeight - 1.2,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffE00303),
                                    Color(0xff485AFE)
                                  ]))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '$label',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  void navigateToPage({String navKey}) {
    switch (navKey) {
      case 'is_addon':
        if (checkHasSubscription()) {
          NavigationService.pushName(Routes.exercisesScreen);
        } else {

        }
        break;
      case 'is_pt':
        context.read<GymStore>().getActiveSubscriptions(context: context);
        NavigationService.navigateTo(Routes.ptClassPage);
        break;
      default:
        UtilityComponents.showSnackBarWithString(
            'Goal Focus Program Coming Soon!', context);
        break;
    }
  }

  bool checkHasSubscription() {
    if (user.activeSubscriptions == null ||
        !user.activeSubscriptions.status ||
        user.activeSubscriptions.data == null)
      return false;
    else
      return true;
  }
}

class ScheduleTrainerSection extends StatefulWidget {
  const ScheduleTrainerSection({Key key}) : super(key: key);

  @override
  State<ScheduleTrainerSection> createState() => _ScheduleTrainerSectionState();
}

class _ScheduleTrainerSectionState extends State<ScheduleTrainerSection> {
  GymStore user;
  bool callMethod = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  void callData() {
    print('called recommended program-----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        user.getCurrentTrainer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Calling initial Data :D
    callData();

    return Material(
      color: Colors.transparent,
      child: Consumer<GymStore>(builder: (context, store, child) {
        if (store.currentTrainer == null) {
          return Container(
            child: Text('Shimmer'),
          );
        } else {
          if (!store.currentTrainer.status ||
              store.currentTrainer.data == null) {
            return SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelWidget(label: 'Current Trainer'),
                SizedBox(
                  height: 18,
                ),
                //Current Trainer Section :D
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff585858),
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: store.currentTrainer.data
                                                .trainerProfile !=
                                            null &&
                                        store.currentTrainer.data.trainerProfile
                                            .isNotEmpty
                                    ? NetworkImage(
                                        '${store.currentTrainer.data.trainerProfile}')
                                    : AssetImage(
                                        'assets/images/empty_trainer.png'),
                                fit: BoxFit.fitHeight,
                              )),
                          child: Container(
                            height: 208,
                            width: 208,
                            decoration: BoxDecoration(
                              color: Color(0xff585858),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff000000).withOpacity(0),
                                  AppColors.BACK_GROUND_BG,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          // alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 17,
                                      width: 17,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xff940707),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 1),
                                      child: Text(
                                        '${store.currentTrainer.data.isPt == 0 ? 'General' : 'Personal'}',
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              showPTDetailsDialog();
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 7,
                                      width: 7,
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Color(0xffC20000),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    Text(
                                      '${store.currentTrainer.data.trainerName}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.bebasNeue(
                                        color: AppConstants.white,
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      height: 7,
                                      width: 7,
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Color(0xffC20000),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 2,
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  color: Color(0xffC20000),
                                  width: 130,
                                ),
                                // Text(
                                //   'Exp-5 Years ',
                                //   style: GoogleFonts.openSans(
                                //     color: Colors.white,
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                                Container(
                                  height: 28,
                                  width: 88,
                                  margin: EdgeInsets.only(top: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(42),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'View details',
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        }
      }),
    );
  }

  Widget labelWidget({
    @required String label,
  }) {
    return Text(
      '$label',
      style: TextStyle(fontSize: 16),
    );
  }

  void showPTDetailsDialog() {
  }
}
