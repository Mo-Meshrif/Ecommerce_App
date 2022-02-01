import '../../core/viewModel/filterViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const.dart';
import 'customElevatedButton.dart';
import 'customR2TxtPopupMenu.dart';
import 'customText.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterViewModel>(
      builder: (controller) {
        List<String> avCategories = controller.avCategories.toSet().toList();
        List<String> avConditions = controller.avConditions.toSet().toList();
        List<String> avMaterials = controller.avMaterials.toSet().toList();
        List<String> avBrands = controller.avBrands.toSet().toList();
        return Container(
          margin: EdgeInsets.only(top: controller.fromSearch ? 110 : 80),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Drawer(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txt: 'REFINE RESULTS',
                        fSize: 15,
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
                          fSize: 15,
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
                    txt2: controller.selectedCategory,
                    popMenuItems: avCategories,
                    onSelected: (val) => controller.changeCatTxt(val),
                    enableState: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomR2TxtPopupMenu(
                    txt1: 'Condition',
                    txt2: controller.selectedCondition,
                    popMenuItems: avConditions,
                    onSelected: (val) => controller.changeConditionTxt(val),
                    enableState: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomR2TxtPopupMenu(
                    txt1: 'Material',
                    txt2: controller.selectedMaterial,
                    popMenuItems: avMaterials,
                    onSelected: (val) => controller.changeMaterialTxt(val),
                    enableState: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomR2TxtPopupMenu(
                    txt1: 'Brand',
                    txt2: controller.selectedBrand,
                    popMenuItems: avBrands,
                    onSelected: (val) => controller.changeBrandTxt(val),
                    enableState: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 200,
                    child: CustomElevatedButton(
                      txt: 'APPLY FILTERS',
                      imgUrl: 'assets/auth/right_arrow.png',
                      onPress: () => controller.applyFilters(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
