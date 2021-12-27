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

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Shift trainer',
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
                    content: Text('Shift trainer requested'),
                  ));
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              else
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Reason should not be empty'),
                ));
            } else
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Select new trainer'),
              ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Submit Request',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.done),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: newTrainer.isNotEmpty ? Color(0xffff0000) : null,
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
                    ),
                  ),
                  TextSpan(
                    text: newTrainer.isNotEmpty ? newTrainer : "No Trainer",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(20.0),
            ElevatedButton(
              onPressed: () => _modalBottomSheetMenu(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose trainer',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffff0000), padding: EdgeInsets.all(10)),
            ),
            UIHelper.verticalSpace(20.0),
            TextField(
              controller: textController,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
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
