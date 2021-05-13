import 'package:flutter/material.dart';

import '../../const.dart';
import 'customText.dart';

class CustomRaisedButton extends StatelessWidget {
  final String signState;

  CustomRaisedButton({this.signState});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.all(15),
      onPressed: () {},
      color: priColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: CustomText(
                txt: signState,
                txtColor: Colors.white,
              ),
            ),
          ),
          Image.asset("assets/icons/right_arrow.png"),
        ],
      ),
    );
  }
}
