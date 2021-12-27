import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/Toast.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/model/add_on_slot_details.dart';
import 'package:wtf/widget/progress_loader.dart';

class ChooseSlotAddonScreen extends StatefulWidget {
  @override
  _ChooseSlotAddonScreenState createState() => _ChooseSlotAddonScreenState();
}

class _ChooseSlotAddonScreenState extends State<ChooseSlotAddonScreen> {
  GymStore gymStore;

  DateTime selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    gymStore = context.read<GymStore>();
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        title: Text(
          'Choose your Slot',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (gymStore.selectedSlotData != null) {
                if (gymStore.isFreeSession) {
                  NavigationService.navigateTo(Routes.bookingSummaryAddOn);
                } else {
                  gymStore.checkSlotAvailability(
                    context: context,
                    slotId: gymStore.selectedSlotData.uid,
                  );
                }
              } else {
                Toast(
                  text: 'Please select a slot',
                  bgColor: Colors.red,
                  textColor: Colors.white,
                  textFontSize: 14.0,
                )..showDialog(context);
              }
            },
            child: Text(
              'DONE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<GymStore>(
          builder: (context, gymStore, child) => Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  height: 90.0,
                  child: DatePicker(DateTime.now(),
                      initialSelectedDate: selectedValue,
                      selectionColor: AppConstants.primaryColor,
                      selectedTextColor: Colors.white,
                      deactivatedColor: Colors.white, onDateChange: (date) {
                    // New date selected
                    print(
                        'selectedDate: ${Helper.formatDate2(date.toIso8601String())}');
                    gymStore.getSlotDetails(
                      context: context,
                      date: Helper.formatDate2(
                        date.toIso8601String(),
                      ),
                      addOnId: gymStore.selectedAddOnSlot.uid,
                      trainerId: null,
                    );
                  }),
                ),
                Expanded(
                  flex: 8,
                  child: Consumer<GymStore>(
                    builder: (context, gymStore, child) {
                      print(
                          'len: ${gymStore.selectedSlotDetails?.data?.length}');
                      return gymStore.selectedSlotDetails == null
                          ? Container(
                              height: 300,
                              child: Loading(),
                            )
                          : gymStore.selectedSlotDetails.data.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Slots available',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => gymStore
                                            .selectedSlotDetails
                                            .data[index]
                                            .data
                                            .isNotEmpty
                                        ? SlotRowWidget(
                                            data: gymStore.selectedSlotDetails
                                                .data[index])
                                        : Container(),
                                    itemCount: gymStore
                                        .selectedSlotDetails.data.length,
                                    shrinkWrap: true,
                                  ),
                                );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }
}

class SlotRowWidget extends StatefulWidget {
  final AddOnSlotDetailsData data;

  SlotRowWidget({this.data});

  @override
  _SlotRowWidgetState createState() => _SlotRowWidgetState();
}

class _SlotRowWidgetState extends State<SlotRowWidget> {
  AddOnSlotDetailsData get data => widget.data;
  GymStore gymStore;
  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 30.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.4),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                data.key,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 12.0,
              runSpacing: 12.0,
              children: gymStore.selectedSlotDetails.data != null
                  ? data.data
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            if (gymStore.selectedSlotData == e) {
                              setState(() {
                                gymStore.setSlotData(null);
                              });
                            } else {
                              gymStore.setSlotData(e);
                            }
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              color: gymStore.selectedSlotData == e
                                  ? AppConstants.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 8.0,
                              ),
                              child: Text(
                                e.startTime,
                                style: TextStyle(
                                  color: gymStore.selectedSlotData == e
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()
                  : [],
            ),
          ),
        ],
      ),
    );
  }
}
