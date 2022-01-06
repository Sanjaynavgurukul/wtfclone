import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/widget/progress_loader.dart';

class PointHistory extends StatefulWidget {
  const PointHistory({Key key}) : super(key: key);

  @override
  _PointHistoryState createState() => _PointHistoryState();
}

class _PointHistoryState extends State<PointHistory> {
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Point History'),
            backgroundColor: AppConstants.primaryColor),
        backgroundColor: AppConstants.appBackground,
        body: store.coinHistory != null
            ? store.coinHistory.data != null &&
                    store.coinHistory.data.isNotEmpty
                ? Container(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: store.coinHistory.data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          dense: true,
                          title: Text(
                            store.coinHistory.data[i].label,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            store.coinHistory.data[i].dateAdded,
                            // '9:00 AM 13th December',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Colors.white54,
                            ),
                          ),
                          trailing: Text(
                            store.coinHistory.data[i].type == 'DR'
                                ? "- " +
                                    store.coinHistory.data[i].coins.toString()
                                : "+ " +
                                    store.coinHistory.data[i].coins.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: store.coinHistory.data[i].type == 'DR'
                                  ? AppConstants.boxBorderColor
                                  : AppConstants.whatsApp,
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
                : store.coinHistory.data.isNotEmpty
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Loading(),
                      )
                    : Center(
                        child: Text(
                          'No Coin History Available!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white70),
                        ),
                      )
            : Align(
                alignment: Alignment.topCenter,
                child: Loading(),
              ),
      ),
    );
  }
}
