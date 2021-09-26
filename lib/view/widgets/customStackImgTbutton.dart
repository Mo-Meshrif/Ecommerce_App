import 'package:flutter/material.dart';
import 'customElevatedButton.dart';
import 'customText.dart';

class CustomStackImgTbutton extends StatelessWidget {
  final bool fromlocal;
  final String imgUrl;
  final String txt;
  final double imgH;
  final double imgW;
  CustomStackImgTbutton({
    this.imgUrl,
    this.txt,
    this.imgH = 192,
    this.imgW,
    this.fromlocal = true,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        fromlocal
            ? Image.asset(
                imgUrl,
                height: imgH,
                width: imgW ?? null,
              )
            : FadeInImage.assetNetwork(
                placeholder: 'assets/shop/place_holder.jpg',
                image: imgUrl,
                height: imgH,
                width: imgW ?? null,
                fit: BoxFit.fill,
              ),
        Positioned(
          top: 20,
          left: 35,
          child: Container(
            width: 150,
            child: CustomText(
              txt: txt,
              fSize: 18,
              txtColor: Colors.white,
              maxLine: 3,
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 25,
          child: Container(
            width: 150,
            child: CustomElevatedButton(
              txt: 'SEE MORE',
              imgUrl: 'assets/auth/right_arrow.png',
            ),
          ),
        )
      ],
    );
  }
}
