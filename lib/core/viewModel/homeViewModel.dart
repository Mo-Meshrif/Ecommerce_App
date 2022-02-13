import 'package:cloud_firestore/cloud_firestore.dart';
import '/helper/networkManager.dart';
import '/helper/dynamicLinkHelper.dart';
import '../../model/lastestCollectionModel.dart';
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
  Map<String?, String> dynamicUrls = {};
  onInit() {
    getCategories();
    getProducts();
    getLastestCollections();
    retrieveDynamicLink();
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
            value[i].data() as Map<String, dynamic>,
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
          Map<String, dynamic> data = value[i].data() as Map<String, dynamic>;
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
          _lastestCollections.add(LastestCollectionModel.fromJson(
              value[i].data() as Map<String, dynamic>));
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
  String? selectedColor;
  void changeSelectedColor(index, color) {
    selectedColorIndex = index;
    selectedColor = color;
    update();
  }

  int selectedSizeIndex = 0;
  String? selectedSize;
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
  String? reviewText;
  ValueNotifier<bool> _reviewLoading = ValueNotifier(false);
  ValueNotifier<bool> get reviewloading => _reviewLoading;

  addReview(pId,uid) {
    if (Get.find<NetworkManager>().isConnected) {
       _reviewLoading.value = true;
        update();
        FireStoreReview()
            .addReviewToFireStore(
          ReviewModel(
              prodId: pId,
              userId: uid,
              reviewTxt: reviewText,
              createdAt: Timestamp.now(),
              rateValue: rateValue),
        )
            .then((_) {
          reviewText = null;
          rateValue = 0;
          _reviewLoading.value = false;
          update();
        });
    } else {
      Get.snackbar(
        'Network Error',
        'There is no internet connection !',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    }
  }

  deleteReview(String revId) {
    if (Get.find<NetworkManager>().isConnected) {
      FireStoreReview().deleteReview(revId);
    } else {
      Get.snackbar(
        'Network Error',
        'There is no internet connection !',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    }
  }

  //DynamicLink logic
  createDynamicLink(String? id) {
    try {
      if (Get.find<NetworkManager>().isConnected) {
        if (!dynamicUrls.containsKey(id)) {
          DynamicLinkHelper().createDynamicLink(id).then((value) {
            dynamicUrls[id] = value.toString();
            update();
          });
        }
      } else {
        Get.snackbar(
          'Network Error',
          'There is no internet connection !',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String? getspecDynamicUrl(String? id) {
    return dynamicUrls.containsKey(id) ? dynamicUrls[id] : null;
  }

  retrieveDynamicLink() {
    DynamicLinkHelper().retrieveDynamicLink();
  }
}
