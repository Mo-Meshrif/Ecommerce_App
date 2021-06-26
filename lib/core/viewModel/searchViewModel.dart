import 'package:ecommerce/helper/localStorageData.dart';
import 'package:flutter/material.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../model/productModel.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  int currentIndex = 0;
  List<ProductModel> searchProducts = [];
  List<ProductModel> recentlyViewedProducts = [];
  List<String> allCats = [];
  List<String> recommendedCats = [];
  final HomeViewModel _homeViewModel = Get.find();
  ValueNotifier<bool> _isSearchResultsView = ValueNotifier<bool>(false);
  ValueNotifier<bool> get isSearchResultsView => _isSearchResultsView;
  final LocalStorageData _localStorageData = Get.find();
  SearchViewModel() {
    getRecommendedCats();
    getRecentlyViewedProductsFormLocal();
  }
  @override
  void onClose() {
    _localStorageData
        .setrecentlyViewedProductsData(recentlyViewedProducts.toSet().toList());
    super.onClose();
  }

  void changeIndex(index) {
    currentIndex = index;
    update();
  }

  changeSearchState(bool state) {
    _isSearchResultsView.value = state;
    update();
  }

  getSearchedProducts(String searchEntry) {
    try {
      _isSearchResultsView.value = true;
      update();
      if (searchProducts.length > 0) {
        searchProducts = [];
        update();
      } else {
        if (searchEntry == '') {
          return;
        }
        searchProducts = _homeViewModel.products
            .where((prod) => prod.classification['sub-cat']
                .toString()
                .startsWith(searchEntry.capitalizeFirst))
            .toList();
        update();
      }
    } catch (e) {
      Get.snackbar('Alert', e);
    }
  }

  clearSearchedProducts() {
    searchProducts = [];
    update();
  }

  getRecentlyViewedProducts(ProductModel prod) {
    recentlyViewedProducts.add(prod);
    update();
  }

  getRecentlyViewedProductsFormLocal() async {
    await _localStorageData.getrecentlyViewedProducts.then((value) {
      if (value == null) {
        return;
      }
      recentlyViewedProducts = value;
    });
    update();
  }

  clearRecentlyViewedProducts() {
    recentlyViewedProducts = [];
    _localStorageData.deleterecentlyViewedProductsData();
    update();
  }

  getRecommendedCats() {
    _homeViewModel.products.forEach((prod) {
      allCats.add(prod.classification['sub-cat']);
    });
    recommendedCats = allCats.toSet().toList();
    update();
  }

  shuffleRecommendedCats() {
    recommendedCats.shuffle();
    update();
  }
}
