//Package imports
import 'dart:io';
import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wtf/100ms/common/ui/organisms/grid_video_view.dart';

//Project imports
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:wtf/100ms/common/constant.dart';
import 'package:wtf/100ms/common/ui/organisms/chat_bottom_sheet.dart';
import 'package:wtf/100ms/common/ui/organisms/offline_screen.dart';
import 'package:wtf/100ms/common/util/utility_components.dart';
import 'package:wtf/100ms/meeting/meeting_store.dart';
import 'package:wtf/100ms/meeting/peer_track_node.dart';
import 'package:provider/provider.dart';

// ignore: implementation_imports
import 'package:tuple/tuple.dart';
import 'package:wtf/helper/colors.dart';
import 'meeting_participants_list.dart';

class MeetingPage extends StatefulWidget {
  final bool isAudioOn;
  final bool isVideoOn;
  final String token;
  final int localPeerNetworkQuality;

  const MeetingPage(
      {Key key,
      @required this.token,
      @required this.isAudioOn,
      @required this.isVideoOn,
      this.localPeerNetworkQuality})
      : super(key: key);

  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  int appBarIndex = 0;
  bool audioViewOn = false;
  bool videoPreviousState = false;
  bool isRecordingStarted = false;
  bool isBRB = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initMeeting();
    setNetworkQuality();
  }

  void initMeeting() async {
    bool ans = await context.read<MeetingStore>().join(token: widget.token,mute: widget.isAudioOn,isVideo: widget.isVideoOn);
    if (!ans) {
      UtilityComponents.showSnackBarWithString("Unable to Join", context);
      Navigator.of(context).pop();
    }
    context.read<MeetingStore>().addUpdateListener();
  }

  void setNetworkQuality() async {
    context.read<MeetingStore>().localPeerNetworkQuality =
        widget.localPeerNetworkQuality;
  }

  void handleMenu(int value) async {
    final _meetingStore = context.read<MeetingStore>();
    switch (value) {
      // case 1:
      //   // StaticLogger.logger?.d(
      //   //     "\n----------------------------Sending Logs-----------------\n");
      //   // StaticLogger.logger?.close();
      //   // ShareExtend.share(CustomLogger.file?.path ?? '', 'file');
      //   // logger.getCustomLogger();
      //   UtilityComponents.showSnackBarWithString("Coming Soon...", context);
      //   break;

      // case 2:
      //   if (_meetingStore.isRecordingStarted) {
      //     _meetingStore.stopRtmpAndRecording();
      //     isRecordingStarted = false;
      //   } else {
      //     if (isRecordingStarted == false) {
      //       String url = await UtilityComponents.showInputDialog(
      //           context: context,
      //           placeholder: "Enter RTMP Url",
      //           prefilledValue: Constant.rtmpUrl);
      //       if (url.isNotEmpty) {
      //         _meetingStore.startRtmpOrRecording(
      //             meetingUrl: url, toRecord: true, rtmpUrls: null);
      //         isRecordingStarted = true;
      //       }
      //     }
      //   }
      //   break;

      // case 3:
      //   if (_meetingStore.isVideoOn) _meetingStore.switchCamera();
      //
      //   break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
                value: context.read<MeetingStore>(), child: ParticipantsList()),
          ),
        );
        break;
      // case 5:
      //   // audioViewOn = !audioViewOn;
      //   // if (audioViewOn) {
      //   //   countOfVideoOnBetweenTwo = 0;
      //   //   _meetingStore.trackStatus.forEach((key, value) {
      //   //     _meetingStore.trackStatus[key] = HMSTrackUpdate.trackMuted;
      //   //   });
      //   //   videoPreviousState = _meetingStore.isVideoOn;
      //   //   _meetingStore.isVideoOn = false;
      //   //   _meetingStore.setPlayBackAllowed(false);
      //   // } else {
      //   //   _meetingStore.peerTracks.forEach((element) {
      //   //     _meetingStore.trackStatus[element.peerId] =
      //   //         element.track?.isMute ?? false
      //   //             ? HMSTrackUpdate.trackMuted
      //   //             : HMSTrackUpdate.trackUnMuted;
      //   //   });
      //   //   _meetingStore.setPlayBackAllowed(true);
      //   //   if (countOfVideoOnBetweenTwo == 0) {
      //   //     _meetingStore.isVideoOn = videoPreviousState;
      //   //   } else
      //   //     _meetingStore.isVideoOn =
      //   //         !(_meetingStore.localTrack?.isMute ?? true);
      //   // }
      //   // setState(() {});
      //   UtilityComponents.showSnackBarWithString("Coming Soon...", context);
      //   break;
      // case 6:
      //   // if (!_meetingStore.isActiveSpeakerMode) {
      //   //   _meetingStore.setActiveSpeakerList();
      //   //   _meetingStore.isActiveSpeakerMode = true;
      //   //   UtilityComponents.showSnackBarWithString(
      //   //       "Active Speaker Mode", context);
      //   // } else {
      //   //   _meetingStore.activeSpeakerPeerTrackNodeList.clear();
      //   //   _meetingStore.isActiveSpeakerMode = false;
      //   // }
      //   UtilityComponents.showSnackBarWithString("Coming Soon...", context);
      //   break;
      // case 7:
      //   // if (_meetingStore.isActiveSpeakerMode) {
      //   //   _meetingStore.isActiveSpeakerMode = false;
      //   //   setState(() {});
      //   //   UtilityComponents.showSnackBarWithString(
      //   //       "Switched to Hero Mode", context);
      //   // }
      //   UtilityComponents.showSnackBarWithString("Coming Soon...", context);
      //   break;
      case 8:
        String name = await UtilityComponents.showInputDialog(
            context: context, placeholder: "Enter Name");
        if (name.isNotEmpty) {
          _meetingStore.changeName(name: name);
        }
        break;
      // case 9:
      //   if (_meetingStore.hasHlsStarted) {
      //     _meetingStore.stopHLSStreaming();
      //   } else {
      //     String url = await UtilityComponents.showInputDialog(
      //         context: context,
      //         placeholder: "Enter HLS Url",
      //         prefilledValue: Constant.rtmpUrl);
      //     if (url.isNotEmpty) {
      //       _meetingStore.startHLSStreaming(url);
      //     }
      //   }
      //   break;

      case 10:
        List<HMSRole> roles = await _meetingStore.getRoles();
        List<HMSRole> selectedRoles =
            await UtilityComponents.showRoleList(context, roles);
        if (selectedRoles.isNotEmpty)
          _meetingStore.changeTrackStateForRole(true, selectedRoles);
        break;
      case 11:
        _meetingStore.changeTrackStateForRole(true, null);
        break;
      case 12:
        _meetingStore.changeMetadataBRB();
        // raisedHand = false;
        isBRB = !isBRB;
        break;
      // case 13:
      //   _meetingStore.endRoom(false, "Room Ended From Flutter");
      //   if (_meetingStore.isRoomEnded) {
      //     Navigator.pop(context);
      //   }
      //   break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ConnectivityAppWrapper(
        app: WillPopScope(
      onWillPop: () async {
        bool ans = await UtilityComponents.onBackPressed(
                context: context, warningDialog: true) ??
            false;
        return ans;
      },
      child: ConnectivityWidgetWrapper(
          disableInteraction: true,
          offlineWidget: OfflineWidget(),
          child: Selector<MeetingStore, Tuple2<bool, bool>>(
            selector: (_, meetingStore) =>
                Tuple2(meetingStore.reconnecting, meetingStore.isRoomEnded),
            builder: (_, data, __) {
              //This Condition hit when room ended :D
              if (data.item2) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  UtilityComponents.onBackPressed(
                      context: context, warningDialog: false);
                  UtilityComponents.showSnackBarWithString(
                      'Class Ended', context);
                });
              }
              //This Condition hit when room not ended
              return data.item1
                  ? OfflineWidget()
                  : Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        title: Text(Constant.meetingCode),
                        backgroundColor: AppColors.BACK_GROUND_BG,
                        actions: [
                          Selector<MeetingStore, bool>(
                            selector: (_, meetingStore) =>
                                meetingStore.isRecordingStarted,
                            builder: (_, isRecordingStarted, __) {
                              return isRecordingStarted
                                  ? Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.red.shade600)),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                          IconButton(
                              iconSize: 24,
                              onPressed: () {
                                context.read<MeetingStore>().toggleSpeaker();
                              },
                              icon: Selector<MeetingStore, bool>(
                                selector: (_, meetingStore) =>
                                    meetingStore.isSpeakerOn,
                                builder: (_, isSpeakerOn, __) {
                                  return Icon(isSpeakerOn
                                      ? Icons.volume_up
                                      : Icons.volume_off);
                                },
                              )),
                          dropDownMenu(),
                        ],
                      ),
                      body: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.78,
                            child: Selector<MeetingStore,
                                    Tuple3<List<PeerTrackNode>, int, int>>(
                                selector: (_, meetingStore) => Tuple3(
                                    meetingStore.peerTracks,
                                    meetingStore.peerTracks.length,
                                    meetingStore.screenShareCount),
                                builder: (_, data, __) {
                                  return data.item2 == 0
                                      ? Center(
                                          child: Text(
                                              'Waiting for others to join!'))
                                      : PageView(
                                          physics: PageScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          children: gridVideoView(
                                              peerTracks: data.item1,
                                              audioViewOn: audioViewOn,
                                              itemCount: data.item2,
                                              screenShareOn: data.item3,
                                              size: size));
                                  // : Selector<MeetingStore, bool>(
                                  //     selector: (_, meetingStore) =>
                                  //         meetingStore.hasHlsStarted,
                                  //     builder: (_, hasHlsStarted, __) {
                                  //       return hasHlsStarted
                                  //           ? Center(
                                  //               child: Container(
                                  //                 child: HLSViewer(
                                  //                     streamUrl: context
                                  //                         .read<
                                  //                             MeetingStore>()
                                  //                         .streamUrl),
                                  //               ),
                                  //             )
                                  //           : Center(
                                  //               child: Column(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment
                                  //                         .center,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment
                                  //                         .center,
                                  //                 children: [
                                  //                   Padding(
                                  //                     padding:
                                  //                         const EdgeInsets
                                  //                                 .only(
                                  //                             bottom: 8.0),
                                  //                     child: Text(
                                  //                       "Waiting for HLS to start...",
                                  //                       style: TextStyle(
                                  //                           fontSize: 20),
                                  //                     ),
                                  //                   ),
                                  //                   CircularProgressIndicator(
                                  //                     strokeWidth: 1,
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             );
                                  //     });
                                }),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Selector<MeetingStore, bool>(
                                selector: (_, meetingStore) => true,
                                builder: (_, isHlsRunning, __) {
                                  return isHlsRunning
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                              // Selector<MeetingStore, bool>(
                                              //   selector: (_, meetingStore) =>
                                              //       meetingStore.isRaisedHand,
                                              //   builder: (_, raisedHand, __) {
                                              //     return Container(
                                              //         padding:
                                              //             EdgeInsets.all(8),
                                              //         child: IconButton(
                                              //           tooltip: 'RaiseHand',
                                              //           iconSize: 20,
                                              //           onPressed: () {
                                              //             context
                                              //                 .read<
                                              //                     MeetingStore>()
                                              //                 .changeMetadata();
                                              //             UtilityComponents
                                              //                 .showSnackBarWithString(
                                              //                     !raisedHand
                                              //                         ? "Raised Hand ON"
                                              //                         : "Raised Hand OFF",
                                              //                     context);
                                              //           },
                                              //           icon: Image.asset(
                                              //             'assets/icons/raise_hand.png',
                                              //             color: raisedHand
                                              //                 ? Colors.amber
                                              //                     .shade300
                                              //                 : Colors.white,
                                              //           ),
                                              //         ));
                                              //   },
                                              // ),
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                child: IconButton(
                                                    tooltip: 'Chat',
                                                    iconSize: 24,
                                                    onPressed: () {
                                                      chatMessages(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.chat_bubble,
                                                      // color: Colors.grey.shade900
                                                    )),
                                              ),
                                              Selector<MeetingStore, bool>(
                                                selector: (_, meetingStore) =>
                                                    meetingStore.isVideoOn,
                                                builder: (_, isVideoOn, __) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      // store.switchVideo(
                                                      //     isOn: store.isVideoOn);
                                                      context
                                                          .read<MeetingStore>()
                                                          .switchVideo();
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Colors
                                                          .transparent
                                                          .withOpacity(0.2),
                                                      child: Icon(
                                                          isVideoOn
                                                              ? Icons.videocam
                                                              : Icons
                                                                  .videocam_off,
                                                          color: Colors.blue),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Selector<MeetingStore, bool>(
                                                selector: (_, meetingStore) =>
                                                    meetingStore.isMicOn,
                                                builder: (_, isMicOn, __) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      // store.switchVideo(
                                                      //     isOn: store.isVideoOn);
                                                      context
                                                          .read<MeetingStore>()
                                                          .switchAudio();
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Colors
                                                          .transparent
                                                          .withOpacity(0.2),
                                                      child: Icon(
                                                          isMicOn
                                                              ? Icons.mic
                                                              : Icons.mic_off,
                                                          color: Colors.blue),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                child: IconButton(
                                                    color: Colors.white,
                                                    tooltip: 'Leave Or End',
                                                    iconSize: 24,
                                                    onPressed: () async {
                                                      await UtilityComponents
                                                          .onBackPressed(
                                                              context: context,
                                                              warningDialog:
                                                                  true);
                                                    },
                                                    icon: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      child: Icon(
                                                          Icons.call_end,
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ])
                                      : expandModalBottomSheet();
                                }),
                          ),
                          Selector<MeetingStore, HMSRoleChangeRequest>(
                              selector: (_, meetingStore) =>
                                  meetingStore.roleChangeRequest,
                              builder: (_, roleChangeRequest, __) {
                                if (roleChangeRequest != null) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    UtilityComponents.showRoleChangeDialog(
                                        roleChangeRequest, context);
                                  });
                                }
                                return Container();
                              }),
                          Selector<MeetingStore, HMSTrackChangeRequest>(
                              selector: (_, meetingStore) =>
                                  meetingStore.hmsTrackChangeRequest,
                              builder: (_, hmsTrackChangeRequest, __) {
                                if (hmsTrackChangeRequest != null) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    UtilityComponents.showTrackChangeDialog(
                                        hmsTrackChangeRequest, context);
                                  });
                                }
                                return Container();
                              }),
                        ],
                      ),
                    );
            },
          )),
    ));
  }

  Widget expandModalBottomSheet() {
    final meetingStore = context.read<MeetingStore>();
    Duration _duration = Duration(milliseconds: 50);
    AnimationController _controller =
        AnimationController(vsync: this, duration: _duration);
    bool isExpanded = false;

    return DraggableScrollableSheet(
        expand: false,
        minChildSize: 0.08,
        initialChildSize: 0.08,
        maxChildSize: 0.20,
        builder: (context, ScrollController scrollableController) {
          return ChangeNotifierProvider.value(
            value: meetingStore,
            child: SingleChildScrollView(
              controller: scrollableController,
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                color: Colors.transparent.withOpacity(0.2),
                // color: Utilities.menuColor,
                // height: ,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Selector<MeetingStore, Tuple3<HMSPeer, bool, bool>>(
                            selector: (_, meetingStore) => Tuple3(
                                meetingStore.localPeer,
                                meetingStore.isVideoOn,
                                meetingStore.localPeer?.role.publishSettings
                                        ?.allowed
                                        .contains("video") ??
                                    false),
                            builder: (_, data, __) {
                              return ((data.item1 != null) &&
                                      data.item1.role.publishSettings.allowed
                                          .contains("video"))
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      child: IconButton(
                                          tooltip: 'Video',
                                          iconSize: 24,
                                          onPressed: (audioViewOn)
                                              ? null
                                              : () {
                                                  context
                                                      .read<MeetingStore>()
                                                      .switchVideo();
                                                },
                                          icon: Icon(
                                            data.item2
                                                ? Icons.videocam
                                                : Icons.videocam_off,
                                            // color: Colors.grey.shade900,
                                          )))
                                  : Container();
                            },
                          ),
                          Selector<MeetingStore, Tuple3<HMSPeer, bool, bool>>(
                            selector: (_, meetingStore) => Tuple3(
                                meetingStore.localPeer,
                                meetingStore.isMicOn,
                                meetingStore.localPeer?.role.publishSettings
                                        ?.allowed
                                        .contains("audio") ??
                                    false),
                            builder: (_, data, __) {
                              return ((data.item1 != null) &&
                                      data.item1.role.publishSettings.allowed
                                          .contains("audio"))
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      child: IconButton(
                                          tooltip: 'Audio',
                                          iconSize: 24,
                                          onPressed: () {
                                            context
                                                .read<MeetingStore>()
                                                .switchAudio();
                                          },
                                          icon: Icon(
                                            data.item2
                                                ? Icons.mic
                                                : Icons.mic_off,
                                            // color: Colors.grey.shade900
                                          )))
                                  : Container();
                            },
                          ),
                          Container(
                              padding: EdgeInsets.all(8),
                              child: IconButton(
                                  tooltip: 'Expand',
                                  iconSize: 32,
                                  onPressed: () {
                                    animatedView(isExpanded);
                                    isExpanded = !isExpanded;
                                    if (_controller.isDismissed)
                                      _controller.forward();
                                    else if (_controller.isCompleted)
                                      _controller.reverse();
                                  },
                                  icon: AnimatedIcon(
                                    progress: _controller,
                                    icon: AnimatedIcons.menu_close,
                                    // color: Colors.grey.shade900
                                  ))),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: IconButton(
                                tooltip: 'Chat',
                                iconSize: 24,
                                onPressed: () {
                                  chatMessages(context);
                                },
                                icon: Icon(
                                  Icons.chat_bubble,
                                  // color: Colors.grey.shade900
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: IconButton(
                                color: Colors.white,
                                tooltip: 'Leave Or End',
                                iconSize: 24,
                                onPressed: () async {
                                  await UtilityComponents.onBackPressed(
                                      context: context, warningDialog: true);
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child:
                                      Icon(Icons.call_end, color: Colors.white),
                                )),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Selector<MeetingStore, bool>(
                          selector: (_, meetingStore) =>
                              meetingStore.isRaisedHand,
                          builder: (_, raisedHand, __) {
                            return Container(
                                padding: EdgeInsets.all(8),
                                child: IconButton(
                                  tooltip: 'RaiseHand',
                                  iconSize: 20,
                                  onPressed: () {
                                    context
                                        .read<MeetingStore>()
                                        .changeMetadata();
                                    UtilityComponents.showSnackBarWithString(
                                        !raisedHand
                                            ? "Raised Hand ON"
                                            : "Raised Hand OFF",
                                        context);
                                  },
                                  icon: Image.asset(
                                    'assets/icons/raise_hand.png',
                                    color: raisedHand
                                        ? Colors.amber.shade300
                                        : Colors.white,
                                  ),
                                ));
                          },
                        ),
                        Selector<MeetingStore, HMSPeer>(
                          selector: (_, meetingStore) => meetingStore.localPeer,
                          builder: (_, localPeer, __) {
                            return ((localPeer != null) &&
                                    localPeer.role.publishSettings.allowed
                                        .contains("screen") &&
                                    Platform.isAndroid)
                                ? Container(
                                    padding: EdgeInsets.all(8),
                                    child: Selector<MeetingStore, bool>(
                                        builder: (_, isScreenShareOn, __) {
                                          return IconButton(
                                              tooltip: 'Share',
                                              iconSize: 24,
                                              onPressed: () {
                                                if (!isScreenShareOn) {
                                                  meetingStore
                                                      .startScreenShare();
                                                } else {
                                                  meetingStore
                                                      .stopScreenShare();
                                                }
                                              },
                                              icon: Icon(
                                                Icons.screen_share,
                                                color: isScreenShareOn
                                                    ? Colors.blue
                                                    : Colors.white,
                                              ));
                                        },
                                        selector: (_, meetingStore) =>
                                            meetingStore.isScreenShareOn),
                                  )
                                : Container();
                          },
                        ),
                      ],
                    ),
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Icon(Icons.ac_unit),
                    //       Icon(Icons.ac_unit),
                    //       Icon(Icons.ac_unit)
                    //     ])
                  ],
                ),
              ),
            ),
          );
        });
  }

  void animatedView(bool isExpanded) {
    double maxChildSize = 0.19, minChildSize = 0.08;
    // scrollableController.animateTo(
    //   isExpanded ? minChildSize : maxChildSize,
    //   duration: const Duration(milliseconds: 50),
    //   curve: isExpanded ? Curves.easeInBack : Curves.easeOutBack,
    // );
  }

  Widget dropDownMenu() {
    return PopupMenuButton(
      icon: Icon(CupertinoIcons.gear),
      itemBuilder: (context) {
        final meetingStore = context.read<MeetingStore>();
        return [
          // //this one
          // PopupMenuItem(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("Send Logs"),
          //       Icon(Icons.bug_report),
          //     ],
          //   ),
          //   value: 1,
          // ),
          //this one
          // if (!(meetingStore.localPeer?.role?.name?.contains("hls-") ?? true))
          //   PopupMenuItem(
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //               meetingStore.isRecordingStarted
          //                   ? "Recording "
          //                   : "Record",
          //               style: TextStyle(
          //                 color: meetingStore.isRecordingStarted
          //                     ? Colors.red
          //                     : Colors.white,
          //               )),
          //           Icon(
          //             Icons.circle,
          //             color: meetingStore.isRecordingStarted
          //                 ? Colors.red
          //                 : Colors.white,
          //           ),
          //         ]),
          //     value: 2,
          //   ),
          //this one
          // if (!(meetingStore.localPeer?.role?.name?.contains("hls-") ?? true))
          //   PopupMenuItem(
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Toggle Camera  ",
          //           ),
          //           Icon(Icons.switch_camera),
          //         ]),
          //     value: 3,
          //   ),

          PopupMenuItem(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Participants  ",
                  ),
                  Icon(CupertinoIcons.person_3_fill),
                ]),
            value: 4,
          ),
          // //this one
          // PopupMenuItem(
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           audioViewOn ? "Video View" : "Audio View",
          //         ),
          //         Image.asset(
          //           audioViewOn
          //               ? 'assets/icons/video.png'
          //               : 'assets/icons/audio.png',
          //           color: Colors.white,
          //           height: 24.0,
          //           width: 24.0,
          //         ),
          //       ]),
          //   value: 5,
          // ),
          //this one
          // PopupMenuItem(
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "Active Speaker Mode ",
          //         ),
          //         Icon(CupertinoIcons.person_3_fill),
          //       ]),
          //   value: 6,
          // ),
          //this one
          // PopupMenuItem(
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "Hero Mode ",
          //         ),
          //         Icon(CupertinoIcons.person_3_fill),
          //       ]),
          //   value: 7,
          // ),
          PopupMenuItem(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change Name",
                  ),
                  Icon(Icons.create_rounded),
                ]),
            value: 8,
          ),
          //this one
          // if (!(meetingStore.localPeer?.role?.name?.contains("hls-") ?? true))
          //   PopupMenuItem(
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             meetingStore.hasHlsStarted ? "Stop HLS" : "Start HLS",
          //             style: TextStyle(
          //               color: meetingStore.hasHlsStarted
          //                   ? Colors.red
          //                   : Colors.white,
          //             ),
          //           ),
          //           Icon(Icons.stream,
          //               color: meetingStore.hasHlsStarted
          //                   ? Colors.red
          //                   : Colors.white),
          //         ]),
          //     value: 9,
          //   ),

          if (meetingStore.localPeer?.role?.permissions?.changeRole ?? false)
            PopupMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mute Roles",
                    ),
                    Icon(Icons.mic_off_sharp),
                  ]),
              value: 10,
            ),
          if (meetingStore.localPeer?.role?.permissions?.changeRole ?? false)
            PopupMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mute All",
                    ),
                    Icon(Icons.mic_off),
                  ]),
              value: 11,
            ),
          PopupMenuItem(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BRB",
                    style: TextStyle(
                        color: meetingStore.isBRB ? Colors.red : Colors.white),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: meetingStore.isBRB
                                ? Colors.red
                                : Colors.white)),
                    child: Text(
                      "BRB",
                      style: TextStyle(
                          color:
                              meetingStore.isBRB ? Colors.red : Colors.white),
                    ),
                  ),
                ]),
            value: 12,
          ),
          // if (meetingStore.localPeer.role.permissions.endRoom)
          //   PopupMenuItem(
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "End Room",
          //           ),
          //           Icon(Icons.cancel_schedule_send),
          //         ]),
          //     value: 13,
          //   ),
        ];
      },
      onSelected: handleMenu,
    );
  }
}
