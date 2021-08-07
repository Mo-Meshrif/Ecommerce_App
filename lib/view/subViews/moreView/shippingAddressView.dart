import '../../../core/viewModel/cartViewModel.dart';
import 'package:get/get.dart';
import '../../../const.dart';
import '../../../view/widgets/customPopMenuButton.dart';
import '../../../view/widgets/customText.dart';
import 'package:flutter/material.dart';
import '../../widgets/customAppBar.dart';

class ShippingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List shippingList = [1];
    return GetBuilder<CartViewModel>(
      builder: (cartController) => Scaffold(
        appBar: CustomAppBar(
          title:
              !cartController.isAdd.value ? 'Shipping Address' : 'Add Address',
          backFun: () => cartController.isAdd.value
              ? cartController.changeShippingState(false)
              : Get.back(),
        ),
        body: !cartController.isAdd.value
            ? Column(
                children: [
                  SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          children: shippingList
                              .map((e) => Container(
                                    height: 170,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
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
                                                  txt: 'Mohamed Meshrif',
                                                  fSize: 17,
                                                  fWeight: FontWeight.bold,
                                                ),
                                                CustomText(
                                                  txt: 'Default',
                                                  fSize: 17,
                                                  txtColor: priColor,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            ListTile(
                                              leading: Icon(Icons.phone),
                                              title: CustomText(
                                                txt: '01027106902',
                                              ),
                                              trailing: Icon(Icons.check),
                                              horizontalTitleGap: 2,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.location_on),
                                              title: CustomText(
                                                txt: 'Aga',
                                              ),
                                              visualDensity: VisualDensity(
                                                vertical: -4,
                                              ),
                                              horizontalTitleGap: 2,
                                              contentPadding: EdgeInsets.zero,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList())),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 170,
                    width: size.width,
                    child: GestureDetector(
                      onTap: () => cartController.changeShippingState(true),
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
                          title: 'Select State',
                          popList: ['Cairo', 'Dakh'],
                          onSelected: (val) => null,
                        ),
                      ),
                    ),
                    Divider(),
                    CustomRowWidget(
                      title: 'City',
                      widget: Container(
                        width: 170,
                        child: CustomPopUpMenuButton(
                          title: 'Select State',
                          popList: ['Cairo', 'Dakh'],
                          onSelected: (val) => null,
                        ),
                      ),
                    ),
                    Divider(),
                    CustomText(
                      txt: 'Street',
                      fSize: 20,
                    ),
                    TextFormField(
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
                        value: false,
                        onChanged: (val) => null,
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
                          onPressed: () => null,
                          child: CustomText(
                            txt: 'Add Address',
                            txtColor: Colors.white,
                          )),
                    )
                  ],
                ),
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
