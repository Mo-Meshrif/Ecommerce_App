import 'package:ecommerce/core/viewModel/authViewModel.dart';
import 'package:get/get.dart';
import '../../const.dart';
import '../subViews/authView/forgetPassView.dart';
import '../subViews/authView/signInView.dart';
import '../subViews/authView/signUpView.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AuthViewModel>(
          builder: (controller) => DefaultTabController(
            initialIndex: controller.currentIndex,
            length: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: priColor,
                    labelStyle: TextStyle(fontSize: 20),
                    indicatorColor: Colors.white10,
                    unselectedLabelColor: swatchColor,
                    tabs: [
                      Tab(text: 'Sign Up'),
                      Tab(text: 'Log In'),
                      Tab(text: 'Forgot Password'),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SignUpView(),
                        SignInView(),
                        ForgetPassView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
