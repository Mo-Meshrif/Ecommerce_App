import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'customText.dart';

class CustomColTImage extends StatelessWidget {
  final String imgUrl;
  final String txt;
  final Color txtCol;
  final String avatarCol;
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
          backgroundColor: HexColor(avatarCol),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: imgUrl.startsWith('a')
                ? Image.asset(imgUrl)
                : Image.network(
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
