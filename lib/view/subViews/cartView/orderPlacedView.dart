import '../../../helper/goTransittedPage.dart';
import '../../../view/subViews/moreView/orderView/allOrdersView.dart';
import '../../../view/widgets/customElevatedButton.dart';
import '../../../view/widgets/customText.dart';
import '../../../core/viewModel/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const.dart';

class OrderPlacedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: Column(
          children: [
            GetBuilder<HomeViewModel>(
              builder: (homeController) => Container(
                alignment: Alignment(1.1, 0),
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    homeController.changeIndex(0);
                    Get.back();
                  },
                  color: priColor,
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/cart/pass.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  txt: 'Order Placed!',
                  fSize: 30,
                  fWeight: FontWeight.w500,
                  txtColor: swatchColor,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  txt: 'Your order was placed successfully.',
                  fSize: 15,
                  txtColor: swatchColor,
                ),
                CustomText(
                  txt: 'For more details, check All My Orders',
                  fSize: 15,
                  txtColor: swatchColor,
                ),
                CustomText(
                  txt: 'page under Profile tab',
                  fSize: 15,
                  txtColor: swatchColor,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 180,
                  child: CustomElevatedButton(
                    txt: 'MY ORDERS',
                    imgUrl: 'assets/auth/right_arrow.png',
                    onPress: () => Go.to(() => AllOrdersView()),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
