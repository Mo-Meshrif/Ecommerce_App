import '../../../../const.dart';
import '../../../../model/orderModel.dart';
import '../../../../view/widgets/customText.dart';
import '../../../../view/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class TrackOrderView extends StatelessWidget {
  final OrderModel order;
  TrackOrderView({@required this.order});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Track Order',
        backFun: () => Get.back(),
      ),
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txt: 'Order#:' + ' ' + order.orderNumber.toString(),
                fSize: 18,
              ),
              Divider(color: Colors.grey),
              Expanded(
                  child: Center(
                child: FixedTimeline.tileBuilder(
                  mainAxisSize: MainAxisSize.min,
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    color: Color(0xff989898),
                    indicatorTheme: IndicatorThemeData(
                      position: 0,
                      size: 20.0,
                    ),
                    connectorTheme: ConnectorThemeData(
                      thickness: 2.5,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: order.orderTrack.length,
                    contentsBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 50),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                txt: order.orderTrack[index]['title'],
                                fSize: 18,
                                txtColor:
                                    order.orderTrack[index]['status'] == true
                                        ? null
                                        : Colors.grey,
                              ),
                              order.orderTrack[index]['createdAt'] != null
                                  ? CustomText(
                                      txt: order.orderTrack[index]['subTitle'] +
                                          ' ' +
                                          DateFormat('yyyy-MM-dd')
                                              .format(order.orderTrack[index]
                                                      ['createdAt']
                                                  .toDate())
                                              .toString(),
                                      maxLine: 2,
                                      txtColor: Colors.grey,
                                    )
                                  : order.orderTrack[index]['subTitle'] !=
                                          'We has been confirmed on'
                                      ? CustomText(
                                          txt: order.orderTrack[index]
                                              ['subTitle'],
                                          maxLine: 2,
                                          txtColor: Colors.grey,
                                        )
                                      : CustomText(
                                          txt: order.orderTrack[index]
                                                  ['subTitle'] +
                                              ' .....',
                                          maxLine: 2,
                                          txtColor: Colors.grey,
                                        ),
                            ]),
                      );
                    },
                    indicatorBuilder: (_, index) {
                      if (order.orderTrack[index]['status'] == true) {
                        return DotIndicator(
                          size: 30,
                          color: priColor,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        );
                      } else {
                        return OutlinedDotIndicator(
                          size: 30,
                          borderWidth: 2.5,
                        );
                      }
                    },
                    connectorBuilder: (_, index, ___) => SolidLineConnector(
                      color: order.orderTrack[index]['status'] == true
                          ? priColor
                          : null,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
