import '../../view/cartView.dart';
import '../../view/homeView.dart';
import '../../view/moreView.dart';
import '../../view/profileView.dart';
import '../../view/searchView.dart';
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
}
