//Package imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';

//Project imports
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:wtf/100ms/common/ui/organisms/role_change_request_dialog.dart';
import 'package:wtf/100ms/common/ui/organisms/track_change_request_dialog.dart';
import 'package:wtf/100ms/meeting/meeting_store.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/screen/schedule/timer_helper/exercise_timer_helper.dart';

class UtilityComponents {
  static void showSnackBarWithString(event, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        event,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black87,
    ));
  }

  static Future<dynamic> onBackPressed({BuildContext context,bool warningDialog = true}) async {
    MeetingStore _meetingStore = context.read<MeetingStore>();
    GymStore _trainerStore = context.read<GymStore>();
    if(!warningDialog){
      print('else condition called ---');
      String time = exTimerHelper.getLiveClassDuration();
      await _trainerStore.completeLiveSession(context: context,eDuration: time).then((value){
        if(value){
          print('else condition called --- trainer added');
          locator<AppPrefs>().liveClassTimerDate.setValue(0);
          _meetingStore.leave();
          Navigator.pushNamedAndRemoveUntil(context, Routes.exerciseDone, (route) => route.isFirst);
        }else{
          print('else condition called --- trainer added something went wrong');
          locator<AppPrefs>().liveClassTimerDate.setValue(0);
          _meetingStore.leave();
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      });
    }else{
      return  showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Alert'),
              content: Text('Do you really want to end this class?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () async{
                      String time = exTimerHelper.getLiveClassDuration();
                      await _trainerStore.completeLiveSession(context: context,eDuration: time).then((value){
                        if(value){
                          locator<AppPrefs>().liveClassTimerDate.setValue(0);
                          _meetingStore.leave();
                          Navigator.pushNamedAndRemoveUntil(context, Routes.exerciseDone, (route) => route.isFirst);

                        }else{
                          locator<AppPrefs>().liveClassTimerDate.setValue(0);
                          _meetingStore.leave();
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }
                      });
                    },
                    child: Text('Yes',style: TextStyle(color: Colors.grey),)),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context); //close Dialog
                    },
                    child: Text('Cancel',style: TextStyle(color: Colors.white),)),

              ],
            );
          });
    }

    // return showDialog(
    //   context: context,
    //   builder: (ctx) => AlertDialog(
    //     title: Text(
    //       'Leave Room?',
    //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    //     ),
    //     actions: [
    //       ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //             primary: Colors.red,
    //           ),
    //           onPressed: () async{
    //             String time = exTimerHelper.getLiveClassDuration();
    //             await _trainerStore.completeLiveSession(context: context,eDuration: time).then((value){
    //               if(value){
    //                 locator<AppPrefs>().liveClassTimerDate.setValue(0);
    //                 _meetingStore.leave();
    //                 Navigator.pushNamedAndRemoveUntil(context, Routes.exerciseDone, (route) => route.isFirst);
    //
    //               }else{
    //                 _meetingStore.leave();
    //                 Navigator.popUntil(context, (route) => route.isFirst);
    //               }
    //             });
    //           },
    //           child: Text('Yes', style: TextStyle(fontSize: 24))),
    //       ElevatedButton(
    //         onPressed: () => Navigator.pop(context, false),
    //         child: Text(
    //           'Cancel',
    //           style: TextStyle(fontSize: 24),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  static void showRoleChangeDialog(HMSRoleChangeRequest event, context) async {
    event = event as HMSRoleChangeRequest;
    String answer = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => RoleChangeDialogOrganism(roleChangeRequest: event));
    MeetingStore meetingStore =
        Provider.of<MeetingStore>(context, listen: false);
    if (answer == "OK") {
      meetingStore.acceptChangeRole(event);
      UtilityComponents.showSnackBarWithString(
          "Role Change to " + event.suggestedRole.name, context);
    } else {
      meetingStore.roleChangeRequest = null;
    }
  }

  static showTrackChangeDialog(event, context) async {
    event = event as HMSTrackChangeRequest;
    String answer = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => TrackChangeDialogOrganism(trackChangeRequest: event));
    MeetingStore meetingStore =
        Provider.of<MeetingStore>(context, listen: false);
    if (answer == "OK") {
      meetingStore.changeTracks(event);
    } else {
      meetingStore.hmsTrackChangeRequest = null;
    }
  }

  static showonExceptionDialog(event, context) {
    event = event as HMSException;
    var message =
        "${event.message} ${event.id ?? ""} ${event.code?.errorCode ?? ""} ${event.description} ${event.action} ${event.params ?? "".toString()}";
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static Future<String> showInputDialog(
      {context, String placeholder = "", String prefilledValue = ""}) async {
    TextEditingController textController = TextEditingController();
    if (prefilledValue.isNotEmpty) {
      textController.text = prefilledValue;
    }
    String answer = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      controller: textController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: placeholder),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, '');
                  },
                ),
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    if (textController.text == "") {
                    } else {
                      Navigator.pop(context, textController.text);
                    }
                  },
                ),
              ],
            ));

    return answer;
  }

  static Future<List<HMSRole>> showRoleList(
      BuildContext context, List<HMSRole> roles) async {
    List<HMSRole> _selectedRoles = [];
    FixedExtentScrollController _scrollController =
        FixedExtentScrollController();

    HMSRole selectedRole = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                  height: 100,
                  child: ClickableListWheelScrollView(
                      scrollController: _scrollController,
                      itemHeight: 50,
                      itemCount: roles.length,
                      onItemTapCallback: (index) {
                        Navigator.pop(context, roles[index]);
                      },
                      child: ListWheelScrollView.useDelegate(
                          controller: _scrollController,
                          physics: FixedExtentScrollPhysics(),
                          overAndUnderCenterOpacity: 0.5,
                          perspective: 0.002,
                          itemExtent: 50,
                          childDelegate: ListWheelChildBuilderDelegate(
                              childCount: roles.length,
                              builder: (context, index) {
                                return Container(
                                  height: 50,
                                  child: ListTile(
                                    title: Text(roles[index].name),
                                  ),
                                );
                              })))),
            ));
    if (selectedRole != null) _selectedRoles.add(selectedRole);
    return _selectedRoles;
  }
}
