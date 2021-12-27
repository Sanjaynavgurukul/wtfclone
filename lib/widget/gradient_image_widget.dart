import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

import 'Shimmer/widgets/rectangle.dart';

class GradientImageWidget extends StatelessWidget {
  final BorderRadius borderRadius;
  final List<Color> gragientColor;
  final List<double> stops;
  final String assets;
  final String network;
  final BoxFit boxFit;
  GradientImageWidget(
      {this.borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      this.gragientColor,
      this.stops,
      this.assets,
      this.network,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              // BorderRadius.all(Radius.circular(16.0)),
              color: Colors.transparent,
              // image: DecorationImage(
              //   fit: boxFit != null ? boxFit : BoxFit.cover,
              //   image: assets != null
              //       ? AssetImage(assets)
              //       : CachedNetworkImageProvider(
              //           network ??
              //               'https://www.mensjournal.com/wp-content/uploads/2018/05/1380-dumbbell-curl1.jpg?quality=86&strip=all',
              //         ),
              // ),
            ),
            child: assets != null
                ? Image.asset(
                    assets,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: double.infinity,
                  )
                : Image.network(
                    network ??
                        'https://www.mensjournal.com/wp-content/uploads/2018/05/1380-dumbbell-curl1.jpg?quality=86&strip=all',
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: double.infinity,
                    loadingBuilder: (context, _, chunk) => chunk == null
                        ? _
                        : RectangleShimmering(
                            width: double.infinity,
                            radius: 16.0,
                          ),
                  ),
            // height: 350.0,
          ),
        ),
        Container(
          // height: 350.0,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: gragientColor == null
                  ? [
                      Colors.transparent,
                      AppConstants.primaryColor,
                    ]
                  : gragientColor,
              stops: stops == null ? [0.3, 1.0] : stops,
            ),
          ),
        )
      ],
    );
  }
}
