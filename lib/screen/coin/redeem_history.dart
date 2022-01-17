import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/custom_action_button.dart';
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
        body: store.redeemHistory != null
            ? store.redeemHistory.data != null &&
                    store.redeemHistory.data.isNotEmpty
                ? Container(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: store.redeemHistory.data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          //dense: true,
                          isThreeLine: true,
                          title: Text(
                            store.redeemHistory.data[i].offerName ?? "",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                                text:
                                    (store.redeemHistory.data[i].offerDetails ??
                                            "") +
                                        '\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                  color: Colors.white54,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: UIHelper.parse(store
                                            .redeemHistory.data[i].dateAdded
                                            .toString() ??
                                        ""),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: Colors.white54,
                                    ),
                                  )
                                ]),
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                store.redeemHistory.data[i].offerCode ?? "",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppConstants.boxBorderColor,
                                  fontFamily: Fonts.ROBOTO,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                          text: store
                                              .redeemHistory.data[i].offerCode))
                                      .then((result) {
                                    Fluttertoast.showToast(
                                        msg: "Coupon code copied");
                                  });
                                },
                                child: CustomActionButton(
                                  label: "Copy Code",
                                  height: 20,
                                  width: 100,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return Container(
                          width: double.infinity,
                          child: Divider(color: Colors.black54),
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
                      )
            : Center(
                child: Text(
                  'No Redeem History Available!',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white70),
                ),
              ),
      ),
    );
  }
}
