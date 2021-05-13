import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final double fSize;
  final Color txtColor;
  CustomText({this.txt, this.fSize, this.txtColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        txt,
        style: TextStyle(fontSize: fSize, color: txtColor ?? Colors.black),
      ),
    );
  }
}
