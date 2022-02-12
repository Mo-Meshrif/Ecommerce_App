import '../../model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterViewModel extends GetxController {
  GlobalKey<ScaffoldState> searchFilterKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> catFilterKey = GlobalKey<ScaffoldState>();
  bool fromSearch = false;
  List<ProductModel> nonFilteredProducts = [];
  List<ProductModel> filteredProducts = [];
  List<String?> avCategories = [],
      avConditions = [],
      avMaterials = [],
      avBrands = [];
  String? selectedCategory, selectedCondition, selectedMaterial, selectedBrand;
  bool isFiltered = false;
  openFilterDrawer(
      {required bool searchFilter, required List<ProductModel> products}) {
    getFilteredListItems(products);
    fromSearch = searchFilter;
    nonFilteredProducts = products;
    update();
    if (searchFilter) {
      searchFilterKey.currentState!.openEndDrawer();
    } else {
      catFilterKey.currentState!.openEndDrawer();
    }
  }

  getFilteredListItems(List<ProductModel> nonFilteredProducts) {
    clearFilteredListItems();
    nonFilteredProducts.forEach((prod) {
      avCategories.add(prod.classification!['category']);
      avConditions.add(prod.condition);
      avMaterials.add(prod.material);
      avBrands.add(prod.brand);
    });
    update();
  }

  clearFilteredListItems() {
    avCategories = [];
    avConditions = [];
    avMaterials = [];
    avBrands = [];
    update();
  }

  changeCatTxt(String selectedVal) {
    selectedCategory = selectedVal;
    update();
  }

  changeConditionTxt(String selectedVal) {
    selectedCondition = selectedVal;
    update();
  }

  changeMaterialTxt(String selectedVal) {
    selectedMaterial = selectedVal;
    update();
  }

  changeBrandTxt(String selectedVal) {
    selectedBrand = selectedVal;
    update();
  }

  applyFilters() {
    isFiltered = true;
    filteredProducts = nonFilteredProducts
        .where((prod) =>
            prod.classification!['category'] ==
                (selectedCategory ?? avCategories[0]) &&
            prod.condition == (selectedCondition ?? avConditions[0]) &&
            prod.material == (selectedMaterial ?? avMaterials[0]) &&
            prod.brand == (selectedBrand ?? avBrands[0]))
        .toList();
    update();
    Get.back();
  }

  clearFilters() {
    selectedCategory = null;
    selectedCondition = null;
    selectedMaterial = null;
    selectedBrand = null;
    isFiltered = false;
    update();
  }
}
