import 'package:flutter/material.dart';

import 'gender_item.dart';
import 'gender_selection_top_bar.dart';

class GenderSelection extends StatelessWidget {
  GenderSelection({Key key}) : super(key: key);

  final _imageSelected = true;
  final _isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),
          GenderSelectionTopBar(),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GenderItem(
                title: 'Male',
                isSelected: _imageSelected && _isMale,
              ),
              GenderItem(
                title: 'Female',
                isSelected: _imageSelected && !_isMale,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.red,
          child: Icon(
            Icons.chevron_right,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
