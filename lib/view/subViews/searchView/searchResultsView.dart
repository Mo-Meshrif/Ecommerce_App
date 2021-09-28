import '../../../view/widgets/cutomDrawer.dart';
import '../../../const.dart';
import '../../../core/viewModel/filterViewModel.dart';
import '../../../model/productModel.dart';
import '../../../view/subViews/searchView/searchRSortView.dart';
import '../../../core/viewModel/searchViewModel.dart';
import '../../../view/widgets/customSearchBar.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultsView extends StatelessWidget {
  final List<ProductModel> allProds;
  SearchResultsView({@required this.allProds});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      builder: (searchController) => GetBuilder<FilterViewModel>(
        init: FilterViewModel(),
        builder: (filteredController) {
          List<ProductModel> searchedProducts = filteredController.isFiltered
              ? filteredController.filteredProducts
              : searchController.searchProducts;
          List<ProductModel> searchedLhProducts = []..addAll(searchedProducts);
          searchedLhProducts.sort((a, b) => a.price.compareTo(b.price));
          List<ProductModel> searchedHlProducts =
              searchedLhProducts.reversed.toList();
          int currentIndex = searchController.currentIndex;
          return Scaffold(
            key: filteredController.searchFilterKey,
            endDrawer: CustomDrawer(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 45),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          searchController.clearSearchedProducts();
                        },
                        child: Image.asset('assets/shop/back.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomSearchBar(
                          autoFocus: true,
                          onChanged: (val) {
                            filteredController.clearFilters();
                            searchController.getSearchedProducts(
                              searchEntry: val,
                              prods: allProds,
                            );
                          },
                          onTap: null,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () => searchedProducts.isEmpty &&
                                !filteredController.isFiltered
                            ? null
                            : filteredController.openFilterDrawer(
                                searchFilter: true, products: searchedProducts),
                        child: Image.asset(
                          'assets/shop/filter.png',
                          color:
                              filteredController.isFiltered ? priColor : null,
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
                        onTap: () => searchController.changeIndex(0),
                        child: CustomText(
                          txt: 'BEST MATCH',
                          txtColor: currentIndex == 0 ? priColor : swatchColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => searchController.changeIndex(1),
                        child: CustomText(
                          txt: 'PRICE LOW-HIGH',
                          txtColor: currentIndex == 1 ? priColor : swatchColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => searchController.changeIndex(2),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
