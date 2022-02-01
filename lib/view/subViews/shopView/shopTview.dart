import '../../../view/subViews/productDetails/productDetails.dart';
import '../../../model/categoryModel.dart';
import '../../../model/productModel.dart';
import '../../../view/widgets/customColumImgTT.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopTview extends StatelessWidget {
  final CategoryModel cat;
  final List<ProductModel> products;
  ShopTview({
    @required this.cat,
    @required this.products,
  });
  @override
  Widget build(BuildContext context) {
    List<ProductModel> trendingProds =
        products.where((element) => element.trending).toList();
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: GridView.builder(
        itemCount: trendingProds.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 140,
        ),
        itemBuilder: (context, i) => GestureDetector(
          onTap: () => Get.to(
            () => ProductDetails(
              prod: trendingProds[i],
              fromSearchView: false,
            ),
          ),
          child: Card(
            child: Center(
              child: CustomColumImgTT(
                imgUrl: trendingProds[i].imgUrl,
                txt1: trendingProds[i].prodName,
                txt2: trendingProds[i].price,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
