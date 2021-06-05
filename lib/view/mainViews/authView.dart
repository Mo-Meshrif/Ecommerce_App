import '../subViews/forgetPassView.dart';
import '../subViews/signInView.dart';
import '../subViews/signUpView.dart';
import '../../core/viewModel/authViewModel.dart';
import '../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 15),
            child: GetBuilder<AuthViewModel>(
              init: AuthViewModel(),
              builder: (controller) => Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CustomText(
                          txt: 'Sign Up',
                          fSize: 30,
                          txtColor: controller.currentIndex == 0
                              ? Colors.black
                              : Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          txt: 'Log In',
                          fSize: 30,
                          txtColor: controller.currentIndex == 1
                              ? Colors.black
                              : Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          txt: 'Forgot Password',
                          txtColor: controller.currentIndex == 2
                              ? Colors.black
                              : Colors.grey,
                          fSize: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (value) => controller.getPageIndex(value),
                      children: [
                        SignUpView(),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SignInView(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ForgetPassView(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
