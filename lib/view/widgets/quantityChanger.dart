import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'customText.dart';

class QuantityChanger extends StatelessWidget {
  final void Function() add, minimize;
  final int? quantityVal;
  final bool fromProdDetails;
  QuantityChanger(
      {required this.add,
      required this.minimize,
      required this.fromProdDetails,
      required this.quantityVal});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          fromProdDetails ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: minimize,
          child: CircleAvatar(
            radius: 12,
            child: Center(
              child: Align(
                alignment: Alignment(0, -3),
                child: Icon(
                  Icons.minimize,
                  color: Colors.grey[700],
                  size: 20,
                ),
              ),
            ),
            backgroundColor: Colors.grey[300],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        CustomText(
          txt: quantityVal.toString(),
          fSize: 15,
          txtColor: HexColor('#515C6F'),
          fWeight: FontWeight.normal,
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: add,
          child: CircleAvatar(
            radius: 12,
            child: Icon(
              Icons.add,
              color: Colors.grey[700],
              size: 20,
            ),
            backgroundColor: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
