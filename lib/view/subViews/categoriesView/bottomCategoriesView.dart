import '../../../core/viewModel/homeViewModel.dart';
import '../../../model/categoryModel.dart';
import '../../../view/subViews/subCategories.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomCategoriesView extends StatelessWidget {
  final int currentIndex;
  BottomCategoriesView({@required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
      child: GetBuilder<HomeViewModel>(
        builder: (controller) {
          List<CategoryModel> categories = controller.categories;
          Map<String, dynamic> subCategories = categories[currentIndex].subCat;
          List<Widget> children = <Widget>[];
          for (var i = 0; i < subCategories['s'].length; i++) {
            children.add(
              new Expanded(
                child: SubCategories(
                  subCat: subCategories['s'][i],
                  prods: subCategories['s' + i.toString()],
                ),
              ),
            );
          }
          return Column(
            children: [
              subCategories['s'][0].isEmpty
                  ? Expanded(
                      child: Center(
                      child: CustomText(
                        txt: 'Comming Soon !',
                      ),
                    ))
                  : Expanded(
                      child: Column(
                      children: children,
                    )),
            ],
          );
        },
      ),
    );
  }
}
