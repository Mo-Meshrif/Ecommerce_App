import '../../../const.dart';
import '../../../view/widgets/customColumImgTT.dart';
import '../../../view/widgets/customStackImgTbutton.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';

class ShopHview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txt: 'Trending',
            txtColor: swatchColor,
            fSize: 30,
            fWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, i) => GestureDetector(
                onTap: null,
                child: CustomStackImgTbutton(
                  imgUrl: 'assets/home/banner.png',
                  txt: 'For all your \nsummer clothing \nneeds',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 6,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, i) => Card(
                child: Center(
                  child: CustomColumImgTT(
                    imgUrl: 'assets/home/backpack.png',
                    txt1: 'Backpack',
                    txt2: '\$20.58',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
