import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/slide_button.dart';

class WorkoutCompleteButtons extends StatelessWidget {
  const WorkoutCompleteButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return IntrinsicHeight(
      child: Container(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.share,
            //           size: 30,
            //         ),
            //         UIHelper.horizontalSpace(12.0),
            //         Text(
            //           'Share',
            //           style: TextStyle(
            //             fontSize: 22,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //       ],
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.transparent,
            //       padding: EdgeInsets.symmetric(
            //         vertical: 10,
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //   ),
            // ),
            UIHelper.verticalSpace(12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SlideButton(
                'Continue',
                () {
                  //TODO SAVE PROGRESS
                  if (store.sessionRating > 0.0 && store.trainerRating > 0.0) {
                    store.submitRating(context: context);
                  } else {
                    FlashHelper.informationBar(context,
                        message: 'Please give rating first');
                  }
                },
              ),
            ),
            UIHelper.verticalSpace(12.0),
          ],
        ),
      ),
    );
  }
}
