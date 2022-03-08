import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/fluid_slider.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';

class Slide7 extends StatefulWidget {
  @override
  State<Slide7> createState() => _Slide7State();
}

class _Slide7State extends State<Slide7> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, user, snapshot) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "How fast do you want to ${user.targetWeight > user.weight ? 'gain your weight' : 'lose your weight'}?",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppConstants.confidentialInfo,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
              // TextField(),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  '${user.goalWeight.toStringAsFixed(2)} kg / week',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              UIHelper.verticalSpace(70.0),
              FluidSlider(
                value: user.goalWeight,
                onChanged: (double newValue) {
                  setState(() {
                    user.setValue(
                      goalWeight: newValue,
                    );
                  });
                },
                min: 0.0,
                max: 1.5,
                sliderColor: AppConstants.primaryColor,
                showDecimalValue: true,
                start: Container(),
                end: Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}