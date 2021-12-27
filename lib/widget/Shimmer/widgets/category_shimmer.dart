import 'package:flutter/material.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/Shimmer/widgets/circle.dart';
import 'package:wtf/widget/Shimmer/widgets/line.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';

import '../shimmering.dart';

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleShimmer(
                width: 50.0,
                height: 50.0,
              ),
            ),
            itemCount: 10,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

class ListShimmer extends StatelessWidget {
  final int count;
  final double height;

  ListShimmer({
    this.count = 6,
    this.height = 120.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      primary: false,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
        ),
        child: ShimmerWidget.rectangle(
          width: MediaQuery.of(context).size.width - 24.0,
          height: height,
        ),
      ),
    );
  }
}

class GridShimmer extends StatelessWidget {
  final int count;

  GridShimmer({this.count = 6});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 2.0,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.525,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        itemCount: count,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(-1, 0),
                spreadRadius: 2.0,
                blurRadius: 3.0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RectangleShimmering(width: double.infinity, height: 150.0),
                    UIHelper.verticalSpace(6.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 8.0,
                        top: 4.0,
                      ),
                      child: LineShimmer(
                        height: 20.0,
                        width: 100.0,
                        radius: 4.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 8.0,
                        top: 4.0,
                      ),
                      child: LineShimmer(
                        height: 30.0,
                        width: 100.0,
                        radius: 4.0,
                      ),
                    ),
                    UIHelper.verticalSpace(8.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 8.0,
                        top: 4.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LineShimmer(
                            height: 20.0,
                            width: 50.0,
                            radius: 4.0,
                          ),
                          LineShimmer(
                            height: 20.0,
                            width: 60.0,
                            radius: 4.0,
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(4.0),
                    Divider(
                      height: 0.8,
                      color: Colors.black.withOpacity(0.3),
                      thickness: 0.5,
                      endIndent: 0.0,
                      indent: 0.0,
                    ),
                    UIHelper.verticalSpace(12.0),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: CircleShimmer(
                              width: 36.0,
                              height: 36.0,
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: LineShimmer(
                                    height: 20.0,
                                    width: 60.0,
                                    radius: 4.0,
                                  ),
                                ),
                                UIHelper.verticalSpace(6.0),
                                LineShimmer(
                                  height: 20.0,
                                  width: 60.0,
                                  radius: 4.0,
                                ),
                                UIHelper.verticalSpace(6.0),
                                LineShimmer(
                                  height: 20.0,
                                  width: 60.0,
                                  radius: 4.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: LineShimmer(
                          height: 20.0,
                          width: 40.0,
                          radius: 4.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
