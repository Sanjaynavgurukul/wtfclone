import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/screen/exercise/exercise_start/exercise_start.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/gradient_image_widget.dart';

import '../../main.dart';
import 'exersise_top_bar.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({Key key}) : super(key: key);

  @override
  _ExerciseDetailsState createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    print(
        'selected exercise length: ${store.selectedWorkoutSchedule.exercises.map((e) => e.isCompleted || (e.eDuration != null && e.eDuration.isNotEmpty)).toList()[0]}');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff080904),
        bottomNavigationBar: store.selectedWorkoutSchedule.exercises
                .map((e) =>
                    e.isCompleted ||
                    (e.eDuration != null && e.eDuration.isNotEmpty))
                .toList()
                .isNotEmpty
            ? CustomButton(
                onTap: () async {
                  List<Exercise> temp = locator<AppPrefs>()
                      .activeScheduleData
                      .getValue()
                      .exercises;
                  if (temp.length ==
                      temp.map((e) => e.isCompleted).toList().length) {
                    NavigationService.goBack;
                  } else {
                    FlashHelper.informationBar(context,
                        message: 'Please complete all exercise first.');
                  }
                },
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                text:
                    'End ${store.selectedWorkoutSchedule.category ?? ''} Exercise',
                bgColor: AppConstants.primaryColor,
                textColor: Colors.white,
                radius: 12.0,
                height: 40.0,
              )
            : Container(
                height: 0.0,
                width: 0.0,
              ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ExerciseTopBar(),
              Container(
                height: 220.0,
                child: GradientImageWidget(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  gragientColor: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    // AppColors.PRIMARY_COLOR,
                  ],
                  stops: [0.0, 0.8, 1.0],
                  network:
                      'https://www.mensjournal.com/wp-content/uploads/2018/05/1380-dumbbell-curl1.jpg?quality=86&strip=all',
                ),
              ),
              // UIHelper.verticalSpace(8.0),
              // ExerciseInfo(),
              UIHelper.verticalSpace(12.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 6.0,
                ),
                child: Text(
                  'Today\'s ${context.read<GymStore>().selectedWorkoutSchedule.category.capitalize()} Workout :',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.0),
              Flexible(
                child: PreferenceBuilder<WorkoutScheduleData>(
                    preference: locator<AppPrefs>().activeScheduleData,
                    builder: (context, schedule) {
                      print(
                          'exercise length:---- ${schedule.exercises.length}');
                      return schedule != null
                          ? Wrap(
                              children: schedule.exercises
                                  .map(
                                    (e) => ExerciseCard(data: e),
                                  )
                                  .toList(),
                            )
                          : Text(
                              'Exercise not found',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    store.selectedWorkoutSchedule = null;
    super.dispose();
  }
}

class ExerciseCard extends StatefulWidget {
  final Exercise data;
  const ExerciseCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  GymStore store;
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return InkWell(
      onTap: () => widget.data.setData == null ||
              widget.data.setsCompleted < int.tryParse(widget.data.sets)
          ? _modalBottomSheetMenu(
              context,
              locator<AppPrefs>()
                  .activeScheduleData
                  .getValue()
                  .exercises
                  .indexOf(widget.data),
            )
          : () {
              FlashHelper.informationBar(context,
                  message: 'Exercise already completed.');
            },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      widget.data.woName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(6.0),
                  Container(
                    height: 24.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Reps: ${widget.data.reps}' ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14.0,
                          ),
                        ),
                        UIHelper.horizontalSpace(8.0),
                        Text(
                          'Sets: ${widget.data.sets}' ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.play_arrow,
                  //     color: Colors.white,
                  //     size: 36.0,
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: widget.data.setsCompleted ==
                                    int.tryParse(widget.data.sets) ||
                                (widget.data.eDuration != null &&
                                    widget.data.eDuration.isNotEmpty)
                            ? AppConstants.primaryColor
                            : Colors.white,
                      ),
                      color: widget.data.setsCompleted ==
                                  int.tryParse(widget.data.sets) ||
                              (widget.data.eDuration != null &&
                                  widget.data.eDuration.isNotEmpty)
                          ? AppConstants.primaryColor
                          : Colors.transparent,
                    ),
                    child: PreferenceBuilder<WorkoutScheduleData>(
                      preference: locator<AppPrefs>().activeScheduleData,
                      builder: (context, snapshot) {
                        print('text refreshed----------------');
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.data.setsCompleted ==
                                      int.tryParse(widget.data.sets) ||
                                  (widget.data.eDuration != null &&
                                      widget.data.eDuration.isNotEmpty))
                                Text(
                                  'Time Elapsed',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 10.0,
                                  ),
                                ),
                              UIHelper.verticalSpace(6.0),
                              Flexible(
                                child: Text(
                                  getText(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              if (widget.data.setsCompleted !=
                                      int.tryParse(widget.data.sets) ||
                                  (widget.data.eDuration != null &&
                                      widget.data.eDuration.isNotEmpty))
                                UIHelper.verticalSpace(6.0),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getText() {
    String text = '';
    if (widget.data.setData == null || widget.data.setData.isEmpty) {
      if (widget.data.eDuration != null && widget.data.eDuration.isNotEmpty) {
        text = widget.data.eDuration;
      } else {
        text = 'Start Now';
      }
    } else {
      if (widget.data.setsCompleted < int.tryParse(widget.data.sets)) {
        text = '${widget.data.setsCompleted} of ${widget.data.sets}';
      } else if (widget.data.setData.length == int.tryParse(widget.data.sets)) {
        int duration = 0;
        for (int i = 0; i < widget.data.setData.length; i++) {
          duration = widget.data.setData[i];
        }
        text = '${Helper.formattedTime(duration)}\n';
      }
    }

    return text;
  }

  void _modalBottomSheetMenu(
    context,
    int index,
  ) async {
    // _controller.pause();
    await store.setExercise(widget.data);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseStart(
          data: widget.data,
        ),
      ),
    );
    // await showModalBottomSheet(
    //   enableDrag: true,
    //   backgroundColor: Colors.black,
    //   isDismissible: false,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (builder) {
    //     return new Container(
    //       height: Get.height - (kToolbarHeight),
    //       decoration: new BoxDecoration(
    //         color: Colors.transparent,
    //         borderRadius: new BorderRadius.only(
    //           topLeft: const Radius.circular(10.0),
    //           topRight: const Radius.circular(10.0),
    //         ),
    //       ),
    //       child: ExerciseStart(
    //         startVideo: () {
    //           // setState(() {
    //           //   _controller.play();
    //           // });
    //         },
    //         // execiseIndex: index,
    //         data: widget.data,
    //       ),
    //     );
    //   },
    // );
    setState(() {});
  }
}
