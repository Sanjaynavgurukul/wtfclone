//Package imports

import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:wtf/100ms/common/util/utility_function.dart';
import 'package:provider/provider.dart';

//Project imports
import 'package:wtf/100ms/common/ui/organisms/offline_screen.dart';
import 'package:wtf/100ms/common/util/utility_components.dart';
import 'package:wtf/100ms/enum/meeting_flow.dart';
import 'package:wtf/100ms/meeting/meeting_page.dart';
import 'package:wtf/100ms/meeting/meeting_store.dart';
import 'package:wtf/100ms/preview/preview_store.dart';
import 'package:wtf/model/100ms_model.dart';

class PreviewPage extends StatefulWidget {
  final MsModel model;
  const PreviewPage(
      {Key key, @required this.model})
      : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initPreview();
  }

  void initPreview() async {
    context.read<PreviewStore>().addPreviewListener();
    bool ans = await context
        .read<PreviewStore>()
        .startPreview(model: widget.model);
    print('checking token --- ${widget.model.token}');
    if (ans == false) {
      UtilityComponents.showSnackBarWithString("Unable to preview", context);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height;
    final double itemWidth = size.width;
    return Consumer<PreviewStore>(
      builder: (context, store, child) {
        return ConnectivityAppWrapper(
          app: ConnectivityWidgetWrapper(
            offlineWidget: OfflineWidget(),
            disableInteraction: true,
            child: Scaffold(
              body: Stack(
                children: [
                  (store.previewTrack.isEmpty)
                      ? Align(
                      alignment: Alignment.center,
                      child: CupertinoActivityIndicator(radius: 50))
                      : Container(
                    height: itemHeight,
                    width: itemWidth,
                    child: (store.isVideoOn)
                        ? HMSVideoView(
                      scaleType: ScaleType.SCALE_ASPECT_FILL,
                      track: store.previewTrack[0],
                      setMirror: true,
                      matchParent: false,
                    )
                        : Container(
                      height: itemHeight,
                      width: itemWidth,
                      child: Center(
                          child: CircleAvatar(
                              backgroundColor: Utilities.colors[
                              store.peer.name
                                  .toLowerCase()
                                  .codeUnitAt(0) %
                                  Utilities.colors.length],
                              radius: 36,
                              child: Text(
                                Utilities.getAvatarTitle(
                                    store.peer.name),
                                style: TextStyle(
                                    fontSize: 36, color: Colors.white),
                              ))),
                    ),
                  ),
                  if (store.networkQuality != null &&
                      store.networkQuality != -1)
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/icons/network_${store.networkQuality}.png',
                          scale: 2,
                        ),
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(top: 40, right: 20),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (store.isRecordingStarted)
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              if (store.peers.isNotEmpty)
                                IconButton(
                                    padding: EdgeInsets.all(5),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  2,
                                              padding: EdgeInsets.only(top: 15),
                                              child: ListView.separated(
                                                  itemBuilder: (context, index) {
                                                    HMSPeer peer =
                                                    store.peers[index];
                                                    return Container(
                                                      padding: EdgeInsets.all(15),
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              174, 0, 0, 0),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            peer.name,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color:
                                                                Colors.white),
                                                          ),
                                                          Text(peer.role.name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color:
                                                                  Colors.white))
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return Divider();
                                                  },
                                                  itemCount:
                                                  store.peers.length));
                                        },
                                      );
                                    },
                                    icon: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color:
                                            Colors.transparent.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Icon(
                                          Icons.person,
                                          size: 24,
                                        ))),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (store.peer != null &&
                              store.peer.role.publishSettings.allowed
                                  .contains("video"))
                              ? GestureDetector(
                            onTap: store.previewTrack.isEmpty
                                ? null
                                : () async {
                              store.switchVideo(
                                  isOn: store.isVideoOn);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                              Colors.transparent.withOpacity(0.2),
                              child: Icon(
                                  store.isVideoOn
                                      ? Icons.videocam
                                      : Icons.videocam_off,
                                  color: Colors.blue),
                            ),
                          )
                              : Container(),

                          store.peer != null
                              ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue),
                            onPressed: () {
                              context
                                  .read<PreviewStore>()
                                  .removePreviewListener();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ListenableProvider.value(
                                            value: MeetingStore(),
                                            child: MeetingPage(
                                              roomId: widget.model.data.id,
                                              flow: MeetingFlow.join,
                                              user: widget.model.data.user,
                                              isAudioOn:
                                              store.isAudioOn,
                                              localPeerNetworkQuality:
                                              store
                                                  .networkQuality,
                                            ),
                                          )));
                            },
                            child: Text(
                              'Join Now',
                              style: TextStyle(height: 1, fontSize: 18),
                            ),
                          ): Container(),
                          (store.peer != null &&
                              context
                                  .read<PreviewStore>()
                                  .peer
                                  .role
                                  .publishSettings
                                  .allowed
                                  .contains("audio"))
                              ? GestureDetector(
                            onTap: () async {
                              store.switchAudio();
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                              Colors.transparent.withOpacity(0.2),
                              child: Icon(
                                (store.isAudioOn)
                                    ? Icons.mic
                                    : Icons.mic_off,
                                color: Colors.blue,
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
