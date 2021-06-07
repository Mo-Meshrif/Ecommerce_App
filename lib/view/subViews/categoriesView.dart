import '../../const.dart';
import '../../core/viewModel/categoriesViewModel.dart';
import '../../view/subViews/subCategories.dart';
import '../../view/widgets/customColTImage.dart';
import '../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.close),
              onPressed: () => Get.back(),
              color: priColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: CustomText(
              txt: 'All Categories',
              fSize: 30,
              fWeight: FontWeight.bold,
              txtColor: swatchColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GetBuilder<CategoriesViewModel>(
              init: CategoriesViewModel(),
              builder: (controller) {
                List<Map<String, dynamic>> categories = controller.categories;
                int currentCategory = controller.currentCategory;
                Map<String, dynamic> subCats =
                    categories[currentCategory]['sub-cat'];
                return Row(
                  children: [
                    Container(
                      width: 84,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        separatorBuilder: (_, i) => SizedBox(
                          height: 10,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (_, i) => GestureDetector(
                          onTap: () => controller.changeCategories(i),
                          child: CustomColTImage(
                            imgUrl: categories[i]['imgUrl'],
                            avatarCol: categories[i]['avatarCol'],
                            txt: categories[i]['txt'],
                            txtCol: categories[i]['id'] == currentCategory
                                ? priColor
                                : null,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              child: SubCategories(
                                subCat:
                                    subCats['s'].isEmpty ? '' : subCats['s'][0],
                                prods: subCats['c1'],
                              ),
                            ),
                          ),
                          Expanded(
                              child: Card(
                            child: SubCategories(
                              subCat:
                                  subCats['s'].isEmpty ? '' : subCats['s'][1],
                              prods: subCats['c2'],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
