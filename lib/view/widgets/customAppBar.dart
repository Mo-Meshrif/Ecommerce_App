import 'package:flutter/material.dart';
import 'customText.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function backFun;

  CustomAppBar({required this.title, required this.backFun});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[50],
      title: CustomText(txt: title),
      centerTitle: true,
      leading: GestureDetector(
        child: Image.asset('assets/shop/back.png'),
        onTap: backFun as void Function()?,
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
