import 'package:ecommerce/view/authView/authView.dart';
import 'package:ecommerce/view/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () => Get.to(() => AuthView()),
          child: CustomText(
            txt: 'Logout',
            fSize: 25,
          ),
        ),
      ),
    );
  }
}
