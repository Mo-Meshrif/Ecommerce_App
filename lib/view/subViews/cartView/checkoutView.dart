import '../../../core/viewModel/moreViewModel.dart';
import '../../../view/subViews/moreView/shippingAddressView/shippingAddressView.dart';
import '../../../view/subViews/cartView/orderPlacedView.dart';
import '../../../view/widgets/bottomCartBar.dart';
import '../../../core/viewModel/cartViewModel.dart';
import '../../../model/cartProductModel.dart';
import '../../../view/widgets/customCartItem.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<CartViewModel>(
      builder: (cartController) {
        List<CartProductModel> cartProds = cartController.cartProds;
        double totalPrice = cartController.totalPrice;
        return Column(children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    alignment: Alignment(1.1, 0),
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.close),
                      onPressed: () => Get.back(),
                      color: priColor,
                    ),
                  ),
                  CustomText(
                    txt: 'Checkout',
                    fSize: 30,
                    fWeight: FontWeight.bold,
                    txtColor: swatchColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    txt: 'SHIPPING ADDRESS',
                    fSize: 15,
                    fWeight: FontWeight.w300,
                    txtColor: swatchColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<MoreViewModel>(
                    builder: (moreController) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        moreController.specificShippingAddress != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    txt: moreController
                                        .specificShippingAddress.fullName,
                                    fSize: 15,
                                    fWeight: FontWeight.bold,
                                    txtColor: swatchColor,
                                  ),
                                  CustomText(
                                    txt: moreController
                                        .specificShippingAddress.mobileNumber,
                                    fSize: 15,
                                    txtColor: swatchColor,
                                  ),
                                  CustomText(
                                    txt: moreController
                                            .specificShippingAddress.street +
                                        ',' +
                                        moreController
                                            .specificShippingAddress.city +
                                        ',' +
                                        moreController
                                            .specificShippingAddress.state,
                                    fSize: 15,
                                    txtColor: swatchColor,
                                  ),
                                ],
                              )
                            : CustomText(
                                txt: 'Add your address,please..........',
                                txtColor: priColor,
                              ),
                        GestureDetector(
                          onTap: () => Get.to(() => ShippingView()),
                          child: Image.asset('assets/home/right_arrow_c.png'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: CustomText(
                      txt: 'PAYMENT METHOD',
                      fSize: 15,
                      fWeight: FontWeight.w300,
                      txtColor: swatchColor,
                    ),
                    childrenPadding: EdgeInsets.only(bottom: 10),
                    children: [
                      RadioListTile(
                        title: CustomText(txt: 'Cash On Delivery'),
                        value: paymentMethod.cashOnDelivery,
                        groupValue: cartController.pay,
                        onChanged: (val) => cartController.changePay(val),
                        secondary: Image.asset(
                          'assets/cart/cashOnDelivery.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      RadioListTile(
                        title: CustomText(txt: 'Credit Card'),
                        value: paymentMethod.masterCard,
                        groupValue: cartController.pay,
                        onChanged: (val) => cartController.changePay(val),
                        secondary: Image.asset(
                          'assets/cart/card.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    txt: 'ITEMS',
                    fSize: 15,
                    fWeight: FontWeight.w300,
                    txtColor: swatchColor,
                  ),
                  Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: cartProds.length,
                        itemBuilder: (context, i) => Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomCartItem(
                                        cartProd: cartProds[i],
                                        increase: () =>
                                            cartController.increaseQuantity(i),
                                        decrease: () => cartController
                                            .decreaseQuantity(i, false),
                                        onDismiss: null,
                                        fromCheckoutView: true),
                                    Divider(
                                      indent:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25),
                                      child: CustomText(
                                        txt: 'Message to seller (optional)',
                                        fSize: 15,
                                        fWeight: FontWeight.w300,
                                        txtColor: swatchColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading:
                                          Image.asset('assets/cart/promo.png'),
                                      title: CustomText(
                                        txt: 'Add Promo Code',
                                        fSize: 15,
                                        fWeight: FontWeight.bold,
                                        txtColor: priColor,
                                      ),
                                      horizontalTitleGap: 0,
                                      trailing: GestureDetector(
                                        onTap: null,
                                        child: Image.asset(
                                            'assets/home/right_arrow_c.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, i) => SizedBox(
                              width: 25,
                            )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            width: double.infinity,
            color: Colors.white,
            child: BottomCartBar(
              totalPrice: totalPrice,
              buttonTxt: 'PLACE ORDER',
              onPress: () => Get.to(() => OrderPlacedView()),
            ),
          ),
        ]);
      },
    ));
  }
}
