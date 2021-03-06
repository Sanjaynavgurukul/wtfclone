//Package Imports
import 'package:flutter/foundation.dart';

//Project Imports
import 'package:hmssdk_flutter/hmssdk_flutter.dart';

class PeerTrackNode extends ChangeNotifier {
  HMSPeer peer;

  String uid;

  HMSVideoTrack track;
  HMSAudioTrack audioTrack;

  bool isOffscreen;
  int networkQuality;

  PeerTrackNode(
      {@required this.peer,
      this.track,
      this.audioTrack,
      @required this.uid,
      this.isOffscreen = false,
      this.networkQuality = -1});

  @override
  String toString() {
    return 'PeerTrackNode{peerId: ${peer.peerId}, name: ${peer.name}, track: $track}, isVideoOn: $isOffscreen }';
  }

  @override
  int get hashCode => peer.peerId.hashCode;

  void notify() {
    notifyListeners();
  }

  void setOffScreenStatus(bool currentState) {
    this.isOffscreen = currentState;
    notify();
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }
}
