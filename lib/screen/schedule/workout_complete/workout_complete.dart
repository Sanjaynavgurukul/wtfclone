import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/schedule/workout_complete/rate_session.dart';
import 'package:wtf/screen/schedule/workout_complete/success_image.dart';
import 'package:wtf/screen/schedule/workout_complete/workout_complete_buttons.dart';
import '../../../main.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutComplete extends StatefulWidget {
  const WorkoutComplete({Key key}) : super(key: key);

  @override
  State<WorkoutComplete> createState() => _WorkoutCompleteState();
}

class _WorkoutCompleteState extends State<WorkoutComplete> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: Colors.black38,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ListView(
          padding: EdgeInsets.only(bottom: 100),
          shrinkWrap: true,
          children: [
            RateSession(),
            Container(
              height: 24,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Color(0xff414141),
              ),
              child: Center(
                child: Text(
                  'You will earn 500 Coins :coin: every time you rate',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardUI(title: '02:30:00', subtitle: 'Total Duration'),
                SizedBox(width: 14),
                cardUI(title: '800 Kcal', subtitle: 'Tentative Calorie\nBurnt')
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Color(0xffBB0000),
        ),
        child: Center(
          child: Text(
            'Continue',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget cardUI({String title, String subtitle}) {
    return Column(
      children: [
        Container(
          height: 136,
          width: 124,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Color(0xff191919),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
              ),
            ],
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   store = context.watch<GymStore>();
  //   return ScheduleScreen();
  //   return Scaffold(
  //     backgroundColor: AppColors.BACK_GROUND_BG,
  //     bottomNavigationBar: WorkoutCompleteButtons(),
  //     body: Consumer<GymStore>(
  //       builder: (context, store, child) => SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             // SizedBox(height: kToolbarHeight,),
  //             SuccessImage(),
  //             Text(
  //               locator<AppPrefs>().selectedMySchedule.getValue(),
  //               style: TextStyle(
  //                 fontSize: 24.0,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Text(
  //               'WORKOUT COMPLETED',
  //               style: TextStyle(
  //                 fontSize: 20.0,
  //                 color: Colors.white70,
  //               ),
  //             ),
  //             UIHelper.verticalSpace(20.0),
  //             //WorkoutCompleteInfo(),
  //             UIHelper.verticalSpace(30.0),
  //             RateSession(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    store.selectedWorkoutSchedule = null;
    super.dispose();
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: Colors.black38,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ListView(
          padding: EdgeInsets.only(bottom: 100),
          shrinkWrap: true,
          children: [
            RateSession(),
            Container(
              height: 24,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Color(0xff414141),
              ),
              child: Center(
                child: Text(
                  'You will earn 500 Coins :coin: every time you rate',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardUI(title: '02:30:00', subtitle: 'Total Duration'),
                SizedBox(width: 14),
                cardUI(title: '800 Kcal', subtitle: 'Tentative Calorie Burnt')
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Color(0xffBB0000),
        ),
        child: Center(
          child: Text(
            'Continue',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget cardUI({String title, String subtitle}) {
    return Column(
      children: [
        Container(
          height: 136,
          width: 124,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Color(0xff191919),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
