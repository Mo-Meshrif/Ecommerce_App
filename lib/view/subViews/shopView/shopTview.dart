import '../../../view/subViews/productDetails/productDetails.dart';
import '../../../core/viewModel/homeViewModel.dart';
import '../../../model/categoryModel.dart';
import '../../../model/productModel.dart';
import '../../../view/widgets/customColumImgTT.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopTview extends StatelessWidget {
  final CategoryModel cat;
  ShopTview({@required this.cat});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        List<ProductModel> trendingProds = controller.products
            .where((element) =>
                element.trending && element.classification['cat-id'] == cat.id)
            .toList();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: GridView.builder(
            itemCount: trendingProds.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
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
      },
    );
  }
}
