import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';

class ComingSoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ComingSoonCard(
              text: '50+ Fitness Centers in Noida',
              image: Images.comingSoonNoida,
            ),
          ),
          UIHelper.horizontalSpace(8.0),
          Expanded(
            flex: 1,
            child: ComingSoonCard(
              text: '80+ Fitness Centers in Delhi',
              image: Images.comingSoonDelhi,
            ),
          ),
          UIHelper.horizontalSpace(8.0),
          Expanded(
            flex: 1,
            child: ComingSoonCard(
              text: '45+ Fitness Centers in Gurgaon',
              image: Images.comingSoonGurgaon,
            ),
          )
        ],
      ),
    );
  }
}

class ComingSoonCard extends StatelessWidget {
  final String text;
  final String image;

  ComingSoonCard({
    this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppConstants.primaryColor,
                ],
                stops: [0, 1.0],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
