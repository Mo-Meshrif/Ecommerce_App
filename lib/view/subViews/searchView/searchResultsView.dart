import 'package:ecommerce/const.dart';
import 'package:ecommerce/model/productModel.dart';
import 'package:ecommerce/view/subViews/searchView/searchRSortView.dart';
import '../../../core/viewModel/searchViewModel.dart';
import '../../../view/widgets/customSearchBar.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 45),
      child: GetBuilder<SearchViewModel>(
        builder: (controller) {
          List<ProductModel> searchedProducts = controller.searchProducts;
          List<ProductModel> searchedLhProducts = []..addAll(searchedProducts);
          searchedLhProducts.sort((a, b) => a.price.compareTo(b.price));
          List<ProductModel> searchedHlProducts =
              searchedLhProducts.reversed.toList();
          int currentIndex = controller.currentIndex;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.changeSearchState(false),
                    child: Image.asset('assets/shop/back.png'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomSearchBar(
                      autoFocus: true,
                      onChanged: (val) => controller.getSearchedProducts(val),
                      onTap: null,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => null,
                    child: Image.asset(
                      'assets/shop/filter.png',
                      color: null,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.changeIndex(0),
                    child: CustomText(
                      txt: 'BEST MATCH',
                      txtColor: currentIndex == 0 ? priColor : swatchColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.changeIndex(1),
                    child: CustomText(
                      txt: 'PRICE LOW-HIGH',
                      txtColor: currentIndex == 1 ? priColor : swatchColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.changeIndex(2),
                    child: CustomText(
                      txt: 'PRICE HIGH-LOW',
                      txtColor: currentIndex == 2 ? priColor : swatchColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              currentIndex == 0
                  ? SearchRSortView(products: searchedProducts)
                  : currentIndex == 1
                      ? SearchRSortView(products: searchedLhProducts)
                      : SearchRSortView(products: searchedHlProducts)
            ],
          );
        },
      ),
    );
  }
}
