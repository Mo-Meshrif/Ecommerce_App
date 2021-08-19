import '../../../../core/viewModel/moreViewModel.dart';
import '../../../../view/widgets/customAppBar.dart';
import '../../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'addPaymentCardView.dart';

class PaymentMethodView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreViewModel>(
      init: Get.find(),
      builder: (moreController) {
        List cardList = [1];
        return Scaffold(
          appBar: CustomAppBar(
            title: !moreController.isAdd.value ? 'Payment Method' : 'Add Card',
            backFun: () => moreController.isAdd.value
                ? moreController.changeShippingState(false)
                : Get.back(),
          ),
          body: !moreController.isAdd.value
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: cardList
                            .map(
                              (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: GestureDetector(
                                    onTap: () => null,
                                    child: Container(
                                      height: 175,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: 20,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/profile-more/mastercard.png',
                                                    height: 50,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              CustomText(
                                                txt: '**** **** **** 1234',
                                                fSize: 15,
                                              ),
                                              SizedBox(height: 5),
                                              CustomText(
                                                txt: '582',
                                                fSize: 15,
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    txt: 'Mohamed Meshrif',
                                                    fSize: 15,
                                                  ),
                                                  CustomText(
                                                    txt: '12/08',
                                                    fSize: 15,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            )
                            .toList(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () => moreController.changeShippingState(true),
                          child: Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 40,
                              ),
                              CustomText(
                                txt: 'Add New Card',
                                fSize: 17,
                              )
                            ],
                          )),
                        ),
                      )
                    ],
                  ),
                )
              : AddPaymentCardView(
                  moreController: moreController,
                ),
        );
      },
    );
  }
}
