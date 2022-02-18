import 'package:flutter/material.dart';
import 'package:wtf/helper/colors.dart';

class ExerciseTopBar extends StatelessWidget {
  const ExerciseTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.BACK_GROUND_BG,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Colors.white54,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
