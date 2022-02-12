import 'package:cached_network_image/cached_network_image.dart';
import '/responsive.dart';
import 'package:flutter/material.dart';
import 'customElevatedButton.dart';
import 'customText.dart';

class CustomStackImgTbutton extends StatelessWidget {
  final bool fromlocal;
  final String? imgUrl;
  final String? txt;
  final double imgH;
  final double? imgW;
  final void Function()? onTap;
  CustomStackImgTbutton({
    this.imgUrl,
    this.txt,
    this.imgH = 192,
    this.imgW,
    this.fromlocal = true,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Responsive(
      builder: (context, deviceInfo) => Stack(
        children: [
          fromlocal
              ? Image.asset(
                  imgUrl!,
                  height: imgH,
                  width: imgW ?? null,
                )
              : CachedNetworkImage(
                  placeholder: (_, __) => Image.asset(
                    'assets/shop/place_holder.jpg',
                    height: imgH,
                    width: imgW ?? null,
                    fit: BoxFit.fill,
                  ),
                  imageUrl: imgUrl!,
                  height: imgH,
                  width: imgW ?? null,
                  fit: BoxFit.fill,
                  errorWidget: (context, error, stackTrace) =>
                      Image.asset('assets/shop/place_holder.jpg'),
                ),
          Positioned(
            top: 20,
            left: 35,
            child: Container(
              width: deviceInfo.widgetScaleFactor! * 150,
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
              width: (deviceInfo.widgetScaleFactor! > 1.5
                      ? 1.5
                      : deviceInfo.widgetScaleFactor)! *
                  150,
              child: GestureDetector(
                onTap: onTap,
                child: CustomElevatedButton(
                  txt: 'SEE MORE',
                  imgUrl: 'assets/auth/right_arrow.png',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
