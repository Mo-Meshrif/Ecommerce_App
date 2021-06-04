import 'package:flutter/material.dart';

import '../../const.dart';
import 'customText.dart';

class CustomRaisedButton extends StatelessWidget {
  final String txt;
  final Function onPress;

  CustomRaisedButton({this.txt, this.onPress});
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.all(15),
      onPressed: onPress,
      color: priColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: CustomText(
                txt: txt,
                txtColor: Colors.white,
              ),
            ),
          ),
          Image.asset("assets/auth/right_arrow.png"),
        ],
      ),
    );
  }
}
