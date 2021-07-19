import 'package:ecommerce/model/productModel.dart';
import 'package:ecommerce/view/widgets/customText.dart';
import 'package:ecommerce/view/widgets/reviews.dart';
import 'package:flutter/material.dart';

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
          onTap: null,
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
