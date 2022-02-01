import '../../../const.dart';
import '../../../model/orderModel.dart';
import '../../../view/subViews/moreView/paymentMethodView/addPaymentCardView.dart';
import '../../../view/subViews/moreView/shippingAddressView/AddShippingAddressView.dart';
import '../../../model/paymentMethodModel.dart';
import '../../../model/shippingAddressModel.dart';
import '../../../core/viewModel/moreViewModel.dart';
import '../../../view/widgets/bottomCartBar.dart';
import '../../../core/viewModel/cartViewModel.dart';
import '../../../model/cartProductModel.dart';
import '../../../view/widgets/customCartItem.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<CartViewModel>(
          builder: (cartController) {
            List<CartProductModel> cartProds = cartController.cartProds;
            String totalPrice = cartController.totalPrice;
            return Column(children: [
              cartController.orderloading.value
                  ? Expanded(
                      child:
                          Center(child: CircularProgressIndicator.adaptive()))
                  : Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              alignment: Alignment(1.05, 0),
                              child: IconButton(
                                iconSize: 30,
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  cartController.deleteSavedOrderNumber();
                                  Get.back();
                                },
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
                              builder: (moreController) {
                                ShippingAddressModel specificShippingAddress;
                                if (moreController.shippingList.isNotEmpty) {
                                  specificShippingAddress =
                                      moreController.shippingList.firstWhere(
                                          (element) => element.isSelected == 1);
                                }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    specificShippingAddress != null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                txt: specificShippingAddress
                                                    .fullName.capitalizeFirst,
                                                fSize: 15,
                                                fWeight: FontWeight.bold,
                                                txtColor: swatchColor,
                                              ),
                                              CustomText(
                                                txt: specificShippingAddress
                                                    .mobileNumber,
                                                fSize: 15,
                                                txtColor: swatchColor,
                                              ),
                                              CustomText(
                                                txt: specificShippingAddress
                                                        .street +
                                                    ',' +
                                                    specificShippingAddress
                                                        .city +
                                                    ',' +
                                                    specificShippingAddress
                                                        .state,
                                                fSize: 15,
                                                txtColor: swatchColor,
                                              ),
                                            ],
                                          )
                                        : GestureDetector(
                                            onTap: () => Get.to(
                                                () => AddShippingAddressView()),
                                            child: CustomText(
                                              txt:
                                                  'Add your address,please..........',
                                              txtColor: priColor,
                                            ),
                                          ),
                                    GestureDetector(
                                      onTap: () {
                                        moreController.clearShippingData();
                                        Get.to(() => AddShippingAddressView());
                                      },
                                      child: Image.asset(
                                          'assets/home/right_arrow_c.png'),
                                    )
                                  ],
                                );
                              },
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
                                  onChanged: (val) =>
                                      cartController.changePay(val),
                                  secondary: Image.asset(
                                    'assets/cart/cashOnDelivery.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                GetBuilder<MoreViewModel>(
                                  builder: (moreController) {
                                    List<PaymentMehodModel> paymentsList =
                                        moreController.paymentsList;
                                    PaymentMehodModel specificPayment;
                                    if (paymentsList.isNotEmpty) {
                                      specificPayment = paymentsList.firstWhere(
                                          (element) => element.isSelected == 1);
                                    }
                                    return RadioListTile(
                                      title: CustomText(
                                          txt: paymentsList.isEmpty
                                              ? 'Credit Card'
                                              : specificPayment.cardNumber
                                                  .replaceAll(
                                                      RegExp(r'\d(?!\d{0,3}$)'),
                                                      '* ')),
                                      value: paymentMethod.masterCard,
                                      groupValue: cartController.pay,
                                      onChanged: (val) {
                                        if (paymentsList.isEmpty) {
                                          Get.to(() => AddPaymentCardView());
                                        }

                                        cartController.changePay(val);
                                      },
                                      secondary: Image.asset(
                                        paymentsList.isEmpty
                                            ? 'assets/cart/card.png'
                                            : specificPayment.cardImage,
                                        height: 50,
                                        width: 50,
                                      ),
                                    );
                                  },
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
                              padding: EdgeInsets.zero,
                              itemCount: cartProds.length,
                              itemBuilder: (context, i) => CustomCartItem(
                                  cartProd: cartProds[i],
                                  increase: () =>
                                      cartController.increaseQuantity(i),
                                  decrease: () =>
                                      cartController.decreaseQuantity(i, false),
                                  onDismiss: null,
                                  fromCheckoutView: true),
                              separatorBuilder: (context, i) => Divider(
                                indent:
                                    MediaQuery.of(context).size.width * 0.25,
                              ),
                            )),
                            GestureDetector(
                              onTap: () => Get.bottomSheet(
                                Container(
                                  height: 130,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: TextFormField(
                                          initialValue:
                                              cartController.promoCode,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder()),
                                          onChanged: (val) =>
                                              cartController.addPromoCode(val),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: priColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.all(5),
                                        ),
                                        onPressed: () => Get.back(),
                                        child: CustomText(
                                          txt: 'Apply',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image.asset('assets/cart/promo.png'),
                                title: CustomText(
                                  txt: cartController.promoCode != ''
                                      ? cartController.promoCode
                                      : 'Add Promo Code',
                                  fSize: 15,
                                  fWeight: FontWeight.bold,
                                  txtColor: priColor,
                                ),
                                horizontalTitleGap: 0,
                                trailing: Image.asset(
                                    'assets/home/right_arrow_c.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              GetBuilder<MoreViewModel>(
                builder: (moreController) {
                  List<PaymentMehodModel> paymentsList =
                      moreController.paymentsList;
                  List<ShippingAddressModel> shippingList =
                      moreController.shippingList;
                  ShippingAddressModel specificShipping;
                  PaymentMehodModel specificPayment;
                  if (shippingList.isNotEmpty) {
                    specificShipping = shippingList
                        .firstWhere((element) => element.isSelected == 1);
                  }
                  if (paymentsList.isNotEmpty) {
                    specificPayment = paymentsList
                        .firstWhere((element) => element.isSelected == 1);
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    width: double.infinity,
                    color: Colors.white,
                    child: BottomCartBar(
                        totalPrice: totalPrice,
                        buttonTxt: 'PLACE ORDER',
                        onPress: () {
                          if (specificShipping == null) {
                            Get.snackbar(
                                'Attention', 'Add your address,please !',
                                snackPosition: SnackPosition.TOP);
                          } else {
                            cartController.addOrder(OrderModel(
                              customerId: moreController.savedUser.id,
                              status: 'Pending',
                              promoCode: cartController.promoCode,
                              createdAt: Timestamp.now(),
                              orderTrack: [
                                {
                                  'title': 'Order Placed',
                                  'subTitle': 'We have received your order on',
                                  'createdAt': Timestamp.now(),
                                  'status': true
                                },
                                {
                                  'title': 'Order Confirmed',
                                  'subTitle': 'We has been confirmed on',
                                  'createdAt': null,
                                  'status': false
                                },
                                {
                                  'title': 'Order Processed',
                                  'subTitle': 'We are preparing your order',
                                  'status': false
                                },
                                {
                                  'title': 'Ready to Ship',
                                  'subTitle':
                                      'Your order is ready for shipping',
                                  'status': false
                                },
                                {
                                  'title': 'Out for Delivery',
                                  'subTitle': 'Your order is Out for Delivery',
                                  'status': false
                                },
                              ],
                              orderNumber: cartController.orderNumber,
                              shippingAdress: {
                                'fullName': specificShipping.fullName,
                                'mobileNumber': specificShipping.mobileNumber,
                                'state': specificShipping.state,
                                'city': specificShipping.city,
                                'street': specificShipping.street,
                              },
                              paymentMehod: specificPayment == null
                                  ? {
                                      'paymentMehod': 'Cash on Delivery',
                                    }
                                  : {
                                      'paymentMehod': specificPayment.cardImage
                                          .split('/')
                                          .last
                                          .split(".")[0],
                                      'delails': {
                                        'cardHolderName':
                                            specificPayment.cardHolderName,
                                        'cardNumber':
                                            specificPayment.cardNumber,
                                        'cvv': specificPayment.cvv,
                                        'expireDate':
                                            specificPayment.expireDate,
                                      }
                                    },
                              items: cartProds
                                  .map((e) => {
                                        'name': e.name,
                                        'imgUrl': e.imgUrl,
                                        'size': e.size,
                                        'color': e.color,
                                        'price': e.price,
                                        'quantity': e.quantity,
                                      })
                                  .toList(),
                              totalPrice: totalPrice,
                            ));
                          }
                        }),
                  );
                },
              ),
              SizedBox(height: 10)
            ]);
          },
        ));
  }
}
