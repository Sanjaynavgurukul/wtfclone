import 'package:flutter/material.dart';
import 'package:wtf/widget/entry_field.dart';

class CalorieCounterTextBox extends StatelessWidget {
  const CalorieCounterTextBox({
    Key key,
    this.hint,
    this.controller,
    this.node,
    this.node2,
    this.action,
    this.keyboardType,
    this.label,
  }) : super(key: key);

  final String hint;
  final String label;
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode node2;
  final TextInputType keyboardType;
  final TextInputAction action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: SizedBox(
            child: EntryField(
              controller: controller,
              hint: hint,
              textColor: Colors.white,
              barColor: Colors.white,
              focusNode: node,
              label: label,
              textInputAction: action,
              onSubmitted: (val) {
                if (node2 != null) FocusScope.of(context).requestFocus(node2);
              },
              keyboardType: keyboardType,
            ),
            height: 40,
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
