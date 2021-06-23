import 'package:flutter/material.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../model/productModel.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  List<ProductModel> searchProducts = [];
  List<String> allCats = [];
  List<String> recommendedCats = [];
  final HomeViewModel _homeViewModel = Get.find();
  ValueNotifier<bool> _isSearchResultsView = ValueNotifier<bool>(false);
  ValueNotifier<bool> get isSearchResultsView => _isSearchResultsView;
  SearchViewModel() {
    getRecommendedCats();
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
        searchProducts = _homeViewModel.products
            .where((prod) => prod.classification['sub-cat']
                .toString()
                .contains(searchEntry.capitalizeFirst))
            .toList();
        update();
      }
    } catch (e) {
      Get.snackbar('Alert', e);
    }
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
