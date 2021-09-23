import '../../../core/viewModel/cartViewModel.dart';
import '../../../model/orderModel.dart';
import '../../../view/widgets/customAppBar.dart';
import '../../../view/widgets/ordersDisplay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishedOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CartViewModel>().getOrders();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Finished Orders',
        backFun: () => Get.back(),
      ),
      body: GetBuilder<CartViewModel>(builder: (cartController) {
        List<OrderModel> specOrders = cartController.specOrders
            .where((element) => element.orderTrack[4]['status'] == true)
            .toList();
        return OrdersDisplay(
            specOrders: specOrders,
            cartController: cartController,
            ifNullState: 'You do not have any finished orders !');
      }),
    );
  }
}
