import 'package:ecommerce/core/viewModel/authViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      builder: (controller) => Center(
          child: MaterialButton(
        onPressed: () => controller.logout(),
        child: Text('Logout'),
      )),
    );
  }
}
