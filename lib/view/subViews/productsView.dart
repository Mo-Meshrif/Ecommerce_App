import '../../core/viewModel/homeViewModel.dart';
import '../../model/productModel.dart';
import '../../view/subViews/productDetails/productDetails.dart';
import '../../view/widgets/customColumImgTT.dart';
import '../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  final String prodsTxt, catTxt;
  final bool fromCategoriesView, fromSearchView;
  ProductsView(
      {@required this.prodsTxt,
      this.catTxt,
      @required this.fromCategoriesView,
      @required this.fromSearchView});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        List<ProductModel> products = controller.products;
        List<ProductModel> filteredProducts = products.where((prod) {
          if (fromCategoriesView) {
            return prod.classification['sub-cat'] == prodsTxt &&
                prod.classification['category'] == catTxt;
          }
          return prod.classification['sub-cat'] == prodsTxt;
        }).toList();
        return Scaffold(
          body: filteredProducts.isEmpty
              ? Center(
                  child: CustomText(
                    txt: 'Comming Sooooooooon !',
                  ),
                )
              : Padding(
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
                                  txt: prodsTxt,
                                  fSize: 20,
                                  fWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                              onTap: () => null,
                              child: Image.asset(
                                'assets/shop/filter.png',
                                color: null,
                              )),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, x) => GestureDetector(
                              onTap: () => Get.to(() => ProductDetails(
                                    prod: filteredProducts[x],
                                    fromSearchView: fromSearchView,
                                  )),
                              child: Card(
                                child: Center(
                                  child: CustomColumImgTT(
                                    imgUrl: filteredProducts[x].imgUrl,
                                    txt1: filteredProducts[x].prodName,
                                    txt2: '\$' + filteredProducts[x].price,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
