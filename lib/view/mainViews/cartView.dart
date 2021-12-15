import '../../core/viewModel/homeViewModel.dart';
import '../../view/subViews/cartView/checkoutView.dart';
import '../../const.dart';
import '../../view/widgets/bottomCartBar.dart';
import '../../core/viewModel/cartViewModel.dart';
import '../../model/cartProductModel.dart';
import '../../view/widgets/customCartItem.dart';
import '../../view/widgets/customText.dart';
import '../../view/widgets/messagesNotBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (homeController) => Scaffold(
        body: GetBuilder<CartViewModel>(
          init: Get.find(),
          builder: (cartController) {
            List<CartProductModel> cartProds = cartController.cartProds;
           String totalPrice = cartController.totalPrice;
            return cartProds.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/cart/cart.svg',
                          height: 300,
                          width: 300,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          txt: 'Your Cart is Empty',
                          fSize: 30,
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        MessagesNotBar(),
                        CustomText(
                          txt: 'Cart',
                          fSize: 30,
                          txtColor: swatchColor,
                          fWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: cartProds.length,
                            itemBuilder: (context, i) => CustomCartItem(
                              cartProd: cartProds[i],
                              increase: () =>
                                  cartController.increaseQuantity(i),
                              decrease: () =>
                                  cartController.decreaseQuantity(i, false),
                              onDismiss: (_) => cartController.deleteProduct(i),
                              fromCheckoutView: false,
                            ),
                            separatorBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Divider(
                                indent: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BottomCartBar(
                          totalPrice: totalPrice,
                          buttonTxt: 'CHECKOUT',
                          onPress: () {
                            cartController.setOrderNumber();
                            Get.to(() => CheckoutView());
                          },
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
