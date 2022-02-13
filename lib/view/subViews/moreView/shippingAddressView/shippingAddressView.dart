import '../../../../helper/goTransittedPage.dart';
import '../../../../view/subViews/moreView/shippingAddressView/AddShippingAddressView.dart';
import '../../../../model/shippingAddressModel.dart';
import '../../../../core/viewModel/moreViewModel.dart';
import 'package:get/get.dart';
import '../../../widgets/customText.dart';
import 'package:flutter/material.dart';
import '../../../widgets/customAppBar.dart';

class ShippingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreViewModel>(
      builder: (moreController) {
        List<ShippingAddressModel> shippingList =
            moreController.shippingList!.reversed.toList();
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Shipping Address',
            backFun: () => Get.back(),
          ),
          body: SingleChildScrollView(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete, color: Colors.white),
                                      Text('Delete',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                onDismissed: (_) =>
                                    moreController.deleteOneShipping(e.id),
                                child: Container(
                                  height: 175,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                txt: e.fullName,
                                                fSize: 17,
                                                fWeight: FontWeight.bold,
                                              ),
                                              GestureDetector(
                                                onTap: () => moreController
                                                    .updateSelectedShippingParameter(
                                                        e.id),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: e.isSelected == 1
                                                          ? Colors.blue
                                                          : Colors.white,
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: CustomText(
                                              txt: e.mobileNumber,
                                            ),
                                            horizontalTitleGap: 2,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.location_on),
                                            title: CustomText(
                                              txt: e.street! +
                                                  ',' +
                                                  e.city! +
                                                  ',' +
                                                  e.state!,
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
                                ),
                              ))
                          .toList()),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () => Go.to(
                      () => AddShippingAddressView(),
                    ),
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
          ),
        );
      },
    );
  }
}
