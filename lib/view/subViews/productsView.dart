import 'package:ecommerce/view/widgets/customText.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  final String prodsTxt;

  ProductsView({this.prodsTxt});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          txt: prodsTxt,
        ),
      ),
    );
  }
}
