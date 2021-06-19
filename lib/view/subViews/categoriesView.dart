import '../../core/viewModel/homeViewModel.dart';
import '../../model/categoryModel.dart';
import '../../const.dart';
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
      child: GetBuilder<HomeViewModel>(
        builder: (controller) {
          List<CategoryModel> categories = controller.categories;
          List<dynamic> subCategories =
              categories[controller.currentCategory].subCat;
          return Column(
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
                  child: Row(
                children: [
                  Container(
                    width: 84,
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      separatorBuilder: (_, i) => SizedBox(
                        height: 10,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (_, i) => GestureDetector(
                        onTap: () => controller.changeCategories(i),
                        child: CustomColTImage(
                          imgUrl: categories[i].imgUrl,
                          avatarCol: categories[i].avatarCol,
                          txt: categories[i].txt,
                          txtCol: categories[i].txt ==
                                  categories[controller.currentCategory].txt
                              ? priColor
                              : null,
                        ),
                      ),
                    ),
                  ),
                  subCategories.isEmpty
                      ? Padding(padding: EdgeInsets.all(0))
                      : Expanded(
                          child: SubCategories(
                            prods: subCategories,
                          ),
                        ),
                ],
              ))
            ],
          );
        },
      ),
    ));
  }
}
