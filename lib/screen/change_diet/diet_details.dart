import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

class DietDetails extends StatefulWidget {
  const DietDetails({Key key}) : super(key: key);
  static const String routeName = '/dietDetails';

  @override
  _DietDetailsState createState() => _DietDetailsState();
}

class _DietDetailsState extends State<DietDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: getPadding(),
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Image(image: AssetImage('assets/images/egg.png')),
          ),
          Padding(
            padding: getPadding(),
            child: Text('Omelete Brunch',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 36,
                    fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              padding: getPadding(),
              alignment: Alignment.topLeft,
              child: Text('Description',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.white))),
          Padding(
            padding: getPadding(),
            child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fermentum a, dis lacus, erat. Penatibus egestas bibendum mi eu, scelerisque ultrices nisl eu, amet. Nam vestibulum risus viverra morbi proin. Cursus facilisi accumsan aliquam euismod placerat. Aliquam facilisis erat nec quis.',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Colors.white)),
          ),
          SizedBox(
            height: 20,
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(),
                child: Text('Ingredients',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Colors.white)),
              ),
              Container(
                width: double.infinity,
                color: AppConstants.primaryColor,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('You are using free diet plan',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            color: Colors.white)),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxWidth: 250, maxHeight: 56),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: AppConstants.bgColor),
                      child: Text('Buy this',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          )

          // Expanded(
          //   flex: 5,
          //   child: Container(),
          // ),
          // Expanded(
          //   flex: 3,
          //   child: Stack(
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //               padding: EdgeInsets.only(left: 12, right: 12),
          //               child: Text('Ingredients')),
          //           Expanded(
          //             child: Container(
          //               margin: EdgeInsets.only(top: 6),
          //               color: AppConstants.primaryColor,
          //             ),
          //           )
          //         ],
          //       ),
          //       Container(
          //         alignment: Alignment.topCenter,
          //         child: Icon(
          //           Icons.lock,
          //           size: 40,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  EdgeInsets getPadding() {
    return EdgeInsets.only(left: 12, right: 12, bottom: 18);
  }
}
