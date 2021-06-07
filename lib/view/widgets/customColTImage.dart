import 'package:flutter/material.dart';
import 'customText.dart';

class CustomColTImage extends StatelessWidget {
  final String imgUrl;
  final String txt;
  final Color txtCol;
  final Color avatarCol;
  CustomColTImage({
    this.imgUrl,
    this.txt,
    this.avatarCol,
    this.txtCol,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: avatarCol,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              imgUrl,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CustomText(
          txt: txt,
          txtColor: txtCol,
          fSize: 17,
        )
      ],
    );
  }
}
