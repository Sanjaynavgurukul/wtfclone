import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/screen/schedule/arguments/main_workout_argument.dart';

class MainWorkout extends StatefulWidget {
  static const routeName = '/mainWorkout';

  const MainWorkout({Key key}) : super(key: key);

  @override
  _MainWorkoutState createState() => _MainWorkoutState();
}

class _MainWorkoutState extends State<MainWorkout> {
  GymStore user;
  bool trainerCalled = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }


  void callTrainer() {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (trainerCalled) {
        // this.trainerCalled = false;
        // user.getScheduleData(
        //     date: Helper.formatDate2(_selectedDay.toIso8601String()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MainWorkoutArgument args =
    ModalRoute.of(context).settings.arguments as MainWorkoutArgument;

    return Consumer<GymStore>(
      builder: (context, store, child){
        return DefaultTabController(
          length: 0,
          child: new Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                'Completed',
                style: TextStyle(fontSize: 16),
              ),
              icon: Icon(Icons.add),
            ),
            body: new NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    new SliverAppBar(
                        title: Text(args.workoutType??'No Name'),
                        forceElevated: innerBoxIsScrolled,
                        pinned: true,
                        floating: true,
                        bottom: PreferredSize(
                            preferredSize: Size(double.infinity, 100),
                            child: Padding(
                                child: ListTile(
                                  title: Text('Current Trainer'),
                                  subtitle: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text('Some Text'),
                                      Text('Some Text'),
                                      Text('Some Text'),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                  leading: Wrap(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color: Colors.grey),
                                        width: 60,
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                  trailing: Image.asset(
                                    'assets/images/certified.png',
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                    left: 12, right: 12, top: 0, bottom: 8))),
                        backgroundColor: AppColors.BACK_GROUND_BG),
                  ];
                },
                body: ListView.builder(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 70),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        color: Colors.red,
                        height: 100,
                        width: double.infinity,
                      );
                    })),
          ),
        );
      },
    );
    return DefaultTabController(
      length: 0,
      child: new Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            'Completed',
            style: TextStyle(fontSize: 16),
          ),
          icon: Icon(Icons.add),
        ),
        body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                    title: const Text('General Training'),
                    forceElevated: innerBoxIsScrolled,
                    pinned: true,
                    floating: true,
                    bottom: PreferredSize(
                        preferredSize: Size(double.infinity, 100),
                        child: Padding(
                            child: ListTile(
                              title: Text('Current Trainer'),
                              subtitle: Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('Some Text'),
                                  Text('Some Text'),
                                  Text('Some Text'),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              leading: Wrap(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors.grey),
                                    width: 60,
                                    height: 60,
                                  ),
                                ],
                              ),
                              trailing: Image.asset(
                                'assets/images/certified.png',
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 0, bottom: 8))),
                    backgroundColor: AppColors.BACK_GROUND_BG),
              ];
            },
            body: ListView.builder(
                padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 70),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    color: Colors.red,
                    height: 100,
                    width: double.infinity,
                  );
                })),
      ),
    );
  }
}
