import 'package:flutter/material.dart';
import 'package:wtf/100ms/meeting/peer_track_node.dart';
import 'package:provider/provider.dart';

class NetworkIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<PeerTrackNode, int>(
        builder: (_, networkQuality, __) {
          return networkQuality != -1
              ? Positioned(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Image.asset(
                      'assets/icons/network_$networkQuality.png',
                      scale: 2,
                    ),
                  ),
                  top: 5.0,
                  left: 5.0,
                )
              : Container();
        },
        selector: (_, peerTrackNode) => peerTrackNode.networkQuality);
  }
}
