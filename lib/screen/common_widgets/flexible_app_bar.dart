import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';

class FlexibleAppBar extends StatelessWidget {
  final List<Gallery> images;
  final Color color;

  final double appBarHeight = 66.0;

  const FlexibleAppBar({this.images, this.color});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      color: color,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: CarouselSlider(
            options: CarouselOptions(
              height: 330.0,
              viewportFraction: 1,
              enlargeCenterPage: false,
              autoPlay: true,
              pageSnapping: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ),
            items: images.map(
                  (i) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Builder(
                    builder: (BuildContext context) {
                      if (i.images == null) {
                        return Center(
                          child: Text("No image data"),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Image.network(
                          i.images,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, _, chunk) => chunk == null
                              ? _
                              : RectangleShimmering(
                            width: double.infinity,
                            height: 180.0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ).toList()),
      ),
    );
  }
}