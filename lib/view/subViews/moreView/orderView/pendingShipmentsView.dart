import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/viewModel/moreViewModel.dart';
import '../../../../view/widgets/ordersDisplay.dart';
import '../../../../model/orderModel.dart';
import '../../../../view/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingShipmentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pending Shipments',
        backFun: () => Get.back(),
      ),
      body: GetBuilder<MoreViewModel>(
        builder: (moreController) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              List<DocumentSnapshot> ordersSnap =
                  snapshot.hasData ? (snapshot.data as QuerySnapshot).docs : [];
              List<OrderModel> specOrders = ordersSnap
                  .map((e) => OrderModel.fromJson(
                      e.id, e.data() as Map<String, dynamic>))
                  .where((order) =>
                      order.customerId == moreController.savedUser!.id &&
                      order.orderTrack![4]['status'] == false)
                  .toList();
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : OrdersDisplay(
                      specOrders: specOrders,
                    );
            },
          );
        },
      ),
    );
  }
}
