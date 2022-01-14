import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/main.dart';
import 'package:wtf/screen/test.dart';

class JitsiMeeting extends StatefulWidget {
  final String meetingSubject;
  final String meetingRoomId;

  JitsiMeeting({this.meetingSubject, this.meetingRoomId});

  @override
  _JitsiMeetingState createState() => _JitsiMeetingState();
}

class _JitsiMeetingState extends State<JitsiMeeting> {
  bool isAudioOnly = true;
  bool isAudioMuted = true;
  GymStore gymStore;
  bool isVideoMuted = true;
  Dependencies localTimer;

  @override
  void initState() {
    super.initState();
    localTimer = Dependencies();

    _joinMyMeeting();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMyMeeting() async {
    String serverUrl = 'www.wtfup.me/';

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
      // FeatureFlagEnum.KICK_OUT_ENABLED: true,
      // FeatureFlagEnum.HELP_BUTTON_ENABLED: false,
      FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
      FeatureFlagEnum.INVITE_ENABLED: false,
      // FeatureFlagEnum.VIDEO_MUTE_BUTTON_ENABLED: false,
      // FeatureFlagEnum.AUDIO_MUTE_BUTTON_ENABLED: false,

      /*FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
      FeatureFlagEnum.LOBBY_MODE_ENABLED: false,
      FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
      FeatureFlagEnum.CALENDAR_ENABLED: false*/
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)

        featureFlags[FeatureFlagEnum.RECORDING_ENABLED] = false;
        // featureFlags[FeatureFlagEnum.ANROID_SCREENSHARING_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
        featureFlags[FeatureFlagEnum.IOS_RECORDING_ENABLED] = false;
        // featureFlags[FeatureFlagEnum.IOS_SCREENSHARING_ENABLED] = false;
      }
    }
    // Define MyMeetings options here
    var options = JitsiMeetingOptions(room: widget.meetingRoomId)
      // ..serverURL = serverUrl
      ..subject = widget.meetingSubject
      ..userDisplayName = locator<AppPrefs>().userName.getValue()
      ..userEmail = locator<AppPrefs>().userEmail.getValue()
      ..iosAppBarRGBAColor = '#0080FF80'
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": widget.meetingRoomId,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": locator<AppPrefs>().userName.getValue()}
      };

    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (message) async {
          debugPrint("${options.room} will join with message: $message");
        },
        onConferenceJoined: (message) {
          localTimer.stopwatch.start();
          debugPrint("${options.room} joined with message: $message");
        },
        onConferenceTerminated: (message) {
          debugPrint("${options.room} terminated with message: $message");
          localTimer.stopwatch.stop();
          Navigator.pop(context);
          log('elapsed--->> ${Helper.getDuration(localTimer.stopwatch.elapsed)}');
          context.read<GymStore>().completeLiveSession(
                context: context,
                eDuration: Helper.getDuration(localTimer.stopwatch.elapsed),
              );
        },
        genericListeners: [
          JitsiGenericListener(
            eventName: 'readyToClose',
            callback: (dynamic message) {
              debugPrint("readyToClose callback ${message}");
            },
          ),
        ],
      ),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(String message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
