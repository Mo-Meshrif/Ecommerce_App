import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class CustomStackIcon extends StatelessWidget {
  final String imageUrl;
  final String txtNum;

  CustomStackIcon({this.imageUrl, this.txtNum});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imageUrl,
          width: 42,
          height: 33,
        ),
        txtNum == '0'
            ? Padding(padding: EdgeInsets.zero)
            : Positioned(
                top: 14,
                right: 22,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: priColor,
                  child: CustomText(
                    txt: txtNum,
                    txtColor: Colors.white,
                  ),
                ),
              )
      ],
    );
  }
}
