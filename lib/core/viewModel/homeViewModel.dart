import '../../core/service/home_service.dart';
import '../../model/categoryModel.dart';
import '../../model/productModel.dart';
import '../../view/mainViews/cartView.dart';
import '../../view/mainViews/homeView.dart';
import '../../view/mainViews/moreView.dart';
import '../../view/mainViews/profileView.dart';
import '../../view/mainViews/searchView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int currentIndex = 0;
  List<Widget> views = [
    HomeView(),
    SearchView(),
    CartView(),
    ProfileView(),
    MoreView(),
  ];
  void changeIndex(index) {
    currentIndex = index;
    update();
  }

  int currentCategory = 0;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  HomeViewModel() {
    getCategories();
    getProducts();
  }
  changeCategories(index) {
    currentCategory = index;
    update();
  }

  getCategories() {
    try {
      _loading.value = true;
      HomeService().getCategoriesFromFireStore().then((value) {
        for (int i = 0; i < value.length; i++) {
          _categories.add(CategoryModel.fromJson(value[i].data()));
          _loading.value = false;
        }
        update();
      });
    } catch (e) {
      print(e);
    }
  }

  getProducts() {
    try {
      _loading.value = true;
      HomeService().getProductsFromFireStore().then((value) {
        for (int i = 0; i < value.length; i++) {
          _products.add(ProductModel.fromJson(value[i].data()));
          _loading.value = false;
        }
        update();
      });
    } catch (e) {
      print(e);
    }
  }

//productDetailsView logic

  int selectedColorIndex = 0;
  String selectedColor;
  void changeSelectedColor(index, color) {
    selectedColorIndex = index;
    selectedColor = color;
    update();
  }

  int selectedSizeIndex = 0;
  String selectedSize;
  void changeSelectedSize(index, size) {
    selectedSizeIndex = index;
    selectedSize = size;
    update();
  }

  clearSelectedIndex() {
    selectedColorIndex = selectedSizeIndex = 0;
    selectedColor = null;
    selectedSize = null;
    update();
  }
}
