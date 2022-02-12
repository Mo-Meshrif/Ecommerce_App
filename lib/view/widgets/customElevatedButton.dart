import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? txt, imgUrl;
  final Color? txtColor, buttonColor;
  final Function? onPress;

  CustomElevatedButton(
      {this.txt, this.onPress, this.imgUrl, this.txtColor, this.buttonColor});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor ?? priColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.all(15),
      ),
      onPressed: onPress as void Function()?,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: CustomText(
                txt: txt,
                maxLine: 2,
                txtColor: txtColor ?? Colors.white,
              ),
            ),
          ),
          Image.asset(imgUrl!),
        ],
      ),
    );
  }
}
