import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:wtf/controller/gym_store.dart';

class ExerciseInfo extends StatelessWidget {
  const ExerciseInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 6.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              context
                      .read<GymStore>()
                      .selectedWorkoutSchedule
                      .category
                      .toUpperCase() ??
                  '',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Flexible(
            child: RichText(
              text: HTML.toTextSpan(
                context,
                context.read<GymStore>().selectedWorkoutSchedule.description ??
                    '',
                defaultTextStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}
