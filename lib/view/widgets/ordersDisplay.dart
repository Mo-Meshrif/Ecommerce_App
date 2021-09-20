import '../../const.dart';
import 'customText.dart';
import '../../core/viewModel/cartViewModel.dart';
import '../../model/orderModel.dart';
import '../../view/subViews/orderView/trackOrderView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersDisplay extends StatelessWidget {
  final List<OrderModel> specOrders;
  final CartViewModel cartController;

  OrdersDisplay({@required this.specOrders, @required this.cartController});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        itemCount: specOrders.length,
        itemBuilder: (context, i) => GestureDetector(
              onTap: () => Get.to(
                () => TrackOrderView(
                  order: specOrders[i],
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txt: 'Order#:' +
                                    ' ' +
                                    specOrders[i].orderNumber.toString(),
                                fSize: 18,
                              ),
                              CustomText(
                                txt: DateFormat('yyyy-MM-dd, hh:mm a')
                                    .format(specOrders[i]
                                        .orderTrack[0]['createdAt']
                                        .toDate())
                                    .toString(),
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: specOrders[i].items.length >= 3
                                ? 150
                                : (specOrders[i].items.length * 50).toDouble(),
                            child: GridView.builder(
                              itemCount: specOrders[i].items.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          specOrders[i].items.length >= 3
                                              ? 3
                                              : specOrders[i].items.length),
                              itemBuilder: (context, x) => Image.network(
                                specOrders[i].items[x]['imgUrl'],
                                height: 35,
                                width: 35,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txt: specOrders[i].status,
                            txtColor: priColor,
                          ),
                          Row(
                            children: [
                              CustomText(
                                txt: specOrders[i].rate != null
                                    ? 'You Rated'
                                    : 'Rating',
                              ),
                              SizedBox(width: 5),
                              RatingBar.builder(
                                initialRating: specOrders[i].rate ?? 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: priColor,
                                ),
                                onRatingUpdate: (rating) =>
                                    cartController.getOrderRate(
                                  specOrders[i].orderId,
                                  rating,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
