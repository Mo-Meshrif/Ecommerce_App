import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/lastestCollectionModel.dart';
import '../../model/userModel.dart';
import '../../core/service/fireStore_review.dart';
import '../../model/rewiewModel.dart';
import '../../core/service/home_service.dart';
import '../../model/categoryModel.dart';
import '../../model/productModel.dart';
import '../../view/mainViews/cartView.dart';
import '../../view/mainViews/homeView.dart';
import '../../view/mainViews/moreView.dart';
import '../../view/mainViews/searchView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int currentIndex = 0;
  List<Widget> views = [
    HomeView(),
    SearchView(),
    CartView(),
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
  List<LastestCollectionModel> _lastestCollections = [];
  List<LastestCollectionModel> get lastestCollections => _lastestCollections;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  onInit() {
    getCategories();
    getProducts();
    getLastestCollections();
    getAllReviews();
    super.onInit();
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
          _categories.add(CategoryModel.fromJson(
            value[i].id,
            value[i].data(),
          ));
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
          Map<String, dynamic> data = value[i].data();
          _products.add(ProductModel(
            id: value[i].id,
            customerId: data['customerId'],
            prodName: data['prodName'],
            imgUrl: data['imgUrl'],
            season: data['season'],
            color: data['color'],
            size: data['size'],
            price: data['price'],
            createdAt: data['createdAt'],
            brand: data['brand'],
            condition: data['condition'],
            material: data['material'],
            sku: data['sku'],
            classification: data['classification'],
            trending: data['trending'],
          ));
          _loading.value = false;
        }
        update();
      });
    } catch (e) {
      print(e);
    }
  }

  getLastestCollections() {
    try {
      _loading.value = true;
      HomeService().getLastestCollectionsFromFireStore().then((value) {
        for (int i = 0; i < value.length; i++) {
          _lastestCollections
              .add(LastestCollectionModel.fromJson(value[i].data()));
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

//review logic
  double rateValue = 0;
  String reviewText;
  ValueNotifier<bool> _reviewLoading = ValueNotifier(false);
  ValueNotifier<bool> get reviewloading => _reviewLoading;
  List<ReviewModel> reviews = [];

  addReview(id, imgurl, UserModel user) async {
    _reviewLoading.value = true;
    reviews = [];
    update();
    await FireStoreReview()
        .addReviewToFireStore(
            ReviewModel(
                prodId: id,
                userName: user.userName,
                reviewTxt: reviewText,
                createdAt: Timestamp.now(),
                rateValue: rateValue),
            user.id)
        .then((_) => getAllReviews());
  }

  getAllReviews() async {
    await FireStoreReview().getAllReviewsFromFireStore().then((value) {
      for (int i = 0; i < value.length; i++) {
        reviews.add(ReviewModel.fromJson(value[i].data()));
      }
      _reviewLoading.value = false;
      update();
    });
  }
}
