import '../../../../view/widgets/ordersDisplay.dart';
import '../../../../model/orderModel.dart';
import '../../../../core/viewModel/cartViewModel.dart';
import '../../../../view/widgets/customAppBar.dart';
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
            .where((element) => element.orderTrack![4]['status'] == false)
            .toList();
        return OrdersDisplay(
            specOrders: specOrders,
            cartController: cartController,
            ifNullState: 'You do not have any finished orders !');
      }),
    );
  }
}
