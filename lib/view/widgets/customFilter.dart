import 'dart:ui';
import 'package:ecommerce/core/viewModel/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const.dart';
import 'customElevatedButton.dart';
import 'customR2TxtPopupMenu.dart';
import 'customText.dart';

class CustomFilter extends StatelessWidget {
  final bool fromCategoriesView;
  final List<String> avCategories, avConditions, avMaterials, avBrands;
  CustomFilter(
      {@required this.fromCategoriesView,
      this.avCategories,
      this.avConditions,
      this.avMaterials,
      this.avBrands});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Align(
        alignment: Alignment.topRight,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.all(20),
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txt: controller.filterCatTxt == null ||
                              controller.filterConditionTxt == null ||
                              controller.filterMaterialTxt == null ||
                              controller.filterBrandTxt == null
                          ? 'Choose your filters Please .........'
                          : 'REFINE RESULTS',
                      txtColor: swatchColor,
                      fWeight: FontWeight.w300,
                    ),
                    !controller.isFltered
                        ? Padding(padding: EdgeInsets.zero)
                        : GestureDetector(
                            onTap: () {
                              controller.clearFilters();
                              Get.back();
                            },
                            child: CustomText(
                              txt: 'CLEAR',
                              txtColor: priColor,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                CustomR2TxtPopupMenu(
                  txt1: 'Category',
                  txt2: fromCategoriesView
                      ? avCategories[0]
                      : controller.filterCatTxt,
                  popMenuItems: avCategories,
                  onSelected: (val) => controller.changeCatTxt(val),
                  enableState: fromCategoriesView ? false : true,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomR2TxtPopupMenu(
                  txt1: 'Condition',
                  txt2: controller.filterConditionTxt,
                  popMenuItems: avConditions,
                  onSelected: (val) => controller.changeConditionTxt(val),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomR2TxtPopupMenu(
                  txt1: 'Material',
                  txt2: controller.filterMaterialTxt,
                  popMenuItems: avMaterials,
                  onSelected: (val) => controller.changeMaterialTxt(val),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomR2TxtPopupMenu(
                  txt1: 'Brand',
                  txt2: controller.filterBrandTxt,
                  popMenuItems: avBrands,
                  onSelected: (val) => controller.changeBrandTxt(val),
                ),
                (fromCategoriesView
                            ? avCategories.length == 0
                            : controller.filterCatTxt == null) ||
                        controller.filterConditionTxt == null ||
                        controller.filterMaterialTxt == null ||
                        controller.filterBrandTxt == null
                    ? Padding(padding: EdgeInsets.zero)
                    : Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 200,
                            child: CustomElevatedButton(
                              txt: 'APPLY FILTERS',
                              imgUrl: 'assets/auth/right_arrow.png',
                              onPress: () => controller.changeFilterState(true),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
