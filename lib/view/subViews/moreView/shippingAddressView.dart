import '../../../model/shippingAddressModel.dart';
import '../../../core/viewModel/moreViewModel.dart';
import 'package:get/get.dart';
import '../../../const.dart';
import '../../../view/widgets/customPopMenuButton.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import '../../widgets/customAppBar.dart';

class ShippingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreViewModel>(
      init: Get.find(),
      builder: (moreController) {
        List<ShippingAddressModel> shippingList =
            moreController.shippingList.reversed.toList();
        return Scaffold(
          appBar: CustomAppBar(
            title: !moreController.isAdd.value
                ? 'Shipping Address'
                : 'Add Address',
            backFun: () => moreController.isAdd.value
                ? moreController.changeShippingState(false)
                : Get.back(),
          ),
          body: !moreController.isAdd.value
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            children: shippingList
                                .map((e) => Dismissible(
                                      key: Key(e.id.toString()),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(right: 20),
                                        color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete,
                                                color: Colors.white),
                                            Text('Delete',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      onDismissed: (_) => moreController
                                          .deleteOneShipping(e.id),
                                      child: GestureDetector(
                                        onTap: () => moreController
                                            .updateSelectedParameter(e.id),
                                        child: Container(
                                          height: 170,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 18,
                                                vertical: 20,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        txt: e.fullName,
                                                        fSize: 17,
                                                        fWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => moreController
                                                            .updateDefParameter(
                                                                e.id),
                                                        child: CustomText(
                                                          txt: e.isDef == 0
                                                              ? 'Default'
                                                              : '',
                                                          fSize: 17,
                                                          txtColor: priColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  ListTile(
                                                    leading: Icon(Icons.phone),
                                                    title: CustomText(
                                                      txt: e.mobileNumber,
                                                    ),
                                                    trailing: e.isSelected == 1
                                                        ? Icon(Icons.check)
                                                        : null,
                                                    horizontalTitleGap: 2,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                  ),
                                                  ListTile(
                                                    leading:
                                                        Icon(Icons.location_on),
                                                    title: CustomText(
                                                      txt: e.street +
                                                          ',' +
                                                          e.city +
                                                          ',' +
                                                          e.state,
                                                    ),
                                                    visualDensity:
                                                        VisualDensity(
                                                      vertical: -4,
                                                    ),
                                                    horizontalTitleGap: 2,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () => moreController.changeShippingState(true),
                          child: Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 40,
                              ),
                              CustomText(
                                txt: 'Add New Address',
                                fSize: 17,
                              )
                            ],
                          )),
                        ),
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRowWidget(
                        title: 'Full Name',
                        widget: Container(
                          width: 170,
                          child: TextFormField(
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
                            onChanged: (val) =>
                                moreController.mobileNumber = val,
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
                            popList: ['Cairo', 'Dakh'],
                            onSelected: (val) => moreController.getState(val),
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
                            popList: ['Cairo', 'Dakh'],
                            onSelected: (val) => moreController.getCity(val),
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
                        onChanged: (val) => moreController.street = val,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5),
                          hintText: 'Street',
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(),
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
                      Align(
                        alignment: Alignment(0, 0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textStyle: const TextStyle(fontSize: 20),
                              primary: priColor,
                            ),
                            onPressed: () => moreController.addAddress(
                                  ShippingAddressModel(
                                    fullName: moreController.fullName,
                                    mobileNumber: moreController.mobileNumber,
                                    state: moreController.state,
                                    city: moreController.city,
                                    street: moreController.street,
                                    isDef: moreController.isDef == true ? 1 : 0,
                                    isSelected: 0,
                                  ),
                                ),
                            child: CustomText(
                              txt: 'Add Address',
                              txtColor: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
        );
      },
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
