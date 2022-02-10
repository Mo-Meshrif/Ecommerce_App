import 'package:cached_network_image/cached_network_image.dart';
import '../../helper/goTransittedPage.dart';
import '../../const.dart';
import 'customText.dart';
import '../../core/viewModel/cartViewModel.dart';
import '../../model/orderModel.dart';
import '../../view/subViews/moreView/orderView/trackOrderView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class OrdersDisplay extends StatelessWidget {
  final String ifNullState;
  final List<OrderModel> specOrders;
  final CartViewModel cartController;

  OrdersDisplay(
      {@required this.specOrders,
      @required this.cartController,
      @required this.ifNullState});
  @override
  Widget build(BuildContext context) {
    Future<bool> callme() async {
      await Future.delayed(Duration(milliseconds: 500));
      return true;
    }

    return FutureBuilder(
        future: callme(),
        builder: (context, snap) {
          if (snap.data == true) {
            return specOrders.isEmpty
                ? Center(
                    child: CustomText(
                      txt: ifNullState,
                      fSize: 20,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    itemCount: specOrders.length,
                    itemBuilder: (context, i) => GestureDetector(
                          onTap: () => Go.to(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            txt: 'Order#:' +
                                                ' ' +
                                                specOrders[i]
                                                    .orderNumber
                                                    .toString(),
                                            fSize: 18,
                                          ),
                                          CustomText(
                                            txt: DateFormat(
                                                    'yyyy-MM-dd, hh:mm a')
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
                                            ? 120
                                            : (specOrders[i].items.length * 40)
                                                .toDouble(),
                                        child: GridView.builder(
                                          itemCount: specOrders[i].items.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: specOrders[i]
                                                              .items
                                                              .length >=
                                                          3
                                                      ? 3
                                                      : specOrders[i]
                                                          .items
                                                          .length),
                                          itemBuilder: (context, x) =>
                                              CachedNetworkImage(
                                            height: 35,
                                            width: 35,
                                            placeholder: (_, __) => Image.asset(
                                              'assets/shop/place_holder.jpg',
                                              height: 35,
                                              width: 35,
                                            ),
                                            imageUrl: specOrders[i].items[x]
                                                ['imgUrl'],
                                            errorWidget: (context, error,
                                                    stackTrace) =>
                                                Image.asset(
                                                    'assets/shop/place_holder.jpg'),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            initialRating:
                                                specOrders[i].rate ?? 0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
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
          return Center(
              child: CircularProgressIndicator(
            color: priColor,
          ));
        });
  }
}
