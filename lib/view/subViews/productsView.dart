import '../../const.dart';
import '../../core/viewModel/searchViewModel.dart';
import '../../view/widgets/customFilter.dart';
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
        GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
        List<ProductModel> products = controller.products;
        List<ProductModel> filteredProducts = products.where((prod) {
          if (fromCategoriesView) {
            return prod.classification['sub-cat'] == prodsTxt &&
                prod.classification['category'] == catTxt;
          }
          return prod.classification['sub-cat'] == prodsTxt;
        }).toList();
        List<String> availableCategories = [];
        List<String> availableConditions = [];
        List<String> availableMaterials = [];
        List<String> availableBrands = [];
        filteredProducts.forEach((prods) {
          availableCategories.add(prods.classification['category']);
          availableConditions.add(prods.condition);
          availableMaterials.add(prods.material);
          availableBrands.add(prods.brand);
        });
        List<ProductModel> customProducts = products.where((prod) {
          if (!fromCategoriesView) {
            return prod.classification['sub-cat'] == prodsTxt &&
                prod.classification['category'] == controller.filterCatTxt &&
                prod.condition == controller.filterConditionTxt &&
                prod.material == controller.filterMaterialTxt &&
                prod.brand == controller.filterBrandTxt;
          }
          return prod.classification['sub-cat'] == prodsTxt &&
              prod.condition == controller.filterConditionTxt &&
              prod.material == controller.filterMaterialTxt &&
              prod.brand == controller.filterBrandTxt;
        }).toList();
        return Scaffold(
          key: _key,
          endDrawer: CustomFilter(
            fromCategoriesView: fromCategoriesView,
            avCategories: availableCategories.toSet().toList(),
            avConditions: availableConditions.toSet().toList(),
            avMaterials: availableMaterials.toSet().toList(),
            avBrands: availableBrands.toSet().toList(),
          ),
          body: filteredProducts.isEmpty && !controller.isFltered
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
                              onTap: () => _key.currentState.openEndDrawer(),
                              child: Image.asset(
                                'assets/shop/filter.png',
                                color: controller.isFltered ? priColor : null,
                              )),
                        ],
                      ),
                      customProducts.isEmpty && controller.isFltered
                          ? Expanded(
                              child: Center(
                                child: CustomText(
                                  txt: 'No Products !',
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                height: 120,
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: !controller.isFltered
                                      ? filteredProducts.length
                                      : customProducts.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, x) =>
                                      GetBuilder<SearchViewModel>(
                                    builder: (searchController) =>
                                        GestureDetector(
                                      onTap: () => Get.to(
                                        () => ProductDetails(
                                            prod: !controller.isFltered
                                                ? filteredProducts[x]
                                                : customProducts[x]),
                                      ).then((_) => fromSearchView
                                          ? searchController
                                              .getRecentlyViewedProducts(
                                                  !controller.isFltered
                                                      ? filteredProducts[x]
                                                      : customProducts[x])
                                          : null),
                                      child: Card(
                                        child: Center(
                                          child: CustomColumImgTT(
                                            imgUrl: !controller.isFltered
                                                ? filteredProducts[x].imgUrl
                                                : customProducts[x].imgUrl,
                                            txt1: !controller.isFltered
                                                ? filteredProducts[x].prodName
                                                : customProducts[x].prodName,
                                            txt2: !controller.isFltered
                                                ? '\$' +
                                                    filteredProducts[x].price
                                                : '\$' +
                                                    customProducts[x].price,
                                          ),
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
