import '../../../view/widgets/customText.dart';
import '../../../const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 36, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset('assets/shop/back.png')),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            txt: 'Smiley’s Store',
                            fSize: 17,
                          ),
                          CustomText(
                            txt: 'Active',
                          ),
                        ],
                      ),
                      SizedBox(width: size.width * 0.45),
                      CircleAvatar(
                        radius: 20,
                        child: CustomText(
                          txt: joinFirstTwoLetter('Smiley’s Store'),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey[400],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/home/backpack.png',
                          height: 50,
                          width: 60,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            txt: 'Order: #1084028',
                            txtColor: swatchColor,
                            fWeight: FontWeight.bold,
                            fSize: 17,
                          ),
                          CustomText(
                            txt: 'Red Cotton Scarf, 2ft, Dark Red',
                            fSize: 17,
                          ),
                          CustomText(
                            txt: '\$11.00',
                            txtColor: priColor,
                            fSize: 17,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  color: HexColor('#F5F6F8'),
                  child: ListView.separated(
                    padding: EdgeInsets.all(20),
                    itemCount: 1,
                    itemBuilder: (context, i) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CustomText(
                            txt: 'Tuesday, 9:20 AM',
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: size.width * 0.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                txt:
                                    'Dear customer, your order has been shipped.Please see below for the tracking number.UH2983948935B Your parcel should arrive between 10 - 20 days.If you have any questions, please contact us and we will get back to you at our earliest. Thank you for choosing our shop! 😊 ',
                                maxLine: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, i) => SizedBox(height: 10),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                  onSaved: (val) => null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 14),
                    hintText: 'Type your message...',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: null,
                        child: Image.asset(
                          'assets/other/add.png',
                        ),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: null,
                      child: Image.asset(
                        'assets/other/send.png',
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
