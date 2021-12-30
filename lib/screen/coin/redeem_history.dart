import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/progress_loader.dart';

class RedeemHistory extends StatefulWidget {
  const RedeemHistory({Key key}) : super(key: key);

  @override
  _RedeemHistoryState createState() => _RedeemHistoryState();
}

class _RedeemHistoryState extends State<RedeemHistory> {
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Text('Redeem History'),
                backgroundColor: AppConstants.primaryColor),
            backgroundColor: AppConstants.appBackground,
            body: store.redeemHistory.data != null &&
                    store.redeemHistory.data.isNotEmpty
                ? Container(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: store.redeemHistory.data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          dense: true,
                          title: Text(
                            store.redeemHistory.data[i].label,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            UIHelper.parse(store.redeemHistory.data[i].dateAdded
                                .toString()),
                            // '9:00 AM 13th December',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Colors.white54,
                            ),
                          ),
                          trailing: Text(
                            // store.redeemHistory.data[i].type == 'DR'
                            //     ?
                            "- " + store.redeemHistory.data[i].coins.toString(),
                            // : "+ " +
                            //     store.redeemHistory.data[i].coins.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color:
                                  // store.redeemHistory.data[i].type == 'DR'
                                  //     ?
                                  AppConstants.boxBorderColor,
                              // : AppConstants.whatsApp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return Container(
                          width: double.infinity,
                          child: Divider(color: Colors.white24),
                        );
                      },
                    ),
                  )
                : store.redeemHistory.data.isNotEmpty
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Loading(),
                      )
                    : Center(
                        child: Text(
                          'No Redeem History Available!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white70),
                        ),
                      )));
  }
}
