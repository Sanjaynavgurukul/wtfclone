import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/widget/text_field.dart';

class SubmissionDetail extends StatefulWidget {
  const SubmissionDetail({Key key}) : super(key: key);

  @override
  State<SubmissionDetail> createState() => _SubmissionDetailState();
}

class _SubmissionDetailState extends State<SubmissionDetail> {
  int _processIndex = 1;

  TextEditingController fbController, instaController, twitterController;

  @override
  void initState() {
    fbController = TextEditingController();
    instaController = TextEditingController();
    twitterController = TextEditingController();
    if (context.read<GymStore>().selectedSubmissions != null &&
        context.read<GymStore>().selectedSubmissions.isNotEmpty)
      _processIndex = context.read<GymStore>().selectedSubmissions.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        title: Text(
          locator<AppPrefs>().selectedSubmission.getValue(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
      bottomNavigationBar: store.activeSubscriptions != null &&
              store.activeSubscriptions.data != null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  // LocalValue.GYM_ID = store.activeSubscriptions.data.gymId;
                  store.setRenew(true);
                  await store.getGymDetails(
                    context: context,
                    gymId: store.activeSubscriptions.data.gymId,
                  );
                  store.getGymPlans(
                    gymId: store.activeSubscriptions.data.gymId,
                    context: context,
                  );
                  NavigationService.navigateTo(
                    Routes.membershipPlanPage,
                  );
                },
                child: Text(
                  'Renew your membership',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(
                    primary: AppConstants.primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            )
          : Container(
              height: 0.0,
            ),
      body: Consumer<GymStore>(
        builder: (context, store, child) => Stepper(
          steps: [
            Step(
              title: Text("Facebook"),
              subtitle: Text(
                  "Submit your result in Facebook and share the link here."),
              content: OutlineTextField(
                controller: fbController,
                hintText: 'Enter Facebook Post url',
                labelText: 'Facebook',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              state: StepState.indexed,
              isActive: _processIndex == 0,
            ),
            Step(
              title: Text("Instagram"),
              subtitle: Text(
                  "Submit your result in Instagram and share the link here."),
              content: OutlineTextField(
                controller: instaController,
                hintText: 'Enter Instagram Post url',
                labelText: 'Instagram',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              state: StepState.indexed,
              isActive: _processIndex == 1,
            ),
            Step(
              title: Text("Twitter"),
              subtitle: Text(
                  "Submit your result in Twitter and share the link here."),
              content: OutlineTextField(
                controller: twitterController,
                hintText: 'Enter Twitter Post url',
                labelText: 'Twitter',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              state: StepState.indexed,
              isActive: _processIndex == 2,
            ),
          ],
          onStepTapped: (index) {
            setState(() {
              _processIndex = index;
            });
          },
          currentStep: _processIndex,
          // controlsBuilder: (BuildContext context,
          //         {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
          //     Container(),
          onStepCancel: () {
            print("You are clicking the cancel button.");
          },
          onStepContinue: () async {
            print("You are clicking the continue button.");
            if (_processIndex == 0) {
              bool isSubmitted = await store.eventSubmissionAdd(
                  context: context,
                  date: '08-02-2022',
                  // date: Helper.formatDate2(DateTime.now().toIso8601String()),
                  link: 'https://fb.com/',
                  platform: 'facebook');
            } else if (_processIndex == 1) {
              bool isSubmitted = await store.eventSubmissionUpdate(
                  context: context,
                  date: '08-02-2022',
                  // date: Helper.formatDate2(DateTime.now().toIso8601String()),
                  link: 'https://instagram.com/',
                  platform: 'instagram',
                  submissionUid: store.selectedEventSubmissions.data.first.uid);
            } else if (_processIndex == 2) {
              bool isSubmitted = await store.eventSubmissionUpdate(
                context: context,
                date: '08-02-2022',
                // date: Helper.formatDate2(DateTime.now().toIso8601String()),
                link: 'https://twitter.com/',
                platform: 'twitter',
                submissionUid: store.selectedEventSubmissions.data.first.uid,
              );
            }
          },
        ),
      ),
    );
  }

  whiteButton(title, onPress) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: onPress,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
          ),
        ),
      );
}
