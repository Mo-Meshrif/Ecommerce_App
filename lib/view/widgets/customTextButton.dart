import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class CustomTextButton extends StatelessWidget {
  final String txt;
  final Color? txtColor, buttonColor;
  final Function onPress;

  CustomTextButton(
      {required this.txt,
      this.txtColor,
      required this.buttonColor,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress as void Function()?,
      child: CustomText(
        txt: txt,
        txtColor: txtColor,
      ),
      style: TextButton.styleFrom(backgroundColor: buttonColor ?? priColor),
    );
  }
}
