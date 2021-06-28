import '../core/viewModel/filterViewModel.dart';
import '../view/widgets/cutomDrawer.dart';
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
            init: HomeViewModel(),
            builder: (homeController) => GetBuilder<FilterViewModel>(
              init: FilterViewModel(),
              builder: (filterController) => Scaffold(
                endDrawer: CustomDrawer(),
                key: filterController.searchFilterKey,
                body: homeController.loading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : homeController.views[homeController.currentIndex],
                bottomNavigationBar: BottomNavBar(),
              ),
            ),
          ));
  }
}
