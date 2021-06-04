import 'package:flutter/material.dart';
import 'customText.dart';

class CustomColTImage extends StatelessWidget {
  final String imgUrl;
  final String txt;
  final Color avatarCol;
  CustomColTImage({this.imgUrl, this.txt, this.avatarCol});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: avatarCol,
          backgroundImage: AssetImage(imgUrl),
        ),
        SizedBox(
          height: 10,
        ),
        CustomText(
          txt: txt,
          fSize: 17,
        )
      ],
    );
  }
}
