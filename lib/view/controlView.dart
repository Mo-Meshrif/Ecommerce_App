import '../core/viewModel/authViewModel.dart';
import 'mainViews/authView.dart';
import '../core/viewModel/homeViewModel.dart';
import 'widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.user == null)
        ? AuthView()
        : GetBuilder<HomeViewModel>(
            builder: (homeController) => Scaffold(
              body: homeController.views[homeController.currentIndex],
              bottomNavigationBar: BottomNavBar(),
            ),
          ));
  }
}
