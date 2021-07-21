import '../../../const.dart';
import '../../../model/productModel.dart';
import '../../../view/widgets/customText.dart';
import '../../../view/widgets/reviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsRview extends StatelessWidget {
  final ProductModel prod;
  ProductDetailsRview({@required this.prod});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 2,
              itemBuilder: (context, i) => Reviews(
                    fromProductDetails: true,
                    name: 'Mohamed Meshrif',
                    date: '10 Oct, 2018',
                    reviewDetails:
                        'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit,\nsed do eiusmod tempor incididunt',
                    imgurl: null,
                  )),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Get.bottomSheet(
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: CustomText(
                            txt: 'Cancel',
                            fSize: 20,
                            txtColor: priColor,
                          ),
                        ),
                        CustomText(
                          txt: 'Write a Review',
                          fSize: 20,
                        ),
                        GestureDetector(
                          child: CustomText(
                            txt: 'Send',
                            fSize: 20,
                            txtColor: priColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    Container(
                      width: 140,
                      height: 30,
                      child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, x) => Icon(
                                Icons.star,
                                size: 20,
                                color: x == 0 ? priColor : Colors.grey[300],
                              ),
                          separatorBuilder: (context, x) => SizedBox(
                                width: 10,
                              )),
                    ),
                    CustomText(
                      txt: 'Tap a Star to Rate',
                    ),
                    Divider(),
                    Expanded(
                      child: TextFormField(
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        onSaved: (val) => null,
                        validator: (val) => null,
                        decoration: InputDecoration(
                            hintText: 'Review',
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)))),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(Icons.message),
              SizedBox(
                width: 10,
              ),
              CustomText(
                txt: 'Write Review',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
