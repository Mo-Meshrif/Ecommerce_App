import '../../core/viewModel/moreViewModel.dart';
import '../../model/cartProductModel.dart';
import '../../core/viewModel/cartViewModel.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customText.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        //initialize cartViewModel,moreViewModel
        Get.put(MoreViewModel());
        Get.put(CartViewModel());
        return GetBuilder<CartViewModel>(
          init: Get.find(),
          builder: (cartController) {
            List<CartProductModel> cartProds = cartController.cartProds;
            return BottomNavigationBar(
                selectedItemColor: priColor,
                unselectedItemColor: swatchColor,
                showUnselectedLabels: true,
                currentIndex: controller.currentIndex,
                onTap: (index) => controller.changeIndex(index),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        Container(
                            height: 25,
                            width: 65,
                            child: Icon(Icons.shopping_cart_outlined)),
                        cartProds.length == 0
                            ? Padding(padding: EdgeInsets.zero)
                            : Positioned(
                                top: 5,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: priColor,
                                  child: CustomText(
                                    txt: cartProds.length.toString(),
                                    txtColor: Colors.white,
                                  ),
                                ),
                              )
                      ],
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'More',
                  ),
                ]);
          },
        );
      },
    );
  }
}
