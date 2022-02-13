import 'package:cached_network_image/cached_network_image.dart';
import '/responsive.dart';
import '/view/widgets/quantityChanger.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../model/cartProductModel.dart';
import '../../const.dart';
import 'customText.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    required this.cartProd,
    required this.increase,
    required this.decrease,
    required this.onDismiss,
    required this.fromCheckoutView,
  });

  final CartProductModel cartProd;
  final void Function() increase, decrease;
  final void Function(DismissDirection)? onDismiss;
  final bool fromCheckoutView;
  @override
  Widget build(BuildContext context) {
    return fromCheckoutView
        ? Responsive(
            builder: (context, deviceInfo) => Container(
              height: deviceInfo.widgetScaleFactor! * 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: cartProd.imgUrl!,
                      height: 50,
                      width: 50,
                    ),
                    backgroundColor: Colors.white,
                    radius: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        CustomText(
                          txt: cartProd.name,
                          fSize: 15,
                          txtColor: HexColor('#515C6F'),
                          fWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CustomText(
                              txt: cartProd.size! + ' ,',
                              fSize: 15,
                              txtColor: HexColor('#515C6F'),
                              fWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: HexColor(cartProd.color!),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              txt: '\$' + cartProd.price!,
                              fSize: 15,
                              txtColor: priColor,
                              fWeight: FontWeight.normal,
                            ),
                            QuantityChanger(
                              add: increase,
                              minimize: decrease,
                              quantityVal: cartProd.quantity,
                              fromProdDetails: false,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Responsive(
            builder: (context, deviceInfo) => Dismissible(
              key: Key(cartProd.id!),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    Text('Delete', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              onDismissed: onDismiss,
              child: Container(
                height: deviceInfo.widgetScaleFactor! * 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: CachedNetworkImage(
                        imageUrl: cartProd.imgUrl!,
                        height: 70,
                        width: 70,
                      ),
                      backgroundColor: Colors.white,
                      radius: 60,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        CustomText(
                          txt: cartProd.name,
                          fSize: 15,
                          txtColor: HexColor('#515C6F'),
                          fWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CustomText(
                              txt: cartProd.size! + ' ,',
                              fSize: 15,
                              txtColor: HexColor('#515C6F'),
                              fWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: HexColor(cartProd.color!),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          txt: '\$' + cartProd.price!,
                          fSize: 15,
                          txtColor: priColor,
                          fWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        QuantityChanger(
                          add: increase,
                          minimize: decrease,
                          quantityVal: cartProd.quantity,
                          fromProdDetails: false,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
