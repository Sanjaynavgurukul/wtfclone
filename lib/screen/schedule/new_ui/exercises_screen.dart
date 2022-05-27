import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/model/new_schedule_model.dart';
import 'package:wtf/widget/progress_loader.dart';

class ExercisesScreen extends StatefulWidget {
  static const String routeName = '/exercisesScreen';

  const ExercisesScreen({Key key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  double recommendedCircleHeight = 80.00;

  static const double EMPTY_SPACE = 10.0;
  ScrollController _scrollController;
  bool isScrolledToTop = true;
  bool callMethod = true;
  GymStore user;

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
        user.getNewScheduleData();
      }
    });
  }

  void onRefreshPage() {
    this.callMethod = true;
    user.getNewScheduleData();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      //call setState only when values are about to change
      if (!isScrolledToTop) {
        setState(() {
          //reach the top
          isScrolledToTop = true;
        });
      }
    } else {
      //call setState only when values are about to change
      if (_scrollController.offset > EMPTY_SPACE && isScrolledToTop) {
        setState(() {
          //not the top
          isScrolledToTop = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Calling data
    callData();

    return Consumer<GymStore>(builder: (context, user, snapshot) {
      if (user.newScheduleModel == null)
        return Material(
          child: Center(
            child: Loading(),
          ),
        );
      else {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: isScrolledToTop ? 0 : 4,
              backgroundColor: isScrolledToTop
                  ? Colors.transparent
                  : AppColors.BACK_GROUND_BG,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text('Exercise'),
            ),
            body: Container(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.grey,
                                  Colors.transparent,
                                ])),
                          ),
                          Positioned(
                            right: 0,
                            child: SafeArea(
                              child: Container(
                                constraints: BoxConstraints(minWidth: 100),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomLeft: Radius.circular(100))),
                                child: Text('19:00:00',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.white,
                      selectedTextColor: Colors.black,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: AppConstants.bgColor),
                      child: Text(
                        'Start Workout',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          'Today\'s Schedule',
                          style: TextStyle(fontSize: 18),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    user.newScheduleModel.newScheduleCat == null ||
                            user.newScheduleModel.newScheduleCat.isEmpty
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(left: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(right: 16),
                              child: Row(
                                children: user.newScheduleModel.newScheduleCat
                                    .map((e) => scheduleExerciseItem(e))
                                    .toList(),
                              ),
                            ),
                          ),
                    Container(
                      child: Column(
                        children: user.newScheduleModel.newScheduleData
                            .map((e) => itemA(e))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }
    });
  }

  Widget scheduleExerciseItem(NewScheduleCat item) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              width: recommendedCircleHeight,
              height: recommendedCircleHeight,
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE00303), Color(0xff485AFE)])),
              child: Container(
                  margin: EdgeInsets.all(2), child: networkImage(item.image))),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(top: 2, bottom: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE00303), Color(0xff485AFE)]),
                  border:
                      Border.all(width: 3, color: AppColors.BACK_GROUND_BG)),
              child: Text('${item.name}'),
            ),
          )
        ],
      ),
    );
  }

  Widget networkImage(String imageUrl, {double radius = 100}) {
    print('chech image url ---2 $imageUrl');
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: Colors.grey.shade200),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius), // Image border
        child: Image.network(
          '$imageUrl',
          fit: BoxFit.fill,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(100), // Image border
              child: Image.network(
                  'https://advancepetproduct.com/wp-content/uploads/2019/04/no-image.png',
                  fit: BoxFit.fill),
            );
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemA(NewScheduleData item) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //     padding: EdgeInsets.only(left: 26),
          //     child: Text('Set',
          //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Column(
              children:
                  item.exercises.map((e) => itemCardXyz(item: e)).toList())
        ]);
  }

  Widget itemCardXyz({NewScheduleDataExercises item}) {
    return Column(children: [
      Text('Set ${item.set_no}'),
      Column(
        children: item.exercises.map((e) => itemCard(item: e)).toList(),
      )
    ]);
  }

  Widget itemCard({bool selected = false, NewScheduleDataExercisesData item}) {
    print('chech image url --- ${item}');
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 18),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(
              width: selected ? 1 : 0,
              color: !selected ? Colors.transparent : Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.green,
              ),
              height: 80,
              child: networkImage(item.category_image, radius: 8),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Text('4/4'),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                  ),
                  ListTile(
                    contentPadding:
                        EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    title: Text('Skull Candy'),
                    trailing: Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text("Resume"),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('Set : 4'), Text('Reps : 12,14,15,16')],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
