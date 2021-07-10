import 'package:ecommerce/view/widgets/quantityChanger.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../model/cartProductModel.dart';
import '../../const.dart';
import 'customText.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    @required this.cartProd,
    @required this.increase,
    @required this.decrease,
    @required this.onDismiss,
  });

  final CartProductModel cartProd;
  final void Function() increase, decrease;
  final void Function(DismissDirection) onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartProd.id),
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
        height: 110,
        child: Row(
          children: [
            CircleAvatar(
              child: Image.network(
                cartProd.imgUrl,
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
                      txt: cartProd.size + ' ,',
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
                        color: HexColor(cartProd.color),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                  txt: '\$' + cartProd.price,
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
    );
  }
}
