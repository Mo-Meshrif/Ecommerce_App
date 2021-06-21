import 'package:hexcolor/hexcolor.dart';

import '../../../const.dart';
import '../../../model/productModel.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';

class ProductDetailsPview extends StatelessWidget {
  final ProductModel prod;

  ProductDetailsPview({this.prod});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          CustomText(
            txt: 'SELECT COLOR',
            txtColor: swatchColor,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            child: ListView.separated(
                separatorBuilder: (context, i) => SizedBox(
                      width: 20,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: prod.color.length,
                itemBuilder: (context, i) => GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: HexColor(prod.color[i]) ?? null,
                        radius: 20,
                        child: i == 0
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    )),
          ),
          SizedBox(
            height: 15,
          ),
          CustomText(
            txt: 'SELECT SIZE (US)',
            txtColor: swatchColor,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: prod.size.length,
              itemBuilder: (context, i) => Container(
                alignment: Alignment.center,
                width: 70,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: CustomText(
                  txt: prod.size[i],
                  fSize: 17,
                  txtColor: i == 1 ? priColor : null,
                ),
              ),
              separatorBuilder: (context, i) => SizedBox(
                width: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
