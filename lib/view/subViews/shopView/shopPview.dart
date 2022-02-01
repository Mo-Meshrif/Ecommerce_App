import '../../../model/categoryModel.dart';
import '../../../model/productModel.dart';
import '../../../view/subViews/productDetails/productDetails.dart';
import '../../../view/subViews/productsView.dart';
import '../../../view/widgets/customColumImgTT.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const.dart';

class ShopPview extends StatelessWidget {
  final CategoryModel cat;
  final List<ProductModel> products;
  ShopPview({
    @required this.cat,
    @required this.products,
  });
  @override
  Widget build(BuildContext context) {
    List<dynamic> subCat = [];
    for (var i = 0; i < cat.subCat['s'].length; i++) {
      subCat.addAll(cat.subCat['s' + i.toString()]);
    }
    List<dynamic> subCatWithoutRepeated = subCat.toSet().toList();
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: ListView.separated(
            padding: EdgeInsets.all(0),
            separatorBuilder: (context, i) => SizedBox(
                  height: 4,
                ),
            itemCount: subCatWithoutRepeated.length,
            itemBuilder: (context, i) {
              List shopProducts = products
                  .where((prod) =>
                      prod.classification['sub-cat'] ==
                      subCatWithoutRepeated[i])
                  .toList();
              int index = products.indexWhere((prods) =>
                  prods.classification['sub-cat'] == subCatWithoutRepeated[i]);
              return index >= 0
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              txt: subCatWithoutRepeated[i],
                              txtColor: swatchColor,
                              fSize: 30,
                              fWeight: FontWeight.bold,
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => ProductsView(
                                    prodsTxt: subCatWithoutRepeated[i],
                                    fromCategoriesView: false,
                                    fromSearchView: false,
                                  )),
                              child: CustomText(
                                txt: 'SEE ALL',
                                txtColor: priColor,
                                fSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 140,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: shopProducts.length < 3
                                ? shopProducts.length
                                : 3,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 140,
                            ),
                            itemBuilder: (context, x) {
                              return GestureDetector(
                                onTap: () => Get.to(() => ProductDetails(
                                    prod: shopProducts[x],
                                    fromSearchView: false)),
                                child: Card(
                                  child: Center(
                                    child: CustomColumImgTT(
                                      imgUrl: shopProducts[x].imgUrl,
                                      txt1: shopProducts[x].prodName,
                                      txt2: '\$' + shopProducts[x].price,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : Padding(padding: EdgeInsets.all(0));
            }));
  }
}
