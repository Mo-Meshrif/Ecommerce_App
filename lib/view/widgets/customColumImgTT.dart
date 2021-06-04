import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class CustomColumImgTT extends StatelessWidget {
  final String imgUrl;
  final String txt1;
  final String txt2;
  final double imgH;
  final double imgW;

  CustomColumImgTT({
    this.imgUrl,
    this.txt1,
    this.txt2,
    this.imgH = 70,
    this.imgW = 70,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imgUrl,
          width: imgW,
          height: imgH,
        ),
        CustomText(
          txt: txt1,
          txtColor: swatchColor,
          fWeight: FontWeight.normal,
        ),
        CustomText(
          txt: txt2,
          txtColor: swatchColor,
          fWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
