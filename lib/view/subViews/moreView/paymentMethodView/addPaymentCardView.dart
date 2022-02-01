import 'package:get/get.dart';
import '../../../../view/widgets/customAppBar.dart';
import '../../../../model/paymentMethodModel.dart';
import '../../../../view/widgets/customText.dart';
import '../../../../const.dart';
import '../../../../core/viewModel/moreViewModel.dart';
import 'package:flutter/material.dart';

class AddPaymentCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Card',
        backFun: () => Get.back(),
      ),
      body: GetBuilder<MoreViewModel>(
        builder: (moreController) => SingleChildScrollView(
          child: Form(
              key: moreController.paymentKey,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    color: Colors.grey[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: imgCards
                          .map((e) => GestureDetector(
                                onTap: () =>
                                    moreController.getSelectedCardImg(e),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    moreController.cardImage == e
                                        ? Container(
                                            margin: EdgeInsets.only(top: 3),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 50,
                                            width: 80,
                                          )
                                        : Padding(padding: EdgeInsets.zero),
                                    moreController.cardImage == e
                                        ? Positioned(
                                            top: 0,
                                            right: 2,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.green,
                                              radius: 8,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ),
                                          )
                                        : Padding(padding: EdgeInsets.zero),
                                    Image.asset(
                                      e,
                                      width: 60,
                                      height: 60,
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CustomColWidget(
                            title: 'CARD NUMBER',
                            widget: TextFormField(
                              maxLength: 16,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'The Value is Empty';
                                }
                                return null;
                              },
                              onChanged: (val) =>
                                  moreController.getCardNumber(val),
                              decoration: InputDecoration(
                                hintText: '1234 4567 8945 7545',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            hasValue: moreController.cardNumber != '',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: CustomColWidget(
                                title: 'EXPIRATION DATE',
                                widget: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'The Value is Empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) =>
                                      moreController.getExpireDate(val),
                                  decoration: InputDecoration(
                                    hintText: '18/20',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                hasValue: moreController.expireDate != '',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: 80,
                              child: CustomColWidget(
                                title: 'CVV',
                                widget: TextFormField(
                                  maxLength: 3,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'The Value is Empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) =>
                                      moreController.getCvv(val),
                                  decoration: InputDecoration(
                                    hintText: '123',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                hasValue: moreController.cvv != '',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        CustomColWidget(
                          title: 'CARD HOLDER’S NAME',
                          widget: TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'The Value is Empty';
                              }
                              return null;
                            },
                            onChanged: (val) =>
                                moreController.getCardHolderName(val),
                            decoration: InputDecoration(
                              hintText: 'Mohamed Meshrif',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          hasValue: moreController.cardHolderName != '',
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                textStyle: const TextStyle(fontSize: 20),
                                primary: priColor,
                              ),
                              onPressed: () {
                                moreController.paymentKey.currentState.save();
                                if (moreController.paymentKey.currentState
                                    .validate()) {
                                  moreController.addPayment(PaymentMehodModel(
                                    isSelected: 1,
                                    cardImage: moreController.cardImage,
                                    cardNumber: moreController.cardNumber,
                                    expireDate: moreController.expireDate,
                                    cvv: moreController.cvv,
                                    cardHolderName: moreController
                                        .cardHolderName.capitalize,
                                  ));
                                }
                              },
                              child: CustomText(
                                txt: 'Add Card',
                                txtColor: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class CustomColWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  final bool hasValue;
  CustomColWidget(
      {@required this.title, @required this.widget, @required this.hasValue});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txt: title,
          txtColor: Colors.grey,
          fSize: 15,
        ),
        SizedBox(height: 10),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: widget,
            ),
            hasValue
                ? Positioned(
                    bottom:
                        title == 'CVV' || title == 'CARD NUMBER' ? 43 : null,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  )
                : Padding(padding: EdgeInsets.zero)
          ],
        )
      ],
    );
  }
}
