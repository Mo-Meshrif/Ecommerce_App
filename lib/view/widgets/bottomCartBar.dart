import 'package:flutter/material.dart';
import '../../const.dart';
import 'customElevatedButton.dart';
import 'customText.dart';

class BottomCartBar extends StatelessWidget {
  BottomCartBar({
    required this.totalPrice,
    required this.buttonTxt,
    required this.onPress,
  });

  final String totalPrice,buttonTxt;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txt: 'TOTAL',
              fSize: 15,
              txtColor: swatchColor,
              fWeight: FontWeight.normal,
            ),
            CustomText(
              txt: '\$' + totalPrice,
              fSize: 20,
              txtColor: swatchColor,
              fWeight: FontWeight.bold,
            ),
            CustomText(
              txt: 'Free Domestic Shipping',
              fSize: 15,
              txtColor: swatchColor,
              fWeight: FontWeight.normal,
            ),
          ],
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: CustomElevatedButton(
            txt: buttonTxt,
            imgUrl: 'assets/auth/right_arrow.png',
            onPress: onPress,
          ),
        )
      ],
    );
  }
}
