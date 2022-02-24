import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wtf/helper/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 54),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: 12,
                ),
                padding: EdgeInsets.only(top: 6, bottom: 6, right: 6, left: 12),
                height: 54,
                decoration: BoxDecoration(
                    color: AppConstants.black,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Text('Explore WTF fitness center near you',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal)),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppConstants.boxBorderColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Icon(
                        Icons.search,
                        color: AppConstants.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppConstants.white,
                    ),
                    Text('Change')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
