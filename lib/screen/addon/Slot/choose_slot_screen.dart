import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/Toast.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/add_on_slot_details.dart';
import 'package:wtf/widget/progress_loader.dart';

class ChooseSlotScreen extends StatefulWidget {
  @override
  _ChooseSlotScreenState createState() => _ChooseSlotScreenState();
}

class _ChooseSlotScreenState extends State<ChooseSlotScreen> {
  GymStore gymStore;

  DateTime selectedValue = DateTime.now();

  // TrainerData selectedTrainer;

  @override
  Widget build(BuildContext context) {
    gymStore = context.read<GymStore>();
    print('check free session --- ${gymStore.isFreeSession}');
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        title: Text(
          'Choose your slot',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
        actions: [
          TextButton(
            onPressed: () async {
              if (gymStore.selectedSlotData != null) {
                if (gymStore.isFreeSession) {
                  NavigationService.navigateTo(Routes.bookingSummaryAddOn);
                } else {
                  await gymStore.checkSlotAvailability(
                    context: context,
                    slotId: gymStore.selectedSlotData.uid,
                  );
                  // gymStore.getAllSessionsForAddOn(
                  //   context: context,
                  // );
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
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: selectedValue,
                    selectionColor: AppConstants.primaryColor,
                    selectedTextColor: Colors.white,
                    deactivatedColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                      print(
                          'selectedDate: ${Helper.formatDate2(date.toIso8601String())}');
                      if (gymStore.selectedTrainer != null) {
                        setState(() {
                          selectedValue = date;
                        });
                        gymStore.getSlotDetails(
                          context: context,
                          date: Helper.formatDate2(
                            date.toIso8601String(),
                          ),
                          addOnId: gymStore.selectedAddOnSlot.uid,
                          trainerId: gymStore.selectedTrainer.trainerId,
                        );
                        gymStore.getAddonMySchedules(
                          date: Helper.formatDate2(
                            date.toIso8601String(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Consumer<GymStore>(
                  builder: (context, store, child) => gymStore
                              .selectedGymTrainers !=
                          null
                      ? gymStore.selectedGymTrainers.data != null
                          ? InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  builder: (context) => IntrinsicHeight(
                                    child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        // height: 350.0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: gymStore
                                              .selectedGymTrainers.data
                                              .map((e) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 12.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (gymStore
                                                                .selectedTrainer ==
                                                            e) {
                                                          setState(() {
                                                            gymStore.selectedTrainer =
                                                                null;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            gymStore
                                                                .selectedTrainer = e;
                                                          });
                                                          gymStore
                                                              .getSlotDetails(
                                                            context: context,
                                                            date: Helper
                                                                .formatDate2(
                                                              selectedValue
                                                                  .toIso8601String(),
                                                            ),
                                                            addOnId: gymStore
                                                                .selectedAddOnSlot
                                                                .uid,
                                                            trainerId: gymStore
                                                                .selectedTrainer
                                                                .trainerId,
                                                          );
                                                          gymStore
                                                              .getAddonMySchedules(
                                                            date: Helper
                                                                .formatDate2(
                                                              selectedValue
                                                                  .toIso8601String(),
                                                            ),
                                                          );
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: Ink(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 6.0,
                                                            vertical: 12.0,
                                                          ),
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                e.name,
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                              if (gymStore
                                                                      .selectedTrainer ==
                                                                  e)
                                                                ChoiceChip(
                                                                  label: Text(
                                                                    'Selected',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  selected:
                                                                      true,
                                                                  backgroundColor:
                                                                      AppConstants
                                                                          .primaryColor,
                                                                  selectedColor:
                                                                      AppConstants
                                                                          .primaryColor,
                                                                )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        )),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppConstants.buttonRed2,
                                      AppConstants.buttonRed1,
                                    ],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      gymStore.selectedTrainer != null
                                          ? gymStore.selectedTrainer.name
                                          : 'Select a Trainer',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(6.0),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            )
                          : Text(
                              'No Trainers Available',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                      : Container(),
                ),
                // Consumer<GymStore>(
                //   builder: (context, gymStore, child) => Padding(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 16.0,
                //       vertical: 10.0,
                //     ),
                //     child: DropdownButton(
                //       items: gymStore.selectedGymTrainers.data
                //           .map(
                //             (e) => DropdownMenuItem(
                //               value: e.trainerId,
                //               child: Text(
                //                 e.name,
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                 ),
                //               ),
                //             ),
                //           )
                //           .toList(),
                //       value: gymStore.selectedTrainer != null
                //           ? gymStore.selectedTrainer.trainerId
                //           : null,
                //       isDense: true,
                //       hint: Text(
                //         "Select a Trainer",
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       ),
                //       isExpanded: true,
                //       iconEnabledColor: AppConstants.primaryColor,
                //       icon: Icon(
                //         Icons.arrow_drop_down,
                //         color: AppConstants.white,
                //         size: 30.0,
                //       ),
                //       iconSize: 30.0,
                //       onChanged: (val) {
                //         setState(() {
                //           gymStore.selectedTrainer = gymStore
                //               .selectedGymTrainers.data
                //               .where((element) => element.trainerId == val)
                //               .toList()[0];
                //         });
                //         gymStore.getSlotDetails(
                //           context: context,
                //           date: Helper.formatDate2(
                //             selectedValue.toIso8601String(),
                //           ),
                //           addOnId: gymStore.selectedAddOnSlot.uid,
                //           trainerId: gymStore.selectedTrainer.trainerId,
                //         );
                //         gymStore.getAddonMySchedules(
                //           date: Helper.formatDate2(
                //             selectedValue.toIso8601String(),
                //           ),
                //         );
                //       },
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
                Consumer<GymStore>(
                  builder: (context, store, child) =>
                      store.addonMySchedules != null &&
                              store.addonMySchedules.data != null &&
                              store.addonMySchedules.data.addon.isNotEmpty
                          ? IntrinsicHeight(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 12.0,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.primaryColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    UIHelper.horizontalSpace(12.0),
                                    Flexible(
                                      child: Text(
                                        'Note: You already have a Subscription for ${store.addonMySchedules.data.addon.map((e) => e.addonName).toList().join(',')}',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
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
                              child: gymStore.selectedTrainer != null
                                  ? Loading()
                                  : Center(
                                      child: Text(
                                        'Please select a Trainer first.',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
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
                                                .data[index],
                                          )
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

  @override
  void dispose() {
    gymStore.setGymId(null);
    super.dispose();
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
            color: AppConstants.primaryColor,
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
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16.0,
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
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 12.0,
                              ),
                              child: Text(
                                e.startTime,
                                style: GoogleFonts.lato(
                                  color: gymStore.selectedSlotData == e
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
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
