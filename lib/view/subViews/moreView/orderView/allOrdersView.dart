import '../../../../view/widgets/ordersDisplay.dart';
import '../../../../model/orderModel.dart';
import '../../../../core/viewModel/cartViewModel.dart';
import '../../../../view/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CartViewModel>().getOrders();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Orders',
        backFun: () => Get.back(),
      ),
      body: GetBuilder<CartViewModel>(
        builder: (cartController) {
          List<OrderModel> specOrders = cartController.specOrders;
          return OrdersDisplay(
              specOrders: specOrders,
              cartController: cartController,
              ifNullState: 'You do not have any orders !');
        },
      ),
    );
  }
}
