import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../view/subViews/searchView/searchResultsView.dart';
import '../../../model/productModel.dart';
import '../../../view/subViews/productDetails/productDetails.dart';
import '../../../view/subViews/productsView.dart';
import '../../../view/widgets/customSearchBar.dart';
import '../../../core/viewModel/searchViewModel.dart';
import '../../../const.dart';
import '../../../view/widgets/customRTxtGTxt.dart';
import '../../../view/widgets/customText.dart';
import '../../../view/widgets/messagesNotBar.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      builder: (searchController) {
        List<ProductModel> recentlyViewedProducts =
            searchController.recentlyViewedProducts;
        List<String> recommendedCats = searchController.recommendedCats;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessagesNotBar(),
              SizedBox(height: 15),
              CustomText(
                txt: 'Search',
                txtColor: swatchColor,
                fSize: 30,
                fWeight: FontWeight.bold,
              ),
              SizedBox(height: 20),
              CustomSearchBar(
                autoFocus: false,
                onChanged: (val) => searchController.getSearchedProducts(val),
                onTap: () => Get.to(() => SearchResultsView()),
              ),
              recentlyViewedProducts.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CustomRTxtGTxt(
                        txt1: 'RECENTLY VIEWED',
                        txt2: 'CLEAR',
                        onT: () =>
                            searchController.clearRecentlyViewedProducts(),
                      ),
                    )
                  : Padding(padding: EdgeInsets.zero),
              recentlyViewedProducts.length > 0
                  ? Container(
                      height: 80,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: recentlyViewedProducts.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () => Get.to(() => ProductDetails(
                                    prod: recentlyViewedProducts[i],
                                    fromSearchView: true,
                                  )),
                              child: Row(
                                children: [
                                  Image.network(
                                    recentlyViewedProducts[i].imgUrl,
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        txt: recentlyViewedProducts[i].prodName,
                                      ),
                                      CustomText(
                                        txt: '\$' +
                                            recentlyViewedProducts[i].price,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(padding: EdgeInsets.zero),
              SizedBox(height: 20),
              recommendedCats.length == 0
                  ? Padding(padding: EdgeInsets.zero)
                  : CustomRTxtGTxt(
                      txt1: 'RECOMMENDED',
                      txt2: 'REFRESH',
                      onT: () => searchController.shuffleRecommendedCats(),
                    ),
              SizedBox(height: 15),
              LimitedBox(
                maxHeight: 100,
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount:
                        recommendedCats.length < 6 ? recommendedCats.length : 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 50,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, x) => GestureDetector(
                          onTap: () => Get.to(() => ProductsView(
                                catTxt: null,
                                prodsTxt: recommendedCats[x],
                                fromCategoriesView: false,
                                fromSearchView: true,
                              )),
                          child: Card(
                            child: Center(
                              child: CustomText(
                                txt: recommendedCats[x],
                              ),
                            ),
                          ),
                        )),
              )
            ],
          ),
        );
      },
    );
  }
}
