import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../view/widgets/customText.dart';
import 'productsView.dart';

class SubCategories extends StatelessWidget {
  SubCategories({
    this.subCat,
    this.prods,
  });

  final String subCat;
  final List prods;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txt: subCat,
          fSize: 12,
          fWeight: FontWeight.w300,
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 15),
            itemCount: prods.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () => Get.to(() => ProductsView(prodsTxt: prods[i])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txt: prods[i],
                      fSize: 15,
                    ),
                    Image.asset('assets/home/right_arrow_c.png')
                  ],
                ),
              ),
            ),
            separatorBuilder: (_, i) => SizedBox(
              height: 20,
            ),
          ),
        )
      ],
    );
  }
}
