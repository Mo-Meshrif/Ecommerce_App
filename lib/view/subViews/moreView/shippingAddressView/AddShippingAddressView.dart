import 'package:get/get.dart';
import '../../../../view/widgets/customAppBar.dart';
import '../../../../core/viewModel/moreViewModel.dart';
import '../../../../model/shippingAddressModel.dart';
import '../../../../view/widgets/customPopMenuButton.dart';
import '../../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import '../../../../const.dart';

class AddShippingAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Address',
        backFun: () => Get.back(),
      ),
      body: GetBuilder<MoreViewModel>(
        builder: (moreController) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            key: moreController.shippingKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRowWidget(
                  title: 'Full Name',
                  widget: Container(
                    width: 170,
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'The Value is Empty';
                        }
                        return null;
                      },
                      onChanged: (val) => moreController.fullName = val,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        hintText: 'Full Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1),
                CustomRowWidget(
                  title: 'Mobile Number',
                  widget: Container(
                    width: 170,
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'The Value is Empty';
                        }
                        return null;
                      },
                      onChanged: (val) => moreController.mobileNumber = val,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        hintText: 'Mobile Number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1),
                CustomRowWidget(
                  title: 'State',
                  widget: Container(
                    width: 170,
                    child: CustomPopUpMenuButton(
                      title: moreController.state,
                      popList: states,
                      onSelected: (val) => moreController.getState(val),
                      enabled: true,
                    ),
                  ),
                ),
                Divider(thickness: 1),
                CustomRowWidget(
                  title: 'City',
                  widget: Container(
                    width: 170,
                    child: CustomPopUpMenuButton(
                      title: moreController.city,
                      popList: cities[moreController.state!],
                      onSelected: (val) => moreController.getCity(val),
                      enabled:
                          moreController.state == 'Select State' ? false : true,
                    ),
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                CustomText(
                  txt: 'Street',
                  fSize: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'The Value is Empty';
                    }
                    return null;
                  },
                  onChanged: (val) => moreController.street = val,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    hintText: 'Street',
                    border: InputBorder.none,
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textStyle: const TextStyle(fontSize: 20),
                        primary: priColor,
                      ),
                      onPressed: () {
                        moreController.shippingKey.currentState!.save();
                        if (moreController.shippingKey.currentState!
                            .validate()) {
                          moreController.addAddress(
                            ShippingAddressModel(
                              fullName: moreController.fullName!.capitalize,
                              mobileNumber: moreController.mobileNumber,
                              state: moreController.state,
                              city: moreController.city,
                              street: moreController.street!.capitalize,
                              isSelected: 1,
                            ),
                          );
                        }
                      },
                      child: CustomText(
                        txt: 'Add Address',
                        txtColor: Colors.white,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  final String title;
  final Widget widget;

  CustomRowWidget({required this.title, required this.widget});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txt: title,
          fSize: 20,
        ),
        widget
      ],
    );
  }
}
