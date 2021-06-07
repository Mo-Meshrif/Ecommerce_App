import '../../const.dart';
import '../../view/subViews/categoriesView.dart';
import 'package:get/get.dart';
import '../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widgets/customColTImage.dart';
import '../widgets/customColumImgTT.dart';
import '../widgets/customStackImgTbutton.dart';
import '../widgets/customStackIcon.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => null,
                child: CustomStackIcon(
                  imageUrl: 'assets/home/Messages.png',
                  txtNum: '5',
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () => null,
                child: CustomStackIcon(
                  imageUrl: 'assets/home/notifications.png',
                  txtNum: '10',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            txt: 'Categories',
            fSize: 30,
            txtColor: HexColor('#515C6F'),
            fWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: InkResponse(
                  radius: 25,
                  onTap: () => null,
                  child: CustomColTImage(
                    imgUrl: 'assets/home/apparel.png',
                    txt: 'Apparel',
                    avatarCol: priColor,
                  ),
                ),
              ),
              Expanded(
                child: InkResponse(
                  radius: 25,
                  onTap: () => null,
                  child: CustomColTImage(
                    imgUrl: 'assets/home/beauty.png',
                    txt: 'Beauty',
                    avatarCol: HexColor('#76BAFF'),
                  ),
                ),
              ),
              Expanded(
                child: InkResponse(
                  radius: 25,
                  onTap: () => null,
                  child: CustomColTImage(
                    imgUrl: 'assets/home/shoes.png',
                    txt: 'Shoes',
                    avatarCol: HexColor('#2FC145'),
                  ),
                ),
              ),
              Expanded(
                child: InkResponse(
                  radius: 25,
                  onTap: () => Get.to(() => CategoriesView()),
                  child: CustomColTImage(
                    imgUrl: 'assets/home/right_arrow_h.png',
                    txt: 'See All',
                    avatarCol: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            txt: 'Latest',
            fSize: 30,
            txtColor: HexColor('#515C6F'),
            fWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10,
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: null,
                  child: CustomColumImgTT(
                    imgUrl: 'assets/home/women_shoes.png',
                    txt1: 'Ankle Boots',
                    txt2: '\$49.99',
                  ),
                ),
                GestureDetector(
                  onTap: null,
                  child: CustomColumImgTT(
                    imgUrl: 'assets/home/backpack.png',
                    txt1: 'Backpack',
                    txt2: '\$20.58',
                  ),
                ),
                GestureDetector(
                  onTap: null,
                  child: CustomColumImgTT(
                    imgUrl: 'assets/home/scarf.png',
                    txt1: 'Red Scarf',
                    txt2: '\$11.00',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
