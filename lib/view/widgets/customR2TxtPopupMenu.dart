import 'package:flutter/material.dart';
import '../../const.dart';
import 'customText.dart';

class CustomR2TxtPopupMenu extends StatelessWidget {
  final txt1, txt2;
  final List<String?>? popMenuItems;
  final bool enableState;
  final void Function(dynamic)? onSelected;
  CustomR2TxtPopupMenu(
      {this.txt1,
      this.popMenuItems,
      this.onSelected,
      this.txt2,
      this.enableState = true});
  @override
  Widget build(BuildContext context) {
    String? nullTxt = popMenuItems!.length > 0 ? popMenuItems![0] : '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txt: txt1,
          txtColor: swatchColor,
        ),
        Row(
          children: [
            CustomText(
              txt: txt2 ?? nullTxt,
              txtColor: swatchColor,
              fWeight: FontWeight.w300,
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              child: PopupMenuButton(
                onSelected: onSelected,
                enabled: enableState,
                itemBuilder: (context) => popMenuItems!
                    .map(
                      (item) => PopupMenuItem(
                        child: Text(item!),
                        value: item,
                      ),
                    )
                    .toList(),
                child: enableState
                    ? Image.asset('assets/home/right_arrow_c.png')
                    : Padding(padding: EdgeInsets.only(left: 20)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
