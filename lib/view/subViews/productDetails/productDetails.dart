import '../../../view/widgets/customElevatedButton.dart';
import '../../../model/productModel.dart';
import '../../../view/subViews/productDetails/productDetailsDview.dart';
import '../../../view/subViews/productDetails/productDetailsPview.dart';
import '../../../view/subViews/productDetails/productDetailsRview.dart';
import '../../../view/widgets/customStackIcon.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel prod;

  ProductDetails({this.prod});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 33),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Image.asset('assets/shop/back.png')),
                  Expanded(
                    child: Center(
                      child: CustomText(
                          txt: prod.prodName,
                          fSize: 20,
                          fWeight: FontWeight.w300),
                    ),
                  ),
                  GestureDetector(
                      onTap: null,
                      child: CustomStackIcon(
                        imageUrl: 'assets/shop/Cart.png',
                        txtNum: '7',
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Image.network(
                prod.imgUrl,
                fit: BoxFit.contain,
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: TabBar(
                  unselectedLabelColor: swatchColor,
                  labelColor: priColor,
                  indicatorColor: Colors.white10,
                  tabs: [
                    Tab(text: 'Product'),
                    Tab(text: 'Details'),
                    Tab(text: 'Reviews'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ProductDetailsPview(prod: prod),
                    ProductDetailsDview(prod: prod),
                    ProductDetailsRview()
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomElevatedButton(
                    buttonColor: Colors.white,
                    txt: 'SHARE THIS',
                    imgUrl: 'assets/shop/share_arrow.png',
                    txtColor: swatchColor,
                    onPress: () {},
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomElevatedButton(
                    txt: 'ADD TO CART',
                    imgUrl: 'assets/auth/right_arrow.png',
                    onPress: () {},
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
