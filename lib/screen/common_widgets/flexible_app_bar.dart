import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/screen/schedule/exercise/exercise_video.dart';
import 'package:wtf/screen/schedule/new/ex_start_screen.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';
import 'package:wtf/widget/auto_image_slider.dart';

class FlexibleAppBar extends StatefulWidget {
  final List<Gallery> images;
  final Color color;

  const FlexibleAppBar({this.images, this.color});

  @override
  State<FlexibleAppBar> createState() => _FlexibleAppBarState();
}

class _FlexibleAppBarState extends State<FlexibleAppBar> {
  final double appBarHeight = 66.0;
  CarouselController carouselController;
  bool isAutoPlay = true;
  bool speaketOff = true;
  bool onVolume = false;
  bool hasVideo = false;
  int videoIndex = 0;


  List<Gallery> slider = [
    Gallery(
        images:
        'https://d1gzvbhpg92x41.cloudfront.net/workout_upload/TBLzo5i6OrtXo/1650287910669-cominghh_soon_-_42890%20%28Original%29.mp4',
        type: 'video'),
    Gallery(
        images: 'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
        type: 'image')
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      color: widget.color,
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          // child:
          // CarouselSlider.builder(
          //   carouselController: carouselController,
          //     options: CarouselOptions(
          //       height: 330.0,
          //       viewportFraction: 1,
          //       enlargeCenterPage: false,
          //       pageSnapping: true,
          //       autoPlay: isAutoPlay,
          //       autoPlayInterval: Duration(seconds: 3),
          //       autoPlayAnimationDuration: Duration(milliseconds: 800),
          //       onPageChanged:(i,val){
          //         setState(() {
          //           this.isAutoPlay = true;
          //           carouselController.startAutoPlay();
          //         });
          //       }
          //     ),
          //     itemCount: widget.images.length,
          //     itemBuilder: (BuildContext context, int itemIndex,
          //         int pageViewIndex) {
          //       var i = widget.images[itemIndex];
          //       if (i.type == 'video') {
          //         print('check video index == $itemIndex');
          //         return VideoPlayerScreen(url: i.images, isPlaying: (val) {
          //           if (val) {
          //             print('video is playing -=- true');
          //             setState(() {
          //               this.isAutoPlay = false;
          //               this.videoIndex = itemIndex;
          //             });
          //           } else {
          //             setState(() {
          //               this.isAutoPlay = true;
          //             });
          //             print('video is playing -=- false');
          //           }
          //         },
          //           enableVolume: onVolume,
          //         onVolume: (val){
          //             this.onVolume = val;
          //           },);
          //       } else {
          //         return ClipRRect(
          //           borderRadius: BorderRadius.circular(0.0),
          //           child: Builder(
          //             builder: (BuildContext context) {
          //               return Container(
          //                 decoration: BoxDecoration(
          //                     borderRadius:
          //                     BorderRadius.all(Radius.circular(0))),
          //                 child: Image.network(
          //                   i.images,
          //                   errorBuilder: (context, error, stackTrace) {
          //                     return Center(
          //                         child: Text(
          //                           "Failed to load image",
          //                         ));
          //                   },
          //                   loadingBuilder: (BuildContext context,
          //                       Widget child,
          //                       ImageChunkEvent loadingProgress) {
          //                     if (loadingProgress == null) return child;
          //                     return Center(
          //                       child: CircularProgressIndicator(
          //                         value: loadingProgress.expectedTotalBytes !=
          //                             null
          //                             ? loadingProgress
          //                             .cumulativeBytesLoaded /
          //                             loadingProgress.expectedTotalBytes
          //                             : null,
          //                       ),
          //                     );
          //                   },
          //                   fit: BoxFit.fill,
          //                   width: double.infinity,
          //                   height: double.infinity,
          //                 ),
          //               );
          //             },
          //           ),
          //         );
          //       }
          //     }
          // )
          child: CarouselSlider(
          options: CarouselOptions(
            height: 330.0,
            viewportFraction: 1,
            enlargeCenterPage: false,
            pageSnapping: true,
            autoPlay: isAutoPlay,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
          ),
          items: widget.images.map(
                (i) {
                  if (i.images == null) {
                    return Center(
                      child: Text("No image data"),
                    );
                  } else {
                    if (i.type == 'video') {
                      return VideoPlayerScreen(
                        url: i.images, isPlaying: (
                          val) {
                        if (val) {
                          print('video is playing -=- true');
                          setState(() {
                            this.isAutoPlay = false;
                          });
                        } else {

                          setState(() {
                            this.isAutoPlay = true;
                          });
                          print('video is playing -=- false');
                        }
                      },);
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(0))),
                        child: Image.network(
                          i.images,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                                child: Text(
                                  "Failed to load image",
                                ));
                          },
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    }
                  }
            },
          ).toList()),
    ),);
  }
}
