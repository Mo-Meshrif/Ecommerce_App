import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class CustomColumImgTT extends StatelessWidget {
  final String imgUrl;
  final String txt1;
  final String txt2;

  CustomColumImgTT({
    this.imgUrl,
    this.txt1,
    this.txt2,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          imgUrl.startsWith('a')
              ? Image.asset(
                  imgUrl,
                  fit: BoxFit.contain,
                  height: 70,
                  width: 70,
                )
              : CachedNetworkImage(
                  placeholder: (_, __) => Image.asset(
                    'assets/shop/place_holder.jpg',
                    fit: BoxFit.contain,
                    height: 70,
                    width: 70,
                  ),
                  imageUrl: imgUrl,
                  fit: BoxFit.contain,
                  height: 70,
                  width: 70,
                  errorWidget: (context, error, stackTrace) =>
                      Image.asset('assets/shop/place_holder.jpg'),
                ),
          CustomText(
            txt: txt1,
            txtColor: swatchColor,
            fWeight: FontWeight.normal,
          ),
          CustomText(
            txt: txt2,
            txtColor: swatchColor,
            fWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
