import '../../../../core/viewModel/moreViewModel.dart';
import '../../../../model/shippingAddressModel.dart';
import '../../../../view/widgets/customPopMenuButton.dart';
import '../../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import '../../../../const.dart';

class AddShippingAddressView extends StatelessWidget {
  final MoreViewModel moreController;

  AddShippingAddressView({@required this.moreController});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    if (val.isEmpty) {
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
            Divider(),
            CustomRowWidget(
              title: 'Mobile Number',
              widget: Container(
                width: 170,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
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
            Divider(),
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
            Divider(),
            CustomRowWidget(
              title: 'City',
              widget: Container(
                width: 170,
                child: CustomPopUpMenuButton(
                  title: moreController.city,
                  popList: cities[moreController.state],
                  onSelected: (val) => moreController.getCity(val),
                  enabled:
                      moreController.state == 'Select State' ? false : true,
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            CustomText(
              txt: 'Street',
              fSize: 20,
            ),
            TextFormField(
              validator: (val) {
                if (val.isEmpty) {
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
            Divider(),
            moreController.shippingList.isNotEmpty
                ? Column(
                    children: [
                      CustomRowWidget(
                        title: 'Set as default',
                        widget: Switch.adaptive(
                          value: moreController.isDef,
                          onChanged: (val) => moreController.getIsDef(val),
                          activeColor: priColor,
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 20),
                    ],
                  )
                : SizedBox(height: 20),
            Align(
              alignment: Alignment(0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(fontSize: 20),
                    primary: priColor,
                  ),
                  onPressed: () {
                    moreController.shippingKey.currentState.save();
                    if (moreController.shippingKey.currentState.validate()) {
                      moreController.addAddress(
                        ShippingAddressModel(
                          fullName: moreController.fullName,
                          mobileNumber: moreController.mobileNumber,
                          state: moreController.state,
                          city: moreController.city,
                          street: moreController.street,
                          isDef: moreController.isDef == true ||
                                  moreController.shippingList.isEmpty
                              ? 1
                              : 0,
                          isSelected: 0,
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
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  final String title;
  final Widget widget;

  CustomRowWidget({@required this.title, @required this.widget});
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
