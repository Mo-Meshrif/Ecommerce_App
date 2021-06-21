import 'package:ecommerce/const.dart';
import 'package:ecommerce/model/productModel.dart';
import 'package:ecommerce/view/widgets/customText.dart';
import 'package:flutter/material.dart';

class ProductDetailsDview extends StatelessWidget {
  final ProductModel prod;

  ProductDetailsDview({this.prod});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          CustomRow2CTxtTxt(
            txt1: 'BRAND',
            content1: prod.brand,
            txt2: 'SKU',
            content2: prod.sku,
          ),
          SizedBox(
            height: 40,
          ),
          CustomRow2CTxtTxt(
            txt1: 'CONDITION',
            content1: prod.condition,
            txt2: 'MATERIAL',
            content2: prod.material,
          ),
          SizedBox(
            height: 40,
          ),
          CustomRow2CTxtTxt(
            txt1: 'CATEGORY',
            content1: prod.classification['category'],
            txt2: 'FITTING',
            content2: 'True To Size',
          )
        ],
      ),
    );
  }
}

class CustomRow2CTxtTxt extends StatelessWidget {
  final txt1, content1, txt2, content2;

  CustomRow2CTxtTxt(
      {Key key, this.txt1, this.content1, this.txt2, this.content2});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txt: txt1,
              txtColor: swatchColor,
              fWeight: FontWeight.w500,
            ),
            CustomText(
              txt: content1,
              txtColor: swatchColor,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              txt: txt2,
              txtColor: swatchColor,
              fWeight: FontWeight.w500,
            ),
            CustomText(
              txt: content2,
              txtColor: swatchColor,
            ),
          ],
        ),
      ],
    );
  }
}
