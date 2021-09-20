import '../../../core/viewModel/cartViewModel.dart';
import '../../../model/orderModel.dart';
import '../../../view/widgets/customAppBar.dart';
import '../../../view/widgets/customText.dart';
import '../../../view/widgets/ordersDisplay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingShipmentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CartViewModel>().getOrders();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pending Shipments',
        backFun: () => Get.back(),
      ),
      body: GetBuilder<CartViewModel>(builder: (cartController) {
        List<OrderModel> specOrders = cartController.specOrders
            .where((element) => element.orderTrack[4]['status'] == false)
            .toList();
        return specOrders.isEmpty
            ? Center(
                child: CustomText(
                  txt: 'You do not have any finished orders !',
                  fSize: 20,
                ),
              )
            : OrdersDisplay(
                specOrders: specOrders,
                cartController: cartController,
              );
      }),
    );
  }
}
