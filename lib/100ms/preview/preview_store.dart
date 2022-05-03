//Package imports
import 'package:flutter/cupertino.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/main.dart';

class PreviewStore extends ChangeNotifier
    implements HMSPreviewListener, HMSLogListener{
  List<HMSVideoTrack> previewTrack = [];

  PreviewStore();

  HMSPeer peer;

  HMSException error;

  //bool isHLSLink = false;
  HMSRoom room;

  bool isVideoOn = true;

  bool isAudioOn = true;

  bool isRecordingStarted = false;

  List<HMSPeer> peers = [];

  int networkQuality;

  HMSSDK hmsSDK =  new HMSSDK();
  
  @override
  void onError({@required HMSException error}) {
    updateError(error);
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   print('Inside Dispose method called ---');
  //   switchVideo();
  //   // hmsSDK.leave(hmsActionResultListener: this);
  //   super.dispose();
  // }

  @override
  void onPreview({@required HMSRoom room, @required List<HMSTrack> localTracks}) {
    this.room = room;

    print('100ms cross checking check local tracks length --- ${localTracks.length}');

    for (HMSPeer each in room.peers) {
      if (each.isLocal) {
        peer = each;
        if (each.role.name.indexOf("hls-") == 0) {
          //isHLSLink = true;
          notifyListeners();
        }
        break;
      }
    }

    List<HMSVideoTrack> videoTracks = [];
    for (var track in localTracks) {
      if (track.kind == HMSTrackKind.kHMSTrackKindVideo) {
        videoTracks.add(track as HMSVideoTrack);
      }
    }

    print('100ms cross checking check local tracks length 2 --- ${videoTracks.length}');
    this.previewTrack = videoTracks;
    notifyListeners();
  }

  @override
  void onPeerUpdate({@required HMSPeer peer, @required HMSPeerUpdate update}) {
    switch (update) {
      case HMSPeerUpdate.peerJoined:
        peers.add(peer);
        break;
      case HMSPeerUpdate.peerLeft:
        peers.remove(peer);
        break;
      case HMSPeerUpdate.networkQualityUpdated:
        if (peer.isLocal) {
          networkQuality = peer.networkQuality?.quality;
          notifyListeners();
        }
        break;
      case HMSPeerUpdate.roleUpdated:
        int index = peers.indexOf(peer);
        if (index != -1) peers[index] = peer;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  @override
  void onRoomUpdate({@required HMSRoom room, @required HMSRoomUpdate update}) {
    switch (update) {
      case HMSRoomUpdate.browserRecordingStateUpdated:
        isRecordingStarted = room.hmsBrowserRecordingState?.running ?? false;
        break;

      case HMSRoomUpdate.serverRecordingStateUpdated:
        isRecordingStarted = room.hmsServerRecordingState?.running ?? false;
        break;

      case HMSRoomUpdate.rtmpStreamingStateUpdated:
        isRecordingStarted = room.hmsRtmpStreamingState?.running ?? false;
        break;
      case HMSRoomUpdate.hlsStreamingStateUpdated:
        isRecordingStarted = room.hmshlsStreamingState?.running ?? false;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  @override
  void onLogMessage({@required hmsLogList}) {
    print(' On Ctreash Meeting ---= ${hmsLogList.toString()}');
  }

  void updateError(HMSException error) {
    this.error = error;
  }

  Future<bool> startPreview(
      {String token}) async {
    String myName = locator<AppPrefs>().userName.getValue()??'Unknown';
    HMSConfig config = HMSConfig(authToken: token,
        userName: myName??"Unknown",captureNetworkQualityInPreview: true);
    hmsSDK.build();
    hmsSDK.preview(config: config);
    return true;
  }

  void addPreviewListener() {
    hmsSDK.addPreviewListener(listener: this);
  }

  void removePreviewListener() {
    hmsSDK.removePreviewListener(listener: this);
  }

  void stopCapturing() {
    hmsSDK.stopCapturing();
  }

  void startCapturing() {
    hmsSDK.startCapturing();
  }

  void switchVideo({bool isOn = false}) {
    hmsSDK.switchVideo(isOn: isOn);
    isVideoOn = !isVideoOn;
    notifyListeners();
  }

  void switchAudio({bool isOn = false}) {
    hmsSDK.switchAudio(isOn: isOn);
    isAudioOn = !isAudioOn;
    notifyListeners();
  }
}
