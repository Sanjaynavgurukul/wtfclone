import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/screen/stopwatch.dart';
import 'package:wtf/widget/custom_button.dart';

import '../../../../../main.dart';
import '../exercise_video.dart';
import 'exercise_result.dart';
import 'exercise_start_info.dart';

class ExerciseStart extends StatefulWidget {
  const ExerciseStart({
    Key key,
    this.startVideo,
    this.data,
    this.execiseIndex,
  }) : super(key: key);
  final startVideo;
  final Exercise data;
  final int execiseIndex;

  @override
  _ExerciseStartState createState() => _ExerciseStartState(this.data);
}

class _ExerciseStartState extends State<ExerciseStart> {
  int m = 0, s = 0, h = 0;
  Timer timer;
  VideoPlayerController _controller;
  StopwatchDependencies localTimer;
  bool timePaused = false;

  Exercise data;

  _ExerciseStartState(this.data);

  @override
  void initState() {
    super.initState();
    localTimer = StopwatchDependencies();
    print('video:: ${context.read<GymStore>().workoutDetails.data.video}');
    _controller = VideoPlayerController.network(
      context.read<GymStore>().workoutDetails.data.video,
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) {
        _controller.play();
        _controller.addListener(() {});
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (mounted) setState(() {});
      });
    localTimer.stopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  void pauseTimers() {
    localTimer.stopwatch.stop();
    setState(() {
      timePaused = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (localTimer.stopwatch.elapsed.inMinutes % 60)
        .toString()
        .padLeft(2, '0');
    String secondsStr = (localTimer.stopwatch.elapsed.inSeconds % 60)
        .toString()
        .padLeft(2, '0');
    return WillPopScope(
      onWillPop: () async {
        if (localTimer != null && localTimer.stopwatch.isRunning) {
          FlashHelper.informationBar(context,
              message: 'Please complete Exercise first.');
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Material(
            elevation: 12.0,
            child: IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 20.0,
                  left: 16.0,
                  right: 16.0,
                  top: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExerciseStartInfo(),
                    SizedBox(
                      height: 15,
                    ),
                    // ExerciseCard(),
                    ExerciseResult(
                      // h: h,
                      m: minutesStr,
                      s: secondsStr,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                      onTap: () async {
                        print('tapped Exercise action');
                        try {
                          if (timePaused) {
                            localTimer.stopwatch.start();
                            setState(() {
                              timePaused = false;
                            });
                          } else {
                            if (int.tryParse(data.sets) > data.setsCompleted) {
                              data.setsCompleted++;
                              if (data.setData == null) {
                                data.setData = [
                                  localTimer.stopwatch.elapsed.inSeconds,
                                ];
                              } else {
                                data.setData.add(
                                  localTimer.stopwatch.elapsed.inSeconds,
                                );
                              }
                              WorkoutScheduleData da = locator<AppPrefs>()
                                  .activeScheduleData
                                  .getValue();
                              int index = da.exercises.indexWhere(
                                  (element) => element.woName == data.woName);
                              print(
                                  'fetching exercise for index $index  & ex len: ${da.exercises.length}-----------');
                              da.exercises.remove(index);
                              List<Exercise> newList = [];
                              for (int i = 0; i < da.exercises.length; i++) {
                                if (da.exercises[i].woName != data.woName) {
                                  newList.add(da.exercises[i]);
                                }
                              }
                              newList.add(data);
                              da.exercises.clear();
                              print(
                                  'fetching exercise for index $index  & ex len2: ${da.exercises.length}-----------');
                              da.exercises.addAll(newList);
                              print(
                                  'fetching exercise for index $index  & ex len3: ${da.exercises.length}-----------');
                              await locator<AppPrefs>()
                                  .activeScheduleData
                                  .clear();
                              context
                                  .read<GymStore>()
                                  .setSchedule(schedule: da);
                              locator<AppPrefs>()
                                  .activeScheduleData
                                  .setValue(da);

                              if (widget.data.setsCompleted ==
                                  int.tryParse(widget.data.sets)) {
                                data.isCompleted = true;
                                int duration = 0;
                                print(
                                    'seconds list: ${data.setData.map((e) => e).toList()}');
                                // for (int i = 0; i < data.setData.length; i++) {
                                //   duration += data.setData[i];
                                // }
                                print(
                                    'TOTAL WORKOUT DURATION:  ${Helper.printDuration(
                                  Duration(
                                      seconds: localTimer
                                          .stopwatch.elapsed.inSeconds),
                                )}');
                                context.read<GymStore>().updateTime(
                                      time: Helper.printDuration(
                                        Duration(
                                            seconds: localTimer
                                                .stopwatch.elapsed.inSeconds),
                                      ),
                                    );
                                NavigationService.goBack;
                              } else {
                                pauseTimers();
                              }
                            }
                          }
                        } catch (e) {
                          log('exercise save error: $e');
                        }
                      },
                      text: timePaused
                          ? 'Resume'
                          : 'End set ${widget.data.setsCompleted + 1} of ${widget.data.sets}',
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      bgColor: AppConstants.primaryColor,
                      textColor: Colors.white,
                      radius: 12.0,
                    ),
                    // style: ElevatedButton.styleFrom(
                    //   primary: AppConstants.primaryColor,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 80,
                    //     vertical: 15,
                    //   ),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(25),
                    //   ),
                    // ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // ExerciseStartButtons(),
                SizedBox(
                  height: 15,
                ),
                ExerciseVideo(
                  controller: _controller,
                  onPausePlay: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                UIHelper.verticalSpace(30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: Html(
                    data: widget.data.description ?? ' - - -',
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
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
