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
}
