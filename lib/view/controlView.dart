import '../core/viewModel/authViewModel.dart';
import '../view/authView/authView.dart';
import '../view/homeView/homeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.user != null) ? HomeView() : AuthView());
  }
}
