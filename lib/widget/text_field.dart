import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/strings.dart';

class OutlineTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String) onchanged;
  final Function(String) validator;
  final Function onTap;
  final String hintText;
  final bool read;
  final TextEditingController controller;
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;
  final Widget suffix;
  final Widget preffix;
  final TextAlign textAlign;
  final bool autoValidate;
  final EdgeInsets contentPadding;
  final TextInputAction textInputAction;
  final String fontFamily;

  const OutlineTextField({
    this.labelText,
    this.obscureText,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.read,
    this.onchanged,
    this.validator,
    this.onTap,
    @required this.controller,
    this.inputFormatters,
    this.maxLines,
    this.suffix,
    this.preffix,
    this.textAlign = TextAlign.start,
    this.autoValidate = true,
    this.contentPadding,
    this.textInputAction = TextInputAction.done,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          inputFormatters: inputFormatters ?? [],
          maxLines: maxLines ?? 1,
          controller: controller,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: 16,
              letterSpacing: 0.8,
              color: Colors.white,
              fontFamily: fontFamily ?? Fonts.RALEWAY),
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.normal,
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              suffixIcon: suffix ?? null,
              prefix: preffix ?? null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.red),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.red),
              ),
              filled: true),
          obscureText: obscureText ?? false,
          readOnly: read ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: Colors.white,
          enableInteractiveSelection: true,
          textInputAction: textInputAction,
          onChanged: onchanged ?? (val) {},
          onTap: onTap ?? () {},
          validator: validator,
          autovalidateMode: autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}

class UnderlineTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function onTap;
  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final Widget suffix;
  final Widget preffixIcon;
  final Color color;
  final bool autoValidate;
  final bool readOnly;
  final int maxLines;
  final bool observe;
  final bool enable;
  final int maxLength;
  final String fontFamily;

  const UnderlineTextField({
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.validator,
    @required this.controller,
    this.inputFormatters,
    this.suffix,
    this.preffixIcon,
    this.color = AppColors.TEXT_DARK,
    this.autoValidate = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.observe = false,
    this.enable = true,
    this.maxLength,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          enabled: enable,
          obscureText: observe,
          inputFormatters: inputFormatters ?? [],
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          maxLength: maxLength,
          style: TextStyle(
            fontSize: 15,
            letterSpacing: 0.8,
            color: Colors.white,
            fontFamily: fontFamily ?? Fonts.RALEWAY,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            counterText: '',
            suffixIcon: suffix ?? null,
            prefixIcon: preffixIcon ?? null,
            border: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: Colors.grey),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: color),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: Colors.red),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: Colors.red),
            ),
          ),
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: color,
          onChanged: onChanged ?? (val) {},
          onTap: onTap ?? () {},
          validator: validator,
          autovalidateMode: autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
        ),
      ],
    );
  }
}
