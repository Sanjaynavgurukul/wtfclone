import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uuid/uuid.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/screen/schedule/exercise/exercise_video.dart';

import 'Shimmer/widgets/rectangle.dart';
import 'image_galery.dart';

class AutoImageSlider<T> extends StatefulWidget {
  final bool positionedMarker;
  final PositionMarkerType markerType;
  final bool autoScroll;
  final Color inActiveMarkerColor;
  final Color activeMarkerColor;
  final double mainContainerHeight;
  final double childContainerHeight;
  final Function(int) deletePhoto;
//  final bool isImage;
  final List<String> items;
  final List<File> localItems;
  final bool showMarker;
  final bool showDelete;
  final double borderRadius;
  final double padding;
  final double dotSize;
  final bool showBorderDots;

  AutoImageSlider({
    this.positionedMarker,
    this.markerType,
    this.autoScroll,
    this.activeMarkerColor,
    this.inActiveMarkerColor,
    this.mainContainerHeight,
    this.deletePhoto,
//    this.isImage,
    this.items,
    this.localItems,
    this.childContainerHeight,
    this.showMarker = true,
    this.borderRadius,
    this.padding = 2.0,
    this.dotSize,
    this.showDelete = false,
    this.showBorderDots,
  });

  @override
  _AutoImageSliderState createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  List<File> get localItems => widget.localItems ?? null;

  bool get positionedMarker => widget.positionedMarker;
  double get mainContainerHeight => widget.mainContainerHeight;
  double get childContainerHeight => widget.childContainerHeight;
  PositionMarkerType get markerType => widget.markerType;
  bool get autoScroll => widget.autoScroll;
  Color get inActiveMarkerColor => widget.inActiveMarkerColor;
  Color get activeMarkerColor => widget.activeMarkerColor;
  List<String> get items => widget.items ?? null;
  int length = 0;

  static int currentIndex = 0;
  PageController imagesController =
      PageController(keepPage: true, initialPage: currentIndex);
  Timer autoSlideShowTimer;
  @override
  void initState() {
    initAutoScroll();
    super.initState();
  }

  @override
  void dispose() {
    autoSlideShowTimer?.cancel();
    imagesController?.dispose();

    super.dispose();
  }

  Future<void> initAutoScroll() async {
    print('Inside initAutoScroll');
    try {
      if (autoScroll) {
        //&& !touched
        autoSlideShowTimer = Timer.periodic(
          Duration(seconds: 1),
          (timer) {
            length = 0;
            length = items != null ? items.length : localItems.length;
            if (currentIndex < length) {
              imagesController.animateToPage(currentIndex++,
                  duration: Duration(seconds: 1), curve: Curves.easeInOut);
            } else {
              imagesController.animateToPage(0,
                  duration: Duration(seconds: 1), curve: Curves.easeInOut);
            }
          },
        );
      } else {
        length = 0;
        length = items != null ? items.length : localItems.length;
        print('length of images:: $length');
        print('items:: ${items.map((e) => e).toList()}');
      }
    } catch (e) {
      print('[[[AUTO IMAGE SLIDER ERROR]]]::: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    length = items != null ? items.length : localItems.length;
    return positionedMarker ? buildPositionedMarker() : buildNormalMarker();
  }

  Widget buildPositionedMarker() {
    return Container(
      height: mainContainerHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: <Widget>[
          PageView.custom(
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return items != null
                    ? Ink(
                        child: InkWell(
                          onTap: () {},
                          splashColor:
                              AppConstants.orangeColor.withOpacity(0.5),
                          highlightColor:
                              AppConstants.orangeColor.withOpacity(0.2),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.padding,
                              right: widget.padding,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius != null
                                      ? widget.borderRadius
                                      : 6.0),
                              child: items[index].endsWith('.mp4')
                                  ? AutoVideoSliderWidget(
                                      link: items[index],
                                    )
                                  : PhotoView(
                                      backgroundDecoration: BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      imageProvider: NetworkImage(items[index]),
                                      // tightMode: true,
                                      initialScale:
                                          PhotoViewComputedScale.contained,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: Uuid().v4()),
                                      minScale:
                                          PhotoViewComputedScale.contained,
                                      enableRotation: false,
                                      loadingBuilder: (context, chunk) =>
                                          RectangleShimmering(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      )
                    : Image.file(
                        localItems[index],
                        height: childContainerHeight,
                        fit: BoxFit.cover,
                        scale: 5.0,
                      );
              },
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              addSemanticIndexes: true,
              childCount: items != null ? items.length : localItems.length,
//              findChildIndexCallback: (Key key) {
//                final ValueKey valueKey = key;
//                final String data = valueKey.value;
//                return items.indexOf(data);
//              },
            ),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: imagesController,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
          ),
          widget.showMarker
              ? Positioned(
                  bottom: 20.0,
                  height: 6.0,
                  child: Center(
                    child: PositionMarker(
                      length: length,
                      index: currentIndex,
                      markerType: markerType,
                      showBorderDots: widget.showBorderDots,
                      inActiveMarkerColor: inActiveMarkerColor,
                      activeMarkerColor: activeMarkerColor,
                      size: widget.dotSize,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildNormalMarker() {
    return Container(
      height: mainContainerHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: childContainerHeight,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: PageView.custom(
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  print(
                      'FIle type:: ${items[index]} -->>>> ${items[index].endsWith('.mp4')}');
                  return items != null
                      ? InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageGalery(
                                  index: index,
                                  images: items,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.padding,
                              right: widget.padding,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius != null
                                    ? widget.borderRadius
                                    : 6.0,
                              ),
                              child: items[index].endsWith('.mp4')
                                  ? AutoVideoSliderWidget(
                                      link: items[index],
                                    )
                                  : PhotoView(
                                      imageProvider: NetworkImage(items[index]),
                                      tightMode: true,
                                      initialScale:
                                          PhotoViewComputedScale.contained,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: Uuid().v4()),
                                      minScale:
                                          PhotoViewComputedScale.contained,
                                      enableRotation: false,
                                      loadingBuilder: (context, chunk) =>
                                          RectangleShimmering(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                      ),
                                    ),
                            ),
                          ),
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.loose,
                          children: [
                            Image.file(
                              localItems[index],
                              fit: BoxFit.fill,
                              height: childContainerHeight,
                            ),
                            Positioned(
                              top: 12.0,
                              right: 20.0,
                              width: 36.0,
                              height: 36.0,
                              child: InkWell(
                                onTap: () async {
                                  widget.deletePhoto(index);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.delete,
                                    color: AppConstants.white,
                                    size: 18.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppConstants.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                },
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                addSemanticIndexes: true,
                childCount: items != null ? items.length : localItems.length,
//                findChildIndexCallback: (Key key) {
//                  final ValueKey valueKey = key;
//                  final String data = valueKey.value;
//                  return items.indexOf(data);
//                },
              ),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              controller: imagesController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
            ),
          ),
          Flexible(
            child: Center(
              child: PositionMarker(
                length: length,
                index: currentIndex,
                markerType: markerType,
                inActiveMarkerColor: inActiveMarkerColor,
                activeMarkerColor: activeMarkerColor,
                showBorderDots: widget.showBorderDots,
                size: widget.dotSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PositionMarker extends StatefulWidget {
  const PositionMarker({
    Key key,
    this.index,
    this.length,
    this.markerType,
    this.inActiveMarkerColor,
    this.activeMarkerColor,
    this.size = 20.0,
    this.showBorderDots = false,
  }) : super(key: key);

  final int index;
  final int length;
  final PositionMarkerType markerType;
  final Color inActiveMarkerColor;
  final Color activeMarkerColor;
  final double size;
  final bool showBorderDots;

  @override
  _PositionMarkerState createState() => _PositionMarkerState();
}

enum PositionMarkerType { dots, dashes }

class _PositionMarkerState extends State<PositionMarker>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int get index => widget.index;
  PositionMarkerType get markerType => widget.markerType;
  Color get inActiveMarkerColor => widget.inActiveMarkerColor;
  Color get activeMarkerColor =>
      widget.activeMarkerColor ?? AppConstants.orangeColor;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (markerType == PositionMarkerType.dashes) {
      return Container(
        // height: 6.0,
        child: ListView.separated(
          itemBuilder: (context, imgIndex) => buildDashMarker(imgIndex),
          separatorBuilder: (context, int) => SizedBox(width: 6.0),
          scrollDirection: Axis.horizontal,
          itemCount: widget.length,
          shrinkWrap: true,
        ),
      );
    } else {
      return ListView.separated(
        itemBuilder: (context, imgIndex) => buildDotsMarker(imgIndex),
        separatorBuilder: (context, int) => SizedBox(width: 6.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.length,
        shrinkWrap: true,
      );
    }
  }

  Widget buildDashMarker(int imgIndex) {
    return index == imgIndex
        ? AnimatedContainer(
            width: widget.size,
            height: widget.size,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              // border: Border.all(
              //   width: 1.5,
              //   color: widget.showBorderDots
              //       ? AppConstants.black
              //       : AppConstants.lightGrey.withOpacity(0.5),
              //   style: BorderStyle.solid,
              // ),
              color: activeMarkerColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
          )
        : AnimatedContainer(
            width: widget.size,
            height: widget.size,
            margin: const EdgeInsets.only(top: 1.5, bottom: 1.5),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.showBorderDots
                    ? AppConstants.black
                    : AppConstants.lightGrey.withOpacity(0.5),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              color: inActiveMarkerColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
          );
  }

  Widget buildDotsMarker(int imgIndex) {
    return index == imgIndex
        ? AnimatedContainer(
            width: widget.size,
            height: widget.size,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              // border: Border.all(
              //   width: 1.5,
              //   color: widget.showBorderDots
              //       ? AppConstants.black
              //       : AppConstants.lightGrey.withOpacity(0.5),
              //   style: BorderStyle.solid,
              // ),
              color: activeMarkerColor,
              shape: BoxShape.circle,
            ),
          )
        : Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: widget.showBorderDots
                    ? AppConstants.black
                    : AppConstants.lightGrey.withOpacity(0.5),
                style: BorderStyle.solid,
              ),
              color: inActiveMarkerColor,
              shape: BoxShape.circle,
            ),
          );
  }
}
