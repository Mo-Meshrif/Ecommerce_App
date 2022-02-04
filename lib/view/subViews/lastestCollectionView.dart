import '../../helper/goTransittedPage.dart';
import '../../const.dart';
import '../../core/viewModel/filterViewModel.dart';
import '../../model/productModel.dart';
import '../../view/subViews/productDetails/productDetails.dart';
import '../../view/widgets/customColumImgTT.dart';
import '../../view/widgets/customText.dart';
import '../../view/widgets/cutomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastestCollectionView extends StatelessWidget {
  final List<ProductModel> allProducts;
  final String season;
  const LastestCollectionView(
      {@required this.allProducts, @required this.season});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterViewModel>(
      init: FilterViewModel(),
      builder: (filterController) {
        List<ProductModel> filteredProducts = filterController.isFiltered
            ? filterController.filteredProducts
            : allProducts.where((prod) => prod.season == season).toList();
        return Scaffold(
          key: filterController.catFilterKey,
          endDrawer: CustomDrawer(),
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
                            txt: season.capitalize,
                            fSize: 20,
                            fWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => filterController.openFilterDrawer(
                            searchFilter: false, products: filteredProducts),
                        child: Image.asset(
                          'assets/shop/filter.png',
                          color: filterController.isFiltered ? priColor : null,
                        )),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 140,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 140,
                      ),
                      itemBuilder: (context, x) => GestureDetector(
                        onTap: () => Go.to(
                          () => ProductDetails(
                            prod: filteredProducts[x],
                            fromSearchView: false,
                          ),
                        ),
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
