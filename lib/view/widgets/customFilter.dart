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
                      txt: 'REFINE RESULTS',
                      txtColor: swatchColor,
                      fWeight: FontWeight.w300,
                    ),
                    GestureDetector(
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
                !fromCategoriesView
                    ? CustomR2TxtPopupMenu(
                        txt1: 'Category',
                        txt2: controller.filterCatTxt,
                        popMenuItems: avCategories,
                        onSelected: (val) => controller.changeCatTxt(val),
                      )
                    : Padding(padding: EdgeInsets.zero),
                !fromCategoriesView
                    ? SizedBox(
                        height: 30,
                      )
                    : Padding(padding: EdgeInsets.zero),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}