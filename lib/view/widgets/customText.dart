import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final double fSize, textFactor;
  final int maxLine;
  final Color txtColor;
  final FontWeight fWeight;
  CustomText({
    this.txt,
    this.fSize,
    this.txtColor,
    this.fWeight,
    this.maxLine,
    this.textFactor,
  });
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).size.width / 411.42;
    return Text(
      txt,
      maxLines: maxLine ?? 1,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: textFactor != null
          ? textFactor
          : textScaleFactor > 1.5
              ? 1.5
              : textScaleFactor,
      style: TextStyle(
        fontSize: fSize,
        color: txtColor ?? Colors.black,
        fontWeight: fWeight,
      ),
    );
  }
}
