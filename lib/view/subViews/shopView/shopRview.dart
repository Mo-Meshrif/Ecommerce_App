import 'package:ecommerce/view/widgets/reviews.dart';
import 'package:flutter/material.dart';

class ShopRview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: 5,
        itemBuilder: (context, i) => Reviews(
              fromProductDetails: false,
              name: 'Mohamed Meshrif',
              date: '10 Oct, 2018',
              reviewDetails:
                  'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit,\nsed do eiusmod tempor incididunt',
              imgurl:
                  'https://firebasestorage.googleapis.com/v0/b/ecommerce-77e2d.appspot.com/o/T-shirtsa.png?alt=media&token=6e674bf1-a91a-4c6f-aa87-32578805f174',
            ));
  }
}
