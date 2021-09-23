import '../../../view/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RateOurAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Rate Our App',
          backFun: () => Get.back(),
        ),
        body: null);
  }
}
