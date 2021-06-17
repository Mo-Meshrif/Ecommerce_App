import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customRichText.dart';

class CustomStackImg2IconTxt extends StatelessWidget {
  final String banner, txtTitle, txtDesc;

  CustomStackImg2IconTxt({this.banner, this.txtTitle, this.txtDesc});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeInImage.assetNetwork(
          placeholder: 'assets/shop/place_holder.jpg',
          image: banner,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 30,
          right: 20,
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 27,
          ),
        ),
        Positioned(
          top: 30,
          left: 20,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        CustomRichText(
            txt1: txtTitle + '\n',
            txt1color: Colors.white,
            txt1Size: 30,
            txt2: txtDesc,
            txt2color: Colors.white60,
            txt2Size: 17)
      ],
    );
  }
}
