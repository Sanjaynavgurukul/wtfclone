import 'package:flutter/material.dart';

class TermsAndConditionBottomSheet extends StatefulWidget {
  @override
  _TermsAndConditionBottomSheetState createState() =>
      _TermsAndConditionBottomSheetState();
}

class _TermsAndConditionBottomSheetState
    extends State<TermsAndConditionBottomSheet> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Text(
                "Terms and Conditions",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
