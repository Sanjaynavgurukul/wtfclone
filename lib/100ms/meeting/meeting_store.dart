//Package imports

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

//Project imports
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:wtf/100ms/meeting/hms_sdk_interactor.dart';
import 'package:wtf/100ms/meeting/peer_track_node.dart';
import 'package:wtf/100ms/manager/HmsSdkManager.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/100ms_model.dart';

class MeetingStore extends ChangeNotifier
    implements HMSUpdateListener, HMSActionResultListener {
   HMSSDKInteractor _hmssdkInteractor;

  MeetingStore() {
    _hmssdkInteractor = HmsSdkManager.hmsSdkInteractor;
  }

  // HMSLogListener

  bool isSpeakerOn = true;

  int screenShareCount = 0;

  HMSException hmsException;

  bool hasHlsStarted = false;

  String streamUrl = "";

  // bool isHLSLink = false;

  HMSRoleChangeRequest roleChangeRequest;

  bool isMeetingStarted = false;

  bool isVideoOn = true;

  bool isMicOn = true;

  bool isScreenShareOn = false;

  List<HMSTrack> screenShareTrack = [];

  HMSTrack curentScreenShareTrack;

  bool reconnecting = false;

  bool reconnected = false;

  bool isRoomEnded = false;

  bool isRecordingStarted = false;

  String event = '';

  String description = "Meeting Ended";

  HMSTrackChangeRequest hmsTrackChangeRequest;

  List<HMSRole> roles = [];

   int highestSpeakerIndex = -1;

  List<HMSPeer> peers = [];

  HMSPeer localPeer;

  bool isActiveSpeakerMode = false;

  List<HMSTrack> audioTracks = [];

  List<HMSMessage> messages = [];

  List<PeerTrackNode> peerTracks = [];

  List<String> activeSpeakerIds = [];

  HMSRoom hmsRoom;

  int localPeerNetworkQuality;

  int firstTimeBuild = 0;
  final DateFormat formatter = DateFormat('d MMM y h:mm:ss a');

  void addUpdateListener() {
    HmsSdkManager.hmsSdkInteractor?.addUpdateListener(this);
    // startHMSLogger(HMSLogLevel.VERBOSE, HMSLogLevel.VERBOSE);
    // addLogsListener();
  }

  void removeUpdateListener() {
    _hmssdkInteractor.removeUpdateListener(this);
    // removeLogsListener();
  }

  Future<bool> join({@required String token,bool mute = true,bool isVideo = true}) async {
    print('Check Meeting toekn here --- ${token} audio : $mute vide $isVideo');
    String myName = locator<AppPrefs>().userName.getValue()??'Unknown';
    HMSConfig config = HMSConfig(authToken: token,
        userName: myName
    );
    this.isMicOn = mute;
    this.isVideoOn = isVideo;
    HmsSdkManager.hmsSdkInteractor?.join(config: config);
    await _hmssdkInteractor.switchAudio(isOn: mute);
    await _hmssdkInteractor.switchVideo(isOn: isVideo);
    return true;
  }

  void  leave() async {
    if (isScreenShareOn) {
      isScreenShareOn = false;
      _hmssdkInteractor.stopScreenShare();
    }
    _hmssdkInteractor.leave(hmsActionResultListener: this);
  }

  Future<void> switchAudio() async {
    print('check audio and video state store in--- ${isMicOn}');
    await _hmssdkInteractor.switchAudio(isOn: isMicOn);
    isMicOn = !isMicOn;
    notifyListeners();
  }

  Future<void> switchVideo() async {
    print('check audio and video state store in--- ${isVideoOn}');
    await _hmssdkInteractor.switchVideo(isOn: isVideoOn);
    isVideoOn = !isVideoOn;
    notifyListeners();
  }

  Future<void> switchCamera() async {
    await _hmssdkInteractor.switchCamera();
  }

  void sendBroadcastMessage(String message) {
    _hmssdkInteractor.sendBroadcastMessage(message, this);
  }

  void sendDirectMessage(String message, HMSPeer peer) async {
    _hmssdkInteractor.sendDirectMessage(message, peer, this);
  }

  void sendGroupMessage(String message, List<HMSRole> roles) async {
    _hmssdkInteractor.sendGroupMessage(message, roles, this);
  }

  void toggleSpeaker() {
    if (isSpeakerOn) {
      muteAll();
    } else {
      unMuteAll();
    }
    isSpeakerOn = !isSpeakerOn;
    notifyListeners();
  }

  Future<bool> isAudioMute(HMSPeer peer) async {
    // TODO: add permission checks in exmaple app UI
    return await _hmssdkInteractor.isAudioMute(peer);
  }

  Future<bool> isVideoMute(HMSPeer peer) async {
    // TODO: add permission checks in exmaple app UI
    return await _hmssdkInteractor.isVideoMute(peer);
  }

  Future<bool> startCapturing() async {
    return await _hmssdkInteractor.startCapturing();
  }

  void stopCapturing() {
    _hmssdkInteractor.stopCapturing();
  }

  void removePeer(HMSPeer peer) {
    peers.remove(peer);
    // removeTrackWithPeerId(peer.peerId);
  }

  void addPeer(HMSPeer peer) {
    if (!peers.contains(peer)) peers.add(peer);
  }

  // void removeTrackWithTrackId(String trackId) {
  //   tracks.removeWhere((eachTrack) => eachTrack.trackId == trackId);
  // }

  // void removeTrackWithPeerId(String peerId) {
  //   tracks.removeWhere((eachTrack) => eachTrack.peer?.peerId == peerId);
  // }

  // void removeTrackWithPeerIdExtra(String trackId) {
  //   var index = tracks.indexWhere((element) => trackId == element.trackId);
  //   tracks.removeAt(index);
  // }

  // int insertTrackWithPeerId(HMSPeer peer) {
  //   return tracks.indexWhere((element) => peer.peerId == element.peer!.peerId);
  // }

  // void addTrack(HMSTrack track, HMSPeer peer) {
  //   var index = -1;
  //   if (track.source.trim() == "REGULAR") index = insertTrackWithPeerId(peer);

  //   if (index >= 0) {
  //     if (track.kind == HMSTrackKind.kHMSTrackKindVideo) {
  //       tracks.insert(index, track);
  //       tracks.removeAt(index + 1);
  //     }
  //   } else if (index == -1 && track.source.trim() != "REGULAR") {
  //     tracks.insert(0, track);
  //   } else {
  //     tracks.add(track);
  //   }
  // }

  void onRoleUpdated(int index, HMSPeer peer) {
    peers[index] = peer;
  }
  
  void updateRoleChangeRequest(HMSRoleChangeRequest roleChangeRequest) {
    this.roleChangeRequest = roleChangeRequest;
  }

  void addMessage(HMSMessage message) {
    this.messages.add(message);
  }

  void addTrackChangeRequestInstance(
      HMSTrackChangeRequest hmsTrackChangeRequest) {
    this.hmsTrackChangeRequest = hmsTrackChangeRequest;
    notifyListeners();
  }

  void updatePeerAt(peer) {
    int index = this.peers.indexOf(peer);
    this.peers.removeAt(index);
    this.peers.insert(index, peer);
  }

  Future<void> isScreenShareActive() async {
    this.isScreenShareOn = await _hmssdkInteractor.isScreenShareActive();
  }

  @override
  void onJoin({@required HMSRoom room}) async {
    print('Chck peer track length --- started');
    isMeetingStarted = true;
    hmsRoom = room;
    // if (room.hmshlsStreamingState?.running ?? false) {
    //   hasHlsStarted = true;
    //   streamUrl = room.hmshlsStreamingState?.variants[0]?.hlsStreamUrl ?? "";
    // } else {
    //   hasHlsStarted = false;
    // }
    if (room.hmsBrowserRecordingState?.running == true ||
        room.hmsServerRecordingState?.running == true ||
        room.hmsRtmpStreamingState?.running == true ||
        room.hmshlsStreamingState?.running == true)
      isRecordingStarted = true;
    else
      isRecordingStarted = false;

    for (HMSPeer each in room.peers) {
      if (each.isLocal) {
        int index = peerTracks
            .indexWhere((element) => element.uid == each.peerId + "mainVideo");
        if (index == -1)
          peerTracks.add(PeerTrackNode(
              peer: each,
              uid: each.peerId + "mainVideo",
              networkQuality: localPeerNetworkQuality));
        localPeer = each;
        addPeer(localPeer);
        //if (localPeer.role.name.contains("hls-") == true) isHLSLink = true;

        if (each.videoTrack != null) {
          if (each.videoTrack.kind == HMSTrackKind.kHMSTrackKindVideo) {
            int index = peerTracks.indexWhere(
                (element) => element.uid == each.peerId + "mainVideo");
            peerTracks[index].track = each.videoTrack;
            if (each.videoTrack.isMute) {
              this.isVideoOn = false;
            }
          }
        }
        break;
      }
    }
    print('Chck peer track length --- ${peerTracks.length}');
    roles = await getRoles();
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
        hasHlsStarted = room.hmshlsStreamingState?.running ?? false;
        streamUrl = hasHlsStarted
            ? room.hmshlsStreamingState?.variants[0]?.hlsStreamUrl ?? ""
            : "";
        break;
      default:
        break;
    }
    notifyListeners();
  }

  @override
  void onPeerUpdate(
      {@required HMSPeer peer, @required HMSPeerUpdate update}) async {
    peerOperation(peer, update);
  }

  @override
  void onTrackUpdate(
      {@required HMSTrack track,
      @required HMSTrackUpdate trackUpdate,
      @required HMSPeer peer}) {
    if (isSpeakerOn) {
      unMuteAll();
    } else {
      muteAll();
    }

    if (peer.isLocal) {
      if (track.kind == HMSTrackKind.kHMSTrackKindAudio &&
          track.source == "REGULAR") {
        this.isMicOn = !track.isMute;
      }
      if (track.kind == HMSTrackKind.kHMSTrackKindVideo &&
          track.source == "REGULAR") {
        this.isVideoOn = !track.isMute;
      }
      notifyListeners();
    }

    if (track.kind == HMSTrackKind.kHMSTrackKindAudio) {
      int index = peerTracks
          .indexWhere((element) => element.uid == peer.peerId + "mainVideo");
      if (index != -1) {
        PeerTrackNode peerTrackNode = peerTracks[index];
        peerTrackNode.audioTrack = track as HMSAudioTrack;
        peerTrackNode.notify();
      }
      return;
    }

    if (track.source == "REGULAR") {
      int index = peerTracks
          .indexWhere((element) => element.uid == peer.peerId + "mainVideo");
      if (index != -1) {
        PeerTrackNode peerTrackNode = peerTracks[index];
        peerTrackNode.track = track as HMSVideoTrack;
        peerTrackNode.notify();
      } else {
        return;
      }
    }
    peerOperationWithTrack(peer, trackUpdate, track);
  }

  @override
  void onError({@required HMSException error}) {
    this.hmsException = hmsException;
    notifyListeners();
  }

  @override
  void onMessage({@required HMSMessage message}) {
    addMessage(message);
    notifyListeners();
  }

  @override
  void onRoleChangeRequest({@required HMSRoleChangeRequest roleChangeRequest}) {
    updateRoleChangeRequest(roleChangeRequest);
    notifyListeners();
  }

  PeerTrackNode previousHighestTrackNodeStore;
  int previousHighestIndex = -1;

  @override
  void onUpdateSpeakers({@required List<HMSSpeaker> updateSpeakers}) {
    if (updateSpeakers.isEmpty) {
      activeSpeakerIds.clear();
      return;
    } else {
      updateSpeakers.forEach((speaker) {
        activeSpeakerIds.add(speaker.peer.peerId + "mainVideo");
      });
    }
    notifyListeners();
  }

  @override
  void onReconnecting() {
    reconnected = false;
    reconnecting = true;
  }

  @override
  void onReconnected() {
    reconnecting = false;
    reconnected = true;
  }

  int trackChange = -1;

  @override
  void onChangeTrackStateRequest(
      {@required HMSTrackChangeRequest hmsTrackChangeRequest}) {
    if (!hmsTrackChangeRequest.mute)
      addTrackChangeRequestInstance(hmsTrackChangeRequest);
    else {
      if (hmsTrackChangeRequest.track.kind == HMSTrackKind.kHMSTrackKindVideo) {
        isVideoOn = false;
      } else {
        isMicOn = false;
      }
      notifyListeners();
    }
  }

  void rejectrequest() {
    notifyListeners();
  }

  void changeTracks(HMSTrackChangeRequest hmsTrackChangeRequest) {
    if (hmsTrackChangeRequest.track.kind == HMSTrackKind.kHMSTrackKindVideo) {
      switchVideo();
    } else {
      switchAudio();
    }
    this.hmsTrackChangeRequest = null;
    // notifyListeners();
  }

  @override
  void onRemovedFromRoom({@required HMSPeerRemovedFromPeer hmsPeerRemovedFromPeer}) {
    description = "Removed by ${hmsPeerRemovedFromPeer.peerWhoRemoved?.name}";
    peerTracks.clear();
    isRoomEnded = true;
    notifyListeners();
  }

  void changeRole(
      {@required HMSPeer peer,
      @required HMSRole roleName,
      bool forceChange = false}) {
    _hmssdkInteractor.changeRole(
        toRole: roleName,
        forPeer: peer,
        force: forceChange,
        hmsActionResultListener: this);
  }

  Future<List<HMSRole>> getRoles() async {
    return await _hmssdkInteractor.getRoles();
  }

  void changeTrackState(HMSTrack track, bool mute) {
    return HmsSdkManager.hmsSdkInteractor?.changeTrackState(track, mute, this);
  }

  void peerOperation(HMSPeer peer, HMSPeerUpdate update) {
    switch (update) {
      case HMSPeerUpdate.peerJoined:
        if (peer.role.name.contains("hls-") == false) {
          int index = peerTracks.indexWhere(
              (element) => element.uid == peer.peerId + "mainVideo");
          if (index == -1)
            peerTracks.add(
                new PeerTrackNode(peer: peer, uid: peer.peerId + "mainVideo"));
          notifyListeners();
        }
        addPeer(peer);
        break;

      case HMSPeerUpdate.peerLeft:
        peerTracks.removeWhere(
            (leftPeer) => leftPeer.uid == peer.peerId + "mainVideo");
        removePeer(peer);
        notifyListeners();
        break;

      case HMSPeerUpdate.roleUpdated:
        if (peer.isLocal) localPeer = peer;
        if (peer.role.name.contains("hls-")) {
          //isHLSLink = peer.isLocal;
          peerTracks.removeWhere(
              (leftPeer) => leftPeer.uid == peer.peerId + "mainVideo");
        } else {
          // if (peer.isLocal) {
          //   isHLSLink = false;
          // }
          int index = peerTracks.indexWhere(
              (element) => element.uid == peer.peerId + "mainVideo");
          if (index == -1)
            peerTracks.add(
                new PeerTrackNode(peer: peer, uid: peer.peerId + "mainVideo"));
        }

        updatePeerAt(peer);
        notifyListeners();
        break;

      case HMSPeerUpdate.metadataChanged:
        int index = peerTracks
            .indexWhere((element) => element.uid == peer.peerId + "mainVideo");
        if (index != -1) {
          PeerTrackNode peerTrackNode = peerTracks[index];
          peerTrackNode.peer = peer;
          peerTrackNode.notify();
        }
        updatePeerAt(peer);
        break;

      case HMSPeerUpdate.nameChanged:
        if (peer.isLocal) {
          int localPeerIndex = peerTracks.indexWhere(
              (element) => element.uid == localPeer.peerId + "mainVideo");
          if (localPeerIndex != -1) {
            PeerTrackNode peerTrackNode = peerTracks[localPeerIndex];
            peerTrackNode.peer = peer;
            localPeer = peer;
            peerTrackNode.notify();
          }
        } else {
          int remotePeerIndex = peerTracks.indexWhere(
              (element) => element.uid == peer.peerId + "mainVideo");
          if (remotePeerIndex != -1) {
            PeerTrackNode peerTrackNode = peerTracks[remotePeerIndex];
            peerTrackNode.peer = peer;
            peerTrackNode.notify();
          }
        }
        updatePeerAt(peer);
        break;

      case HMSPeerUpdate.networkQualityUpdated:
        print(
            "onPeerUpdate networkQuality ${peer.name} ${peer.networkQuality?.quality}");
        int index = peerTracks
            .indexWhere((element) => element.uid == peer.peerId + "mainVideo");
        if (index != -1) {
          peerTracks[index].networkQuality = peer.networkQuality?.quality;
          peerTracks[index].notify();
        }
        break;

      case HMSPeerUpdate.defaultUpdate:
        break;

      default:
    }
  }

  void peerOperationWithTrack(
      HMSPeer peer, HMSTrackUpdate update, HMSTrack track) {
    switch (update) {
      case HMSTrackUpdate.trackAdded:
        if (track.source != "REGULAR") {
          screenShareCount++;
          peerTracks.insert(
              0,
              PeerTrackNode(
                  peer: peer,
                  uid: peer.peerId + track.trackId,
                  track: track as HMSVideoTrack));
          notifyListeners();
          isScreenShareActive();
        }
        break;
      case HMSTrackUpdate.trackRemoved:
        if (track.source != "REGULAR") {
          screenShareCount--;
          peerTracks.removeWhere(
              (element) => element.uid == peer.peerId + track.trackId);
          notifyListeners();
        } else {
          isScreenShareActive();
        }
        break;
      case HMSTrackUpdate.trackMuted:
        // trackStatus[peer.peerId] = HMSTrackUpdate.trackMuted;
        break;
      case HMSTrackUpdate.trackUnMuted:
        // trackStatus[peer.peerId] = HMSTrackUpdate.trackUnMuted;
        break;
      case HMSTrackUpdate.trackDescriptionChanged:
        break;
      case HMSTrackUpdate.trackDegraded:
        break;
      case HMSTrackUpdate.trackRestored:
        break;
      case HMSTrackUpdate.defaultUpdate:
        break;
      default:
    }
  }

  void endRoom(bool lock, String reason) {
    _hmssdkInteractor.endRoom(lock, reason == null ? "" : reason, this);
  }

  void removePeerFromRoom(HMSPeer peer) {
    _hmssdkInteractor.removePeer(peer, this);
  }

  void startScreenShare() {
    _hmssdkInteractor.startScreenShare(hmsActionResultListener: this);
  }

  void stopScreenShare() {
    _hmssdkInteractor.stopScreenShare(hmsActionResultListener: this);
  }

  void muteAll() {
    _hmssdkInteractor.muteAll();
  }

  void unMuteAll() {
    _hmssdkInteractor.unMuteAll();
  }

  // Logs are currently turned Off
  // @override
  // void onLogMessage({required dynamic HMSLogList}) async {
  // StaticLogger.logger?.v(HMSLogList.toString());
  //   FirebaseCrashlytics.instance.log(HMSLogList.toString());
  // }

  // void startHMSLogger(HMSLogLevel webRtclogLevel, HMSLogLevel logLevel) {
  //   HmsSdkManager.hmsSdkInteractor?.startHMSLogger(webRtclogLevel, logLevel);
  // }
  //
  // void addLogsListener() {
  //   HmsSdkManager.hmsSdkInteractor?.addLogsListener(this);
  // }
  //
  // void removeLogsListener() {
  //   HmsSdkManager.hmsSdkInteractor?.removeLogsListener(this);
  // }
  //
  // void removeHMSLogger() {
  //   HmsSdkManager.hmsSdkInteractor?.removeHMSLogger();
  // }

  Future<HMSPeer> getLocalPeer() async {
    return await _hmssdkInteractor.getLocalPeer();
  }

  void startRtmpOrRecording(
      {@required String meetingUrl,
      @required bool toRecord,
      List<String> rtmpUrls}) async {
    HMSRecordingConfig hmsRecordingConfig = new HMSRecordingConfig(
        meetingUrl: meetingUrl, toRecord: toRecord, rtmpUrls: rtmpUrls);

    _hmssdkInteractor.startRtmpOrRecording(hmsRecordingConfig, this);
  }

  void stopRtmpAndRecording() async {
    _hmssdkInteractor.stopRtmpAndRecording(this);
  }

  Future<HMSRoom> getRoom() async {
    HMSRoom room = await _hmssdkInteractor.getRoom();
    return room;
  }

  Future<HMSPeer> getPeer({@required String peerId}) async {
    return await _hmssdkInteractor.getPeer(peerId: peerId);
  }

  bool isRaisedHand = false;

  void changeMetadata() {
    isRaisedHand = !isRaisedHand;
    isBRB = false;
    String value = isRaisedHand ? "true" : "false";
    _hmssdkInteractor.changeMetadata(
        metadata: "{\"isHandRaised\":$value,\"isBRBOn\":false}",
        hmsActionResultListener: this);
  }

  bool isBRB = false;

  void changeMetadataBRB() {
    isBRB = !isBRB;
    isRaisedHand = false;
    String value = isBRB ? "true" : "false";
    _hmssdkInteractor.changeMetadata(
        metadata: "{\"isHandRaised\":false,\"isBRBOn\":$value}",
        hmsActionResultListener: this);
    if (isMicOn) {
      switchAudio();
    }
    if (isVideoOn) {
      switchVideo();
    }
    notifyListeners();
  }

  void setPlayBackAllowed(bool allow) {
    _hmssdkInteractor.setPlayBackAllowed(allow);
  }

  void acceptChangeRole(HMSRoleChangeRequest hmsRoleChangeRequest) {
    _hmssdkInteractor.acceptChangeRole(hmsRoleChangeRequest, this);
    this.roleChangeRequest = null;
    notifyListeners();
  }

  void changeName({@required String name}) {
    _hmssdkInteractor.changeName(name: name, hmsActionResultListener: this);
  }

  void startHLSStreaming(String meetingUrl) {
    _hmssdkInteractor.startHLSStreaming(meetingUrl, this);
  }

  void stopHLSStreaming() {
    _hmssdkInteractor.stopHLSStreaming(hmsActionResultListener: this);
  }

  void changeTrackStateForRole(bool mute, List<HMSRole> roles) {
    _hmssdkInteractor.changeTrackStateForRole(
        true, HMSTrackKind.kHMSTrackKindAudio, "regular", roles, this);
  }

  @override
  void onLocalAudioStats(
      {@required HMSLocalAudioStats hmsLocalAudioStats,
      @required HMSLocalAudioTrack track,
      @required HMSPeer peer}) {}

  @override
  void onLocalVideoStats(
      {@required HMSLocalVideoStats hmsLocalVideoStats,
      @required HMSLocalVideoTrack track,
      @required HMSPeer peer}) {}

  @override
  void onRemoteAudioStats(
      {@required HMSRemoteAudioStats hmsRemoteAudioStats,
      @required HMSRemoteAudioTrack track,
      @required HMSPeer peer}) {}

  @override
  void onRemoteVideoStats(
      {@required HMSRemoteVideoStats hmsRemoteVideoStats,
      @required HMSRemoteVideoTrack track,
      @required HMSPeer peer}) {}

  @override
  void onRTCStats({@required HMSRTCStatsReport hmsrtcStatsReport}) {}

  bool isActiveSpeaker(String uid) {
    return activeSpeakerIds.contains(uid);
  }

  @override
  void onSuccess(
      {HMSActionResultListenerMethod methodType =
          HMSActionResultListenerMethod.unknown,
      Map<String, dynamic> arguments}) {
    switch (methodType) {
      case HMSActionResultListenerMethod.leave:
        peerTracks.clear();
        isRoomEnded = true;
        notifyListeners();
        break;
      case HMSActionResultListenerMethod.changeTrackState:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.changeMetadata:
        notifyListeners();
        break;
      case HMSActionResultListenerMethod.endRoom:
        this.isRoomEnded = true;
        notifyListeners();
        break;
      case HMSActionResultListenerMethod.removePeer:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.acceptChangeRole:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.changeRole:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.changeTrackStateForRole:
        this.event = arguments['roles'] == null
            ? "Successfully Muted All"
            : "Successfully Muted Role";
        break;
      case HMSActionResultListenerMethod.startRtmpOrRecording:
        //TODO: HmsException?.code == 400(To see what this means)

        break;
      case HMSActionResultListenerMethod.stopRtmpAndRecording:
        break;
      case HMSActionResultListenerMethod.unknown:
        break;
      case HMSActionResultListenerMethod.changeName:
        // this.event = "Name Changed to ${localPeer!.name}";
        break;
      case HMSActionResultListenerMethod.sendBroadcastMessage:
        var message = HMSMessage(
            sender: localPeer,
            message: arguments['message'],
            type: arguments['type'],
            time: DateTime.now(),
            hmsMessageRecipient: HMSMessageRecipient(
                recipientPeer: null,
                recipientRoles: null,
                hmsMessageRecipientType: HMSMessageRecipientType.BROADCAST));
        addMessage(message);
        notifyListeners();
        break;
      case HMSActionResultListenerMethod.sendGroupMessage:
        var message = HMSMessage(
            sender: localPeer,
            message: arguments['message'],
            type: arguments['type'],
            time: DateTime.now(),
            hmsMessageRecipient: HMSMessageRecipient(
                recipientPeer: null,
                recipientRoles: arguments['roles'],
                hmsMessageRecipientType: HMSMessageRecipientType.GROUP));
        addMessage(message);
        notifyListeners();

        break;
      case HMSActionResultListenerMethod.sendDirectMessage:
        var message = HMSMessage(
            sender: localPeer,
            message: arguments['message'],
            type: arguments['type'],
            time: DateTime.now(),
            hmsMessageRecipient: HMSMessageRecipient(
                recipientPeer: arguments['peer'],
                recipientRoles: null,
                hmsMessageRecipientType: HMSMessageRecipientType.DIRECT));
        addMessage(message);
        notifyListeners();

        break;
      case HMSActionResultListenerMethod.hlsStreamingStarted:
        this.event = "HLS Streaming Started";
        hasHlsStarted = true;
        notifyListeners();
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.hlsStreamingStopped:
        hasHlsStarted = false;
        this.event = "HLS Streaming Stopped";
        notifyListeners();

        // TODO: Handle this case.
        break;

      case HMSActionResultListenerMethod.startScreenShare:
        this.event = "Screen Share Started";
        isScreenShareActive();
        break;

      case HMSActionResultListenerMethod.stopScreenShare:
        this.event = "Screen Share Stopped";
        isScreenShareActive();
        break;
    }
  }

  @override
  void onException(
      {HMSActionResultListenerMethod methodType =
          HMSActionResultListenerMethod.unknown,
      Map<String, dynamic> arguments,
      @required HMSException hmsException}) {
    this.hmsException = hmsException;
    switch (methodType) {
      case HMSActionResultListenerMethod.leave:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.changeTrackState:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.changeMetadata:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.endRoom:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.removePeer:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.acceptChangeRole:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.changeRole:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.changeTrackStateForRole:
        this.event = "Failed to Mute";
        break;
      case HMSActionResultListenerMethod.startRtmpOrRecording:
        if (hmsException.code?.errorCode == "400") {
          isRecordingStarted = true;
        }
        break;
      case HMSActionResultListenerMethod.stopRtmpAndRecording:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.unknown:
        break;
      case HMSActionResultListenerMethod.changeName:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.sendBroadcastMessage:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.sendGroupMessage:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.sendDirectMessage:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.hlsStreamingStarted:
        // TODO: Handle this case.
        break;
      case HMSActionResultListenerMethod.hlsStreamingStopped:
        // TODO: Handle this case.
        break;

      case HMSActionResultListenerMethod.startScreenShare:
        isScreenShareActive();
        break;

      case HMSActionResultListenerMethod.stopScreenShare:
        isScreenShareActive();
        break;
    }
  }

  Future<List<HMSPeer>> getPeers() async {
    return await _hmssdkInteractor.getPeers();
  }
}
