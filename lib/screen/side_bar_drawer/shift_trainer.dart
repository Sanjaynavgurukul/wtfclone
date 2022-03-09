import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';

class ShiftTrainer extends StatefulWidget {
  const ShiftTrainer({Key key}) : super(key: key);

  @override
  _ShiftTrainerState createState() => _ShiftTrainerState();
}

class _ShiftTrainerState extends State<ShiftTrainer> {
  String newTrainer = '';
  final textController = TextEditingController();
  GymStore gymStore;
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
    return Scaffold(
      key: key,
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Shift Trainer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            if (newTrainer.isNotEmpty) {
              if (textController.text.isNotEmpty)
                context
                    .read<GymStore>()
                    .shiftTrainer(
                        newTrainer: newTrainer, reason: textController.text)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Shift trainer requested',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ));
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              else
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Reason should not be empty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ));
            } else
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Select new trainer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Submit Request',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.done),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: newTrainer.isNotEmpty ? AppConstants.primaryColor : null,
              padding: EdgeInsets.all(10)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              '${gymStore.activeSubscriptions.data?.gymName ?? ""}',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white70,
                  fontWeight: FontWeight.w700),
            ),
            UIHelper.verticalSpace(20.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Current Trainer: ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: newTrainer.isNotEmpty ? newTrainer : "No Trainer",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(20.0),
            ElevatedButton(
              onPressed: () => gymStore.newTrainers == null ?   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Please  buy subscription',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )): _modalBottomSheetMenu(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose trainer',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
              ),
            ),
            UIHelper.verticalSpace(20.0),
            TextField(
              controller: textController,
              decoration: new InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Reason for shifting trainer',
              ),
              style: TextStyle(color: Colors.white),
            ),
            UIHelper.verticalSpace(20.0),
            if (newTrainer.isNotEmpty)
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'New Trainer: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                  TextSpan(
                    text: newTrainer,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
              ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(context) {
    showModalBottomSheet(
        enableDrag: true,
        backgroundColor: Colors.black,
        // isDismissible: false,
        context: context,
        builder: (builder) {
          return gymStore.newTrainers.data == null
              ? CircularProgressIndicator()
              : gymStore.newTrainers.data.isEmpty
                  ? Center(child: Text('No Trainers available'))
                  : Container(
                      height: Get.height -
                          (kToolbarHeight + Get.height * 0.44 + 40),
                      decoration: new BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: ListView.builder(
                          itemCount: gymStore.newTrainers.data.length,
                          itemBuilder: (context, index) => ListTile(
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white70,
                                ),
                                title: Text(
                                  gymStore.newTrainers.data[index].name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  setState(() => newTrainer =
                                      gymStore.newTrainers.data[index].name);
                                  Navigator.of(context).pop();
                                },
                              )),
                    );
        });
  }
}
