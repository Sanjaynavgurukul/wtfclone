import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ExerciseVideo extends StatelessWidget {
  const ExerciseVideo({Key key, this.controller, this.onPausePlay})
      : super(key: key);
  final controller, onPausePlay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.28,
      child: InkWell(
        onTap: onPausePlay,
        child: Stack(
          children: [
            AspectRatio(
              child: VideoPlayer(
                controller,
              ),
              aspectRatio: controller.value.aspectRatio,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child:
                    VideoProgressIndicator(controller, allowScrubbing: true)),
            Positioned(
              bottom: 14.0,
              left: 8.0,
              child: GestureDetector(
                child: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 16.0,
                ),
                onTap: onPausePlay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AutoVideoSliderWidget extends StatefulWidget {
  const AutoVideoSliderWidget({
    Key key,
    @required this.link,
  }) : super(key: key);

  final String link;

  @override
  State<AutoVideoSliderWidget> createState() => _AutoVideoSliderWidgetState();
}

class _AutoVideoSliderWidgetState extends State<AutoVideoSliderWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.link,
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) {
        _controller.play();
        _controller.addListener(() {});
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.28,
      child: InkWell(
        onTap: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Stack(
          children: [
            AspectRatio(
              child: VideoPlayer(
                _controller,
              ),
              aspectRatio: _controller.value.aspectRatio,
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: VideoProgressIndicator(
            //     _controller,
            //     allowScrubbing: false,
            //     colors: VideoProgressColors(
            //       bufferedColor: AppConstants.white,
            //       playedColor: AppConstants.primaryColor,
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 14.0,
              left: 8.0,
              child: GestureDetector(
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 16.0,
                ),
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
