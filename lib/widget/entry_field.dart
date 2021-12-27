import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wtf/helper/app_constants.dart';

class EntryField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String image;
  final String initialValue;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final String hint;
  final String suffixIcon;
  final Function onTap;
  final Function onChanged;
  final TextCapitalization textCapitalization;
  final Function onSuffixPressed;
  final Function onSubmitted;
  final bool showCountryCode;
  final bool obscureText;
  final bool showWithoutSpace;
  final String text;
  final String counterText;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Color suffixIconColor;
  final Color barColor;
  final bool validator;
  final String errorText;
  final EdgeInsets contentPadding;
  final Color textColor;

  EntryField({
    this.controller,
    this.label,
    this.image,
    this.initialValue,
    this.readOnly,
    this.keyboardType,
    this.maxLength,
    this.hint,
    this.suffixIcon,
    this.maxLines,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.text,
    this.textCapitalization,
    this.onSuffixPressed,
    this.showCountryCode = false,
    this.obscureText = false,
    this.showWithoutSpace = false,
    this.focusNode,
    this.textInputAction,
    this.suffixIconColor,
    this.validator = false,
    this.barColor = Colors.black,
    this.textColor = Colors.black,
    this.errorText,
    this.counterText,
    this.contentPadding,
  });

  @override
  _EntryFieldState createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  Color get suffixIconColor => widget.suffixIconColor ?? AppConstants.black;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: TextFormField(
        style: AppConstants.customStyle(
          size: 14.0,
          weight: FontWeight.normal,
          color: widget.textColor,
        ),
        focusNode: widget.focusNode,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.sentences,
        cursorColor: AppConstants.orangeColor,
        autofocus: false,
        onTap: widget.onTap ?? null,
        onFieldSubmitted: widget.onSubmitted ?? null,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        controller: widget.controller,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly ?? false,
        keyboardType: Platform.isIOS ? TextInputType.text : widget.keyboardType,
        minLines: 1,
        initialValue: widget.initialValue,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines ?? 1,
        obscureText: widget.obscureText,
        enableInteractiveSelection: true,
        decoration: InputDecoration(
          prefixText: widget.showCountryCode ? '+91 ' : '',
          errorText: widget.validator
              ? widget.errorText != null && widget.errorText.isNotEmpty
                  ? widget.errorText
                  : 'Please provide a value'
              : null,
          labelText: widget.label != null ? widget.label : null,
          counterText: widget.counterText,
          contentPadding: widget.contentPadding,
          labelStyle: AppConstants.customStyle(
            style: FontStyle.normal,
            weight: FontWeight.w600,
            size: 15.0,
            color: widget.textColor.withOpacity(0.6),
          ),
          alignLabelWithHint: true,
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: widget.barColor.withOpacity(0.8), width: 1.0),
          ),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: widget.barColor.withOpacity(0.8), width: 1.0),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppConstants.red,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: widget.barColor.withOpacity(0.8), width: 1.0),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppConstants.red,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: widget.barColor.withOpacity(0.8), width: 1.0),
          ),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: SvgPicture.asset(
                    widget.suffixIcon,
                    color: suffixIconColor,
                  ),
                  onPressed: widget.onSuffixPressed ?? null,
                )
              : null,
          hintText: widget.hint,
          prefixStyle: TextStyle(
            color: widget.textColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: AppConstants.customStyle(
            color: widget.textColor.withOpacity(0.4),
            size: 14.0,
          ),
        ),
      ),
    );
  }
}
