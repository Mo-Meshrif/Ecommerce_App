import '../../../../helper/goTransittedPage.dart';
import '../../../../model/paymentMethodModel.dart';
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
        List<PaymentMehodModel> cardList =
            moreController.paymentsList!.reversed.toList();
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Payment Method',
            backFun: () => Get.back(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: cardList
                      .map(
                        (e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 175,
                              child: Dismissible(
                                key: Key(e.id.toString()),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20),
                                  color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete, color: Colors.white),
                                      Text('Delete',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                onDismissed: (_) =>
                                    moreController.deleteOnePayment(e.id),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              e.cardImage!,
                                              height: 50,
                                            ),
                                            GestureDetector(
                                              onTap: () => moreController
                                                  .updateSelectedPaymentsParameter(
                                                      e.id),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: e.isSelected == 1
                                                        ? Colors.blue
                                                        : Colors.white,
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        CustomText(
                                          txt: e.cardNumber!.replaceAll(
                                              RegExp(r'\d(?!\d{0,3}$)'), '* '),
                                          fSize: 15,
                                        ),
                                        SizedBox(height: 5),
                                        CustomText(
                                          txt: e.cvv,
                                          fSize: 15,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              txt: e.cardHolderName,
                                              fSize: 15,
                                            ),
                                            CustomText(
                                              txt: e.expireDate,
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
                    onTap: () => Go.to(() => AddPaymentCardView()),
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
          ),
        );
      },
    );
  }
}
