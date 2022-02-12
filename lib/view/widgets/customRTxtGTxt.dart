import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class CustomRTxtGTxt extends StatelessWidget {
  final String txt1, txt2;
  final void Function() onT;

  CustomRTxtGTxt(
      {required this.txt1, required this.txt2, required this.onT});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txt: txt1,
          txtColor: Colors.grey[500],
          fWeight: FontWeight.w500,
        ),
        GestureDetector(
          onTap: onT,
          child: CustomText(
            txt: txt2,
            txtColor: priColor,
          ),
        ),
      ],
    );
  }
}
